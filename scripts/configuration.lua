local utils = require("utils")

local configurationFileName = "leyaknomore_configuration.ini"
local dropEssence = true
local sendChatMessageOnLeyakDeath = true
local permanentContainment = true
local leyakDisabled = true

local function getConfigurationString()
  local configurationString = [=[
leyakDisabled = {{leyakDisabled}}
dropEssence = {{dropEssence}}
sendChatMessageOnLeyakDeath = {{sendChatMessageOnLeyakDeath}}
permanentContainment = {{permanentContainment}}
  ]=]

  configurationString = configurationString:gsub('{{leyakDisabled}}', tostring(leyakDisabled))
  configurationString = configurationString:gsub('{{dropEssence}}', tostring(dropEssence))
  configurationString = configurationString:gsub('{{sendChatMessageOnLeyakDeath}}', tostring(sendChatMessageOnLeyakDeath))
  configurationString = configurationString:gsub('{{permanentContainment}}', tostring(permanentContainment))

  return configurationString
end

local function write()
  local configurationString = getConfigurationString()

  utils.log("Opening configuration file")

  local configurationFile = io.open(configurationFileName, "w")

  if configurationFile == nil then
    utils.log("Configuration file was a nil value")

    return
  end

  utils.log("Writing configuration")

  configurationFile:write(configurationString)

  configurationFile:close()
end

local function load()
  utils.log("Loading configuration")

  local configurationFile = io.open(configurationFileName, "r")

  if configurationFile == nil then
    utils.log("Configuration file was a nil value")

    return
  end

  local fileContents = configurationFile:read("*a")

  if fileContents == "" then
    configurationFile:close()

    write()

    return
  end

  local leyakDisabledValue = fileContents:match("leyakDisabled%s*=%s*(%a+)")

  leyakDisabled = leyakDisabledValue == "true"

  utils.log("Loaded leyakDisabled configuration to: " .. tostring(leyakDisabled))

  local dropEssenceValue = fileContents:match("dropEssence%s*=%s*(%a+)")

  dropEssence = dropEssenceValue == "true"

  utils.log("Loaded dropEssence configuration to: " .. tostring(dropEssence))

  local sendChatMessageOnLeyakDeathValue = fileContents:match("sendChatMessageOnLeyakDeath%s*=%s*(%a+)")

  sendChatMessageOnLeyakDeath = sendChatMessageOnLeyakDeathValue == "true"

  utils.log("Loaded sendChatMessageOnLeyakDeath configuration to: " .. tostring(sendChatMessageOnLeyakDeath))

  local permanentContainmentValue = fileContents:match("permanentContainment%s*=%s(%a+)")

  permanentContainment = permanentContainmentValue == "true"

  utils.log("Loaded permanentContainment configuration to: " .. tostring(permanentContainment))

  configurationFile:close()
end

local function shouldDropEssence()
  utils.log("Should drop essence: " .. tostring(dropEssence))

  return dropEssence
end

local function changeDropEssence(value)
  utils.log("Changing dropEssence to: " .. tostring(value))

  dropEssence = value

  write()
end

local function shouldSendMessageOnDeath()
  utils.log("Should send message on death: " .. tostring(sendChatMessageOnLeyakDeath))

  return sendChatMessageOnLeyakDeath
end

local function changeSendMessageOnDeath(value)
  utils.log("Changing death message on death to: " .. tostring(value))

  sendChatMessageOnLeyakDeath = value

  write()
end

local function changePermanentContainment(value)
  utils.log("Changing permanent containment state to: " .. tostring(value))

  permanentContainment = value

  write()
end

local function isContainmentPermanent()
  utils.log("Leyak containment is permanent: " .. tostring(permanentContainment))

  return permanentContainment
end

--- This function will disable the Leyak by changing
--- the leyakDisabled variable to true.
local function disableLeyak()
  leyakDisabled = true

  write()
  utils.log("Leyak disabled.")
  utils.sendWarningMessage("Leyak disabled", 0)
end

--- This function will enable the Leyak by changing
--- the leyakDisabled variable to false.
local function enableLeyak()
  leyakDisabled = false

  write()
  utils.log("Leyak enabled.")
  utils.sendWarningMessage("Leyak enabled", 3)
end

--- A simple getter to get the value of the leyakDisabled local variable.
local function isLeyakDisabled()
  return leyakDisabled
end

return {
  shouldDropEssence = shouldDropEssence,
  changeDropEssence = changeDropEssence,
  shouldSendMessageOnDeath = shouldSendMessageOnDeath,
  changeSendMessageOnDeath = changeSendMessageOnDeath,
  changePermanentContainment = changePermanentContainment,
  isContainmentPermanent = isContainmentPermanent,
  load = load,
  enableLeyak = enableLeyak,
  disableLeyak = disableLeyak,
  isLeyakDisabled = isLeyakDisabled
}
