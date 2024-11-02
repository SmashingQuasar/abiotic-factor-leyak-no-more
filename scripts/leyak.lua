require("UEHelpers")

local configuration = require("configuration")
local utils = require("utils")

--- Callback function for the hook on NPC_Leyak_C:UpdateLeyakVisibility
--- It will retrieve the current Leyak from the context.
--- It will make it drop it's essence.
--- It will make it stuck so the game despawns it cleanly.
--- Note: Calling the AAAI_Controller_Leyak_C:Despawn() method will result
--- in the game crashing when exiting because it does not clean up the
--- game memory.
local function onUpdateLeyakVisibility(Context)
  if not configuration.isLeyakDisabled() then
    return
  end

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

--- This function will invert the value of
--- leyakDisabled by calling the appropriate function.
local function toggle()
  if configuration.isLeyakDisabled() then
    configuration.enableLeyak()

    return
  end

  configuration.disableLeyak()
end

return {
  onUpdateLeyakVisibility = onUpdateLeyakVisibility,
  toggle = toggle,
}
