require("UEHelpers")

local utils = require("utils")
local leyakModule = require("leyak")

local leyakUpdateVisibilityHooked = false

local function mainHook(Context)
  local leyakNPC = Context:get()

  if leyakModule.isDisabled() then
    leyakNPC.SeenDespawnTime = 0.1
    leyakNPC.TimeAllowedToBeStuck = 0.1
  end

  if leyakUpdateVisibilityHooked == true then
    return
  end

  RegisterHook("/Game/Blueprints/Characters/NPCs/NPC_Leyak.NPC_Leyak_C:UpdateLeyakVisibility", function(Context)
    leyakModule.onUpdateLeyakVisibility(Context)

    leyakUpdateVisibilityHooked = true
  end)
end

local function registerMainHook()
  utils.log("Registering main hook.")

  NotifyOnNewObject("/Game/Blueprints/Characters/NPCs/NPC_Leyak.NPC_Leyak_C", function(Context)
    mainHook(Context)
  end)

  utils.log("Main hook registered.")
end

return {
  registerMainHook = registerMainHook
}
