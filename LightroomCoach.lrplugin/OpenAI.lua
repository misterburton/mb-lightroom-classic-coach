local LrHttp = import 'LrHttp'
local LrPrefs = import 'LrPrefs'

local json = require 'JSON'
local OpenAI = {}

function OpenAI.ask(question)
  local prefs = LrPrefs.prefsForPlugin()
  local apiKey = prefs.openai_api_key or ""
  if apiKey == "" then return { text = "No API key set." } end

  local body = json.encode({
    model = "gpt-5.1-mini",
    input = { { role = "user", content = question } },
    system = "You are Lightroom Coach, an expert on Adobe Lightroom Classic."
  })

  local response, hdrs = LrHttp.post(
    "https://api.openai.com/v1/responses",
    body,
    { { field="Content-Type", value="application/json" },
      { field="Authorization", value="Bearer " .. apiKey } }
  )

  return { text = response or "(no response)" }
end

return OpenAI