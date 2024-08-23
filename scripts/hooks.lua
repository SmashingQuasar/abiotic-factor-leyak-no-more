require("UEHelpers")

local utils = require("utils")
local leyakModule = require("leyak")

local leyakUpdateVisibilityHooked = false

local function mainHook()
  if leyakUpdateVisibilityHooked == true or not leyakModule.isDisabled() then
    return
  end

  RegisterHook("/Game/Blueprints/Characters/NPCs/NPC_Leyak.NPC_Leyak_C:UpdateLeyakVisibility", function(Context)
    leyakUpdateVisibilityHooked = true

    leyakModule.onUpdateLeyakVisibility(Context)
  end)
end

local function registerMainHook()
  utils.log("Registering main hook.")

  NotifyOnNewObject("/Game/Blueprints/Characters/NPCs/NPC_Leyak.NPC_Leyak_C", function()
    mainHook()
  end)

  utils.log("Main hook registered.")
end

return {
  registerMainHook = registerMainHook
}
