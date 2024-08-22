require("UEHelpers")

local utils = require("utils")
local leyak = require("leyak")

--- Callback function that will trigger when the F2 key is pressed.
--- It will toggle the Leyak.
local function onF2()
  ExecuteInGameThread(function ()
    utils.log("F2 pressed.")

    leyak.toggle()
  end)
end

return {
  onF2 = onF2
}
