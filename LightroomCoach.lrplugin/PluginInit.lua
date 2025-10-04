local LrTasks = import 'LrTasks'
local ChatDialog = require 'ChatDialog'

local function openCoach()
  LrTasks.startAsyncTask(function()
    ChatDialog.present()
  end)
end

return openCoach