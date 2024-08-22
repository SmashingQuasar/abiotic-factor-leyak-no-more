local UEHelpers = require("UEHelpers")
local utils = require("utils")

local leyakDisabled = true

--[[
  Public functions
]]--

function onSpawn()
  utils.log("Leyak spawned.")

  if utils.isDebug() then
    utils.sendWarningMessage("Leyak spawned.", 3)
  end

  ExecuteWithDelay(2000, function()
    if leyakDisabled then
      despawn()
    end
  end)
end

function despawn()
  local leyak = FindFirstOf("AI_Controller_Leyak_C")

  leyak:Despawn()

  utils.log("Leyak Despawned.")
  utils.sendWarningMessage("Leyak got widowed.", 0)
end

function toggle()
  if leyakDisabled then
    enable()

    return
  end

  disable()
end

--[[
  Private functions
]]--

function disable()
  leyakDisabled = true

  utils.log("Leyak disabled.")
  utils.sendWarningMessage("Leyak disabled", 0)
end

function enable()
  leyakDisabled = false

  utils.log("Leyak enabled.")
  utils.sendWarningMessage("Leyak enabled", 3)
end

return {
  onSpawn = onSpawn,
  despawn = despawn,
  toggle = toggle
}
