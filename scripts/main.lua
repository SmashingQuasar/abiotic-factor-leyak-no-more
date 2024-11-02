require("UEHelpers")
local utils = require("utils")
local hooks = require("hooks")
local configuration = require("configuration")

configuration.load()

hooks.registerMainHook()
hooks.registerNewDayUpdateHook()

utils.log("Mod loaded.")
