local UEHelpers = require("UEHelpers")
local utils = require("utils")
local hooks = require("hooks")
local keybinds = require("keybinds")

hooks.registerMainHook()

RegisterKeyBind(Key.F2, function()
    keybinds.onF2()
end)

utils.log("Mod loaded.")
