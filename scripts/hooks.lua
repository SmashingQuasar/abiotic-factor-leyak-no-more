require("UEHelpers")

local utils = require("utils")
local leyakModule = require("leyak")
local commands = require("commands")

local leyakUpdateVisibilityHooked = false
local consoleCommandsHooked = false

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

--- A callback function that will enable console commands for LeyakNoMore.
---@param Message FText
local function onNewChatMessage(Message)
  local messageContent = Message:get():ToString()
  local explodedString = utils.splitString(messageContent, " ")

  utils.log("Received message:" .. messageContent)

  -- commands.handleHelp(explodedString)
  commands.handleLeyakCommand(explodedString)
  commands.handleDropEssenceCommand(explodedString)
  commands.handleDeathMessagesCommand(explodedString)
end

local function registerConsoleCommands()
  RegisterHook("Function /Game/Blueprints/Meta/Abiotic_PlayerController.Abiotic_PlayerController_C:Local_DisplayTextChatMessage", function(Context, Prefix, PrefixColor, Message, MessageColor)
    onNewChatMessage(Message)
  end)
end

local function registerMainHook()
  utils.log("Registering main hook.")

  RegisterHook("/Script/Engine.PlayerController:ClientRestart", function ()
    registerLeyakUpdateVisibilityHook()

    if consoleCommandsHooked == false then

      registerConsoleCommands()

      consoleCommandsHooked = true

    end
  end)

  utils.log("Main hook registered.")
end

return {
  registerMainHook = registerMainHook
}
