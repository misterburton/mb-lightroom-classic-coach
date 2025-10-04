local LrView = import 'LrView'
local LrPrefs = import 'LrPrefs'

return function(f)
  local prefs = LrPrefs.prefsForPlugin()
  return f:row {
    spacing = f:control_spacing(),
    f:static_text { title = "OpenAI API Key:" },
    f:edit_field {
      value = LrView.bind("openai_api_key"),
      width_in_chars = 40,
      immediate = true,
      bind_to_object = prefs
    }
  }
end