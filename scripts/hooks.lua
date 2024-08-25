require("UEHelpers")

local utils = require("utils")
local leyakModule = require("leyak")

local leyakUpdateVisibilityHooked = false

local function registerLeyakUpdateVisibilityHook()
  if leyakUpdateVisibilityHooked == true or not leyakModule.isDisabled() then
    utils.log("Not registering main hook, main hook already registered.")

    return
  end

  RegisterHook("/Game/Blueprints/Characters/NPCs/NPC_Leyak.NPC_Leyak_C:UpdateLeyakVisibility", function(Context)
    leyakModule.onUpdateLeyakVisibility(Context)
  end)

  leyakUpdateVisibilityHooked = true
end

local function registerMainHook()
  utils.log("Registering main hook.")

  RegisterHook("/Script/Engine.PlayerController:ClientRestart", function ()
    registerLeyakUpdateVisibilityHook()
  end)

  utils.log("Main hook registered.")
end

return {
  registerMainHook = registerMainHook
}
