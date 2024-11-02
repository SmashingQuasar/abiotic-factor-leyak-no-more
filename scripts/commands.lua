require("UEHelpers")

local leyakModule = require("leyak")
local configuration = require("configuration")
local utils = require("utils")

local function leyakEnable()
  configuration.enableLeyak()
end

local function leyakDisable()
  configuration.disableLeyak()
end

local function leyakToggle()
  if configuration.isLeyakDisabled() then
    configuration.enableLeyak()

    return
  end
  
  configuration.disableLeyak()
end

local function leyakEnableEssence()
  configuration.changeDropEssence(true)
end

local function leyakDisableEssence()
  configuration.changeDropEssence(false)
end

local function leyakToggleEssence()
  configuration.changeDropEssence(not configuration.shouldDropEssence())
end

local function leyakEnableDeathMessage()
  configuration.changeSendMessageOnDeath(true)
end

local function leyakDisableDeathMessage()
  configuration.changeSendMessageOnDeath(false)
end

local function leyakToggleDeathMessage()
  configuration.changeSendMessageOnDeath(not configuration.shouldSendMessageOnDeath())
end

local function leyakMakeContainmentPermanent()
  configuration.changePermanentContainment(true)
end

local function leyakMakeContainmentTemporary()
  configuration.changePermanentContainment(false)
end

local function leyakToggleContainment()
  configuration.changePermanentContainment(not configuration.isContainmentPermanent())
end

local function showHelp()
  utils.sendScopedChatMessage([[
    LeyakNoMore help...

    List of available commands:
      /lnm leyak disable => Disables the Leyak. It will let it spawn and instantly despawn it. This is the default setting.
      /lnm leyak enable => Enables the Leyak. This reverts the Leyak to its vanilla state.
      /lnm leyak toggle => Inverts the status of the Leyak. From enable to disable and vice-versa.
      /lnm dropEssence enable => Enables the Leyak dropping its essence when being despawned by the mod. Has no effect if the Leyak is enabled.
      /lnm dropEssence disable => Disables the Leyak dropping its essence when being despawned by the mod. Has no effect if the Leyak is enabled.
      /lnm dropEssence toggle => Inverts the status of the Leyak dropping its essence when being despawned by the mod. Has no effect if the Leyak is enabled.
      /lnm deathMessage enable => Enables flavour death messages being shown in chat when the Leyak is despawned. Has no effect if the Leyak is enabled.
      /lnm deathMessage disable => Disables flavour death messages being shown in chat when the Leyak is despawned. Has no effect if the Leyak is enabled.
      /lnm deathMessage toggle => Inverts the status of the death messages.
      /lnm containment permanent => Makes containment permanent.
      /lnm containment temporary => Makes containment temporary.
      /lnm containment toggle => Inverts the status of the containment. 
  ]], { R = 1.0, G = 1.0, B = 1.0, A = 1.0 })
end

local function handleHelp(explodedString)
  if explodedString[1] ~= "/lnm" or explodedString[2] == "help" or explodedString[3] == "help" then
    showHelp()

    return
  end
end

local function handleLeyakCommand(explodedString)
  if explodedString[2] ~= "leyak" then
    return
  end

  if explodedString[3] == "enable" then
    leyakEnable()

    return
  end

  if explodedString[3] == "disable" then
    leyakDisable()

    return
  end

  if explodedString[3] == "toggle" then
    leyakToggle()

    return
  end
end

local function handleDropEssenceCommand(explodedString)
  if explodedString[2] ~= "dropEssence" then
    return
  end

  if explodedString[3] == nil then
    return
  end

  if explodedString[3] == "enable" then
    leyakEnableEssence()

    utils.sendWarningMessage("Essence drop on Leyak death enabled.", 1)

    return
  end

  if explodedString[3] == "disable" then
    leyakDisableEssence()

    utils.sendWarningMessage("Essence drop on Leyak death disabled.", 1)

    return
  end

  if explodedString[3] == "toggle" then
    leyakToggleEssence()

    return
  end
end

local function handleDeathMessagesCommand(explodedString)
  if explodedString[2] ~= "deathMessage" then
    return
  end

  if explodedString[3] == nil then
    return
  end

  if explodedString[3] == "enable" then
    leyakEnableDeathMessage()

    utils.sendWarningMessage("Messages on Leyak death enabled.", 1)

    return
  end

  if explodedString[3] == "disable" then
    leyakDisableDeathMessage()

    utils.sendWarningMessage("Messages on Leyak death disabled.", 1)

    return
  end
end

local function handleContainmentCommand(explodedString)
  if explodedString[2] ~= "containment" then
    return
  end

  if explodedString[3] == nil then
    return
  end

  if explodedString[3] == "permanent" then
    leyakMakeContainmentPermanent()

    utils.sendWarningMessage("Leyak permanent containment enabled.", 1)

    return
  end

  if explodedString[3] == "temporary" then
    leyakMakeContainmentTemporary()

    utils.sendWarningMessage("Leyak permanent containment disabled.", 1)

    return
  end

  if explodedString[3] == "toggle" then
    leyakToggleContainment()

    return
  end
end

return {
  leyakEnable = leyakEnable,
  leyakDisable = leyakDisable,
  leyakToggle = leyakToggle,
  leyakEnableEssence = leyakEnableEssence,
  leyakDisableEssence = leyakDisableEssence,
  leyakToggleEssence = leyakToggleEssence,
  leyakEnableDeathMessage = leyakEnableDeathMessage,
  leyakDisableDeathMessage = leyakDisableDeathMessage,
  leyakToggleDeathMessage = leyakToggleDeathMessage,
  showHelp = showHelp,
  handleHelp = handleHelp,
  handleLeyakCommand = handleLeyakCommand,
  handleDropEssenceCommand = handleDropEssenceCommand,
  handleDeathMessagesCommand = handleDeathMessagesCommand,
  handleContainmentCommand = handleContainmentCommand
}
