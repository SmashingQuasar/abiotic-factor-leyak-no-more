local UEHelpers = require("UEHelpers")

--- A simple helper function use to write in the console with a prefix.
--- @param message string
local function log(message)
  print("[LeyakNoMore] " .. message)
end

--- Helper that will display a message as a global alert.
--- This is what is used to display messages such as "The air feels different..." 
--- @param message string
--- @param level ECriticalityLevels
local function sendWarningMessage(message, level)
  local playerController = UEHelpers.GetPlayerController()

  playerController.PlayerHUDRef:DisplayWarningMessage(FText(message), level)
end

local aiDirector = nil

--- Helper used to retrieved the Abiotic_AIDirector_C
--- It will cache the result to avoid calling again the FindFirstOf function.
--- @return AAbiotic_AIDirector_C
local function getAIDirector()
  if aiDirector ~= nil and aiDirector:IsValid() then
    return aiDirector
  end

  aiDirector = FindFirstOf("Abiotic_AIDirector_C")

  if aiDirector == nil then
    error("Unable to find AIDirector")

    return
  end

  return aiDirector
end

--- Function used to identify if the mod is in debug mode.
--- @return boolean
local function isDebug()
  return true
end

return {
  log = log,
  sendWarningMessage = sendWarningMessage,
  isDebug = isDebug,
  getAIDirector = getAIDirector
}
