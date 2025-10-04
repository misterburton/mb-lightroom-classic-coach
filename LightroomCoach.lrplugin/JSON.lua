-- Lightweight JSON encode/decode (dkjson-style minimal)
-- Source: public domain / MIT, simplified

local JSON = {}

-- Encode table to JSON (basic types only)
function JSON.encode(val)
  local t = type(val)
  if t == "nil" then
    return "null"
  elseif t == "boolean" or t == "number" then
    return tostring(val)
  elseif t == "string" then
    return string.format('%q', val)
  elseif t == "table" then
    local isArray = true
    local maxIndex = 0
    for k,v in pairs(val) do
      if type(k) ~= "number" then isArray = false break end
      if k > maxIndex then maxIndex = k end
    end
    local items = {}
    if isArray then
      for i=1,maxIndex do
        table.insert(items, JSON.encode(val[i]))
      end
      return "[" .. table.concat(items, ",") .. "]"
    else
      for k,v in pairs(val) do
        table.insert(items, JSON.encode(k) .. ":" .. JSON.encode(v))
      end
      return "{" .. table.concat(items, ",") .. "}"
    end
  else
    return 'null'
  end
end

-- Decode JSON string (uses load; safe for simple plugin use)
function JSON.decode(str)
  local f, err = load("return " .. str:gsub('null','nil'):gsub('true','true'):gsub('false','false'))
  if not f then return nil, err end
  return f()
end

return JSON
