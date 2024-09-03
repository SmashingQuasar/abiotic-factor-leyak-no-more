local utils = require("utils")

local dropEssence = true
local sendChatMessageOnLeyakDeath = true

local function shouldDropEssence()
  utils.log("Should drop essence: " .. tostring(dropEssence))

  return dropEssence
end

local function changeDropEssence(value)
  utils.log("Changing dropEssence to: " .. tostring(value))

  dropEssence = value
end

local function shouldSendMessageOnDeath()
  utils.log("Should send message on death: " .. tostring(sendChatMessageOnLeyakDeath))

  return sendChatMessageOnLeyakDeath
end

local function changeSendMessageOnDeath(value)
  utils.log("Changing death message on death to: " .. tostring(value))

  sendChatMessageOnLeyakDeath = value
end

return {
  shouldDropEssence = shouldDropEssence,
  changeDropEssence = changeDropEssence,
  shouldSendMessageOnDeath = shouldSendMessageOnDeath,
  changeSendMessageOnDeath = changeSendMessageOnDeath
}
