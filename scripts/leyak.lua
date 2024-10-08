require("UEHelpers")

local configuration = require("configuration")
local utils = require("utils")

local leyakDisabled = true

--- A simple getter to get the value of the leyakDisabled local variable.
local function isDisabled()
  return leyakDisabled
end

--- Callback function for the hook on NPC_Leyak_C:UpdateLeyakVisibility
--- It will retrieve the current Leyak from the context.
--- It will make it drop it's essence.
--- It will make it stuck so the game despawns it cleanly.
--- Note: Calling the AAAI_Controller_Leyak_C:Despawn() method will result
--- in the game crashing when exiting because it does not clean up the
--- game memory.
local function onUpdateLeyakVisibility(Context)
  if leyakDisabled then
    ---@type ANPC_Leyak_C
    local leyakNPC = Context:get()

    if configuration.shouldDropEssence() then
      utils.log("Dropping leyak essence.")

      leyakNPC:DropEssence()
    end

    leyakNPC.SeenDespawnTime = 0.1
    leyakNPC.TimeAllowedToBeStuck = 0.1

    utils.log("Sticking Leyak")

    leyakNPC.AbsolutelyStuck = true

    utils.log("Leyak stuck.")

    local message = utils.generateDeathMessage("Leyak")

    if configuration.shouldSendMessageOnDeath() then

      utils.sendScopedChatMessage(message, { R = 1.0, G = 0.0, B = 0.0, A = 1.0 })

    end
  end
end

--- This function will disable the Leyak by changing
--- the leyakDisabled variable to true.
local function disable()
  leyakDisabled = true

  utils.log("Leyak disabled.")
  utils.sendWarningMessage("Leyak disabled", 0)
end

--- This function will enable the Leyak by changing
--- the leyakDisabled variable to false.
local function enable()
  leyakDisabled = false

  utils.log("Leyak enabled.")
  utils.sendWarningMessage("Leyak enabled", 3)
end

--- This function will invert the value of
--- leyakDisabled by calling the appropriate function.
local function toggle()
  if leyakDisabled then
    enable()

    return
  end

  disable()
end

return {
  onUpdateLeyakVisibility = onUpdateLeyakVisibility,
  toggle = toggle,
  enable = enable,
  disable = disable,
  isDisabled = isDisabled
}
