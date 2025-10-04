local LrDialogs = import 'LrDialogs'
local LrView = import 'LrView'

local ChatDialog = {}

function ChatDialog.present()
  local f = LrView.osFactory()
  local props = LrView.bindings.makePropertyTable(_G)
  props.userInput = ""

  local c = f:column {
    bind_to_object = props,
    spacing = f:control_spacing(),
    f:static_text { title = "Lightroom Coach (MVP scaffold)" },
    f:edit_field { value = LrView.bind("userInput"), width_in_chars = 30 },
    f:push_button { title = "Send", action = function() LrDialogs.message("You typed:", props.userInput) end }
  }

  LrDialogs.presentFloatingDialog(_PLUGIN, { title = "Lightroom Coach", contents = c })
end

return ChatDialog