local UEHelpers = require("UEHelpers")
local utils = require("utils")
local leyak = require("leyak")

local leyakSpawnPreId = -1
local leyakSpawnPostId = -1
local leyakSpawnHooked = false

function registerMainHook()
  utils.log("Registering main hook.")

  NotifyOnNewObject("/Game/Blueprints/Environment/Systems/Abiotic_AIDirector.Abiotic_AIDirector_C", function()
    registerHooks()
  end)

  utils.log("Main hook registered.")
end

function registerHooks()
  utils.log("Registering sub hooks.")
  
  registerLeyakSpawnHook()
  
  utils.log("Sub hooks registered.")
end

function registerLeyakSpawnHook()
  utils.log("Registering Leyak spawn hook.")

  if leyakSpawnHooked then
    utils.log("Leyak spawn hook already registered, skipping.")

    return
  end

  leyakSpawnPreId, leyakSpawnPostId = RegisterHook("/Game/Blueprints/Environment/Systems/Abiotic_AIDirector.Abiotic_AIDirector_C:SpawnLeyak", function()
    leyak.onSpawn()
  end)

  leyakSpawnHooked = true

  utils.log("Leyak spawn hook registered. Hook preId: " .. tostring(leyakSpawnPreId) .. " - Hook postId: " .. tostring(leyakSpawnPostId))
end

return {
  registerMainHook = registerMainHook
}
