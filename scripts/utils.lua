local UEHelpers = require("UEHelpers")

function log(message)
  print("[LeyakNoMore] " .. message)
end

function sendWarningMessage(message, level)
  local playerController = FindFirstOf("Abiotic_PlayerController_C")

  playerController.PlayerHUDRef:DisplayWarningMessage(FText(message), level)
end

function isDebug()
  return false
end

return {
  log = log,
  sendWarningMessage = sendWarningMessage,
  isDebug = isDebug
}
