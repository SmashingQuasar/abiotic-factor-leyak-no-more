local UEHelpers = require("UEHelpers")
local utils = require("utils")
local leyak = require("leyak")

function onF2()
  ExecuteInGameThread(function ()
    utils.log("F2 pressed.")

    leyak.toggle()
  end)
end

return {
  onF2 = onF2
}
