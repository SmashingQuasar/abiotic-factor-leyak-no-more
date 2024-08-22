local UEHelpers = require("UEHelpers")
local utils = require("utils")
local leyak = require("leyak")
local hooks = require("hooks")
local keybinds = require("keybinds")

hooks.registerMainHook()

RegisterKeyBind(Key.F2, function()
    keybinds.onF2()
end)

RegisterKeyBind(Key.F4, function()
    keybinds.onF4()
end)

utils.log("Mod loaded.")
