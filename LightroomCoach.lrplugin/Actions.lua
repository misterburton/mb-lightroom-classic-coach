--[[----------------------------------------------------------------------------
Actions.lua
Parses and executes develop settings from AI responses

© 2025 misterburton
------------------------------------------------------------------------------]]

local LrApplication = import 'LrApplication'
local LrDialogs = import 'LrDialogs'
local LrTasks = import 'LrTasks'

local JSON = require 'JSON'
local Actions = {}

-- Store last action for undo
local lastAction = nil

-- Helper to unescape doubled-escaped strings from Gemini 3
-- e.g. {\"action\": \"apply\"} -> {"action": "apply"}
local function unescapeJSON(text)
  return text:gsub('\\"', '"'):gsub('\\n', '\n')
end

-- Extract JSON from text (handles code blocks, multiline raw JSON, and escaped JSON strings)
local function extractJSON(text)
  -- 1. Try exact decoding first (clean response)
  local success, result = pcall(JSON.decode, text)
  if success and result then return result end

  -- 2. Try exact decoding of UNESCAPED text (Handle Gemini 3 stringified JSON)
  -- This catches the case where the entire response is an escaped string
  local unescaped = unescapeJSON(text)
  success, result = pcall(JSON.decode, unescaped)
  if success and result then return result end

  -- 3. Code Block Strategy (Loop through all code blocks)
  for jsonBlock in text:gmatch("```json\n?(.-)```") do
    -- Try normal decode
    success, result = pcall(JSON.decode, jsonBlock)
    if success and result and result.action then return result end
    
    -- Try unescaped decode
    success, result = pcall(JSON.decode, unescapeJSON(jsonBlock))
    if success and result and result.action then return result end
  end
  
  for jsonBlock in text:gmatch("```\n?(.-)```") do
    success, result = pcall(JSON.decode, jsonBlock)
    if success and result and result.action then return result end
    
    success, result = pcall(JSON.decode, unescapeJSON(jsonBlock))
    if success and result and result.action then return result end
  end
  
  -- 4. Raw JSON Strategy (Brute force search for valid object)
  -- We search for the specific action pattern to isolate the correct object
  -- "action" *: *"apply_develop_settings" (handling optional backslashes)
  local actionPattern = 'action"[%s\\]*:[%s\\]*"apply_develop_settings"'
  local actionStart = text:find(actionPattern)
  
  if actionStart then
    -- Search backwards for the opening brace
    local braceCount = 0
    local startPos = nil
    for i = actionStart, 1, -1 do
      local char = text:sub(i, i)
      if char == "}" then braceCount = braceCount + 1 end
      if char == "{" then
        if braceCount == 0 then
          startPos = i
          break
        else
          braceCount = braceCount - 1
        end
      end
    end
    
    if startPos then
      -- Search forward for the closing brace
      braceCount = 0
      local endPos = nil
      for i = startPos, #text do
        local char = text:sub(i, i)
        if char == "{" and i ~= startPos then braceCount = braceCount + 1 end
        if char == "}" then
          if braceCount == 0 then
            endPos = i
            break
          else
            braceCount = braceCount - 1
          end
        end
      end
      
      if endPos then
        local jsonCand = text:sub(startPos, endPos)
        -- Try normal decode
        success, result = pcall(JSON.decode, jsonCand)
        if success and result then return result end
        
        -- Try unescaped decode
        success, result = pcall(JSON.decode, unescapeJSON(jsonCand))
        if success and result then return result end
      end
    end
  end
  
  -- 5. Fallback: Greedy match (only if single object likely)
  local startPos = text:find("{")
  local endPos = nil
  if startPos then
    -- Find last }
    for i = #text, startPos, -1 do
      if text:sub(i, i) == "}" then
        endPos = i
        break
      end
    end
  end
  
  if startPos and endPos then
    local rawJSON = text:sub(startPos, endPos)
    success, result = pcall(JSON.decode, rawJSON)
    if success and result then return result end
    
    success, result = pcall(JSON.decode, unescapeJSON(rawJSON))
    if success and result then return result end
  end
  
  return nil
end

-- Map friendly param names to Lightroom SDK names
local PARAM_MAP = {
  exposure = "Exposure2012",
  contrast = "Contrast2012",
  highlights = "Highlights2012",
  shadows = "Shadows2012",
  whites = "Whites2012",
  blacks = "Blacks2012",
  clarity = "Clarity2012",
  vibrance = "Vibrance",
  saturation = "Saturation",
  temperature = "Temperature",
  tint = "Tint"
}

-- Apply develop settings to selected photos
local function applyDevelopSettings(params)
  local catalog = LrApplication.activeCatalog()
  local photos = catalog:getTargetPhotos()
  
  if #photos == 0 then
    LrDialogs.message("No photos selected", "Please select photos to edit.", "info")
    return false
  end
  
  -- Check if photo is a valid type for develop settings
  local photo = photos[1]
  if photo:getRawMetadata("isVideo") then
    LrDialogs.message("Invalid photo", "Cannot apply develop settings to videos.", "info")
    return false
  end
  
  -- Store original settings for undo
  local originalSettings = {}
  for i, p in ipairs(photos) do
    originalSettings[i] = p:getDevelopSettings()
  end
  
  -- Map friendly names to SDK names
  local mappedParams = {}
  for key, value in pairs(params) do
    local sdkKey = PARAM_MAP[key] or key
    mappedParams[sdkKey] = value
  end
  
  -- Apply each setting individually so they appear as separate history entries
  local success = false
  for sdkKey, value in pairs(mappedParams) do
    catalog:withWriteAccessDo("Lightroom Coach: " .. sdkKey, function()
      for _, p in ipairs(photos) do
        p:applyDevelopSettings({[sdkKey] = value})
        success = true
      end
    end)
  end
  
  if not success then
    LrDialogs.message("Failed", "Could not apply settings to photo.", "critical")
    return false
  end
  
  -- Store for undo
  lastAction = {
    photos = photos,
    originalSettings = originalSettings
  }
  
  return true
end

-- Undo last action
function Actions.undo()
  if not lastAction then
    LrDialogs.message("Nothing to undo", "No recent actions to undo.", "info")
    return
  end
  
  local catalog = LrApplication.activeCatalog()
  catalog:withWriteAccessDo("Undo Lightroom Coach Settings", function()
    for i, photo in ipairs(lastAction.photos) do
      photo:applyDevelopSettings(lastAction.originalSettings[i])
    end
  end)
  
  lastAction = nil
  LrDialogs.message("Undone", "Previous edits have been reverted.", "info")
end

-- Main action handler - checks for actions in AI response
function Actions.maybePerform(responseText)
  local action = extractJSON(responseText)
  
  if not action or not action.action then
    return nil
  end
  
  if action.action == "apply_develop_settings" and action.params then
    LrTasks.startAsyncTask(function()
      local success = applyDevelopSettings(action.params)
      
      if success then
        -- Build confirmation message
        local settingsStr = ""
        for key, value in pairs(action.params) do
          settingsStr = settingsStr .. string.format("\n- %s: %s", key, tostring(value))
        end
        
        local result = LrDialogs.confirm(
          "Edits Applied",
          string.format("Applied the following settings:%s\n\nThese changes are logged in your history panel.", settingsStr),
          "Keep Changes",
          "Undo"
        )
        
        if result == "cancel" then
          Actions.undo()
        end
      end
    end)
    
    return true
  end
  
  return nil
end

return Actions
