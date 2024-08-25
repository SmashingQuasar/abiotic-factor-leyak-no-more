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

--- Helper function that sends a message within the chat box
--- of the player UI. It is scoped to the player who sees this message.
--- @param message string
--- @param colour FLinearColor
local function sendScopedChatMessage(message, colour)
  local playerController = UEHelpers.GetPlayerController()

  colour = colour or {
    R = 1.0,
    G = 1.0,
    B = 1.0,
    A = 1.0
  }

  playerController:Local_DisplayTextChatMessage("", colour, message, colour)
end

local deathMessages = {
  "{{actor}} forgot to keep their blood inside their body.",
  "{{actor}} experienced excessive blunt force trauma.",
  "{{actor}} turned into an ice cube.",
  "{{actor}} made beautiful music.",
  "{{actor}} was sliced into bits.",
  "{{actor}} was lost to the abyss.",
  "{{actor}} is sleeping with the fishes.",
  "{{actor}} made a fatal connection.",
  "{{actor}} forgot about gravity.",
  "{{actor}} made contact with a machine intelligence.",
  "{{actor}} was pierced by a bolt.",
  "{{actor}} was skewered by something wild.",
  "{{actor}} was harassed to death by a pest.",
  "{{actor}} was widowed.",
  "{{actor}} was sliced into bits.",
  "{{actor}} fell asleep. Forever.",
  "{{actor}} forgot to feed themselves.",
  "{{actor}} forgot to keep hydrated.",
  "{{actor}} got into a sticky situation.",
  "{{actor}} did not survive the Night.",
  "{{actor}} didn't return from the reservoir.",
  "{{actor}} swam where they didn't belong.",
  "{{actor}} was blown to bits.",
  "{{actor}} got pummeled to death.",
  "{{actor}} was riddled with bullets.",
  "{{actor}} was turned into swiss cheese.",
  "{{actor}} played a game they couldn't win.",
  "{{actor}} was gunned down.",
  "{{actor}} was skewered by something wild.",
  "{{actor}} was boiled alive by acid.",
  "{{actor}} met a fowl end.",
  "{{actor}} died from a strange virus.",
  "{{actor}} met a predictable end.",
  "{{actor}} tried to reach the bottom.",
  "{{actor}} choked on smoke.",
  "{{actor}} went off the rails.",
  "{{actor}} got a little too toasty",
  "{{actor}} was lasered."
}

--- A simple helper function that will return a death message
--- with the given actor name.
--- @param actor string
--- @return string
local function generateDeathMessage(actor)
  local message = deathMessages[math.random(#deathMessages)]

  local result = message:gsub("{{actor}}", actor)

  return result
end

--- Function used to identify if the mod is in debug mode.
--- @return boolean
local function isDebug()
  return false
end

return {
  log = log,
  sendWarningMessage = sendWarningMessage,
  isDebug = isDebug,
  sendScopedChatMessage = sendScopedChatMessage,
  generateDeathMessage = generateDeathMessage
}
