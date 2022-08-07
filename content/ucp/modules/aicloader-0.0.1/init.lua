
local writeInteger = core.writeInteger
local readInteger = core.readInteger

local AICharacterName = require("characters")
local FieldTypes = require("fieldtypes")

local personality = require("personality")
local AIPersonalityFields = personality

local aicArrayBaseAddr = core.readInteger(core.AOBScan("? ? ? ? e8 ? ? ? ? 89 1d ? ? ? ? 83 3d ? ? ? ? 00 75 44 6a 08 b9 ? ? ? ? e8 ? ? ? ? 85 c0 74 34 8b c5 2b 05"))

local isInitialized = false
local vanillaAIC = {}

local booleanToInteger = function(value)
    if type(value) == "boolean" then
        return value
    end

    if type(value) == "number" then
        if value ~= 1 and value ~= 0 then
            error("incomprehensible boolean value: " .. value)
        else
            return value
        end
    end

    if type(value) == "string" then
        if value:lower() == "true" then
            value = 1
        elseif value:lower() == "false" then
            value = 0
        elseif value == "1" then
            value = 1
        elseif value == "0" then
            value = 0
        else
            error("incomprehensible boolean value: " .. value)
        end
    end

    return value
end

local aiTypeToInteger = function(aiType)
    local aiInteger = AICharacterName[aiType]
    if aiInt ~= nil then
        return aiInteger
    end
    error("no ai exists with the name: " .. aiType)
end

local function initializedCheck()
    if isInitialized then
       return true
    end
    
    log(WARN, "AIC loader not yet initialized. Call ignored.")
    return false
end

local function saveVanillaAIC()
    for aiName, aiIndex in pairs(AICharacterName) do
        local aicAddr = aicArrayBaseAddr + ((4 * 169) * aiIndex)
        local vanillaData = {}
        vanillaAIC[aiIndex] = vanillaData

        for fieldName, fieldData in pairs(AIPersonalityFields) do
            vanillaData[fieldData.fieldIndex] = readInteger(aicAddr + (4 * fieldData.fieldIndex))
        end
    end
end

-- You can consider this a forward declaration
local namespace = {}

-- functions you want to expose to the outside world
namespace = {
    enable = function(self, config)
        if modules.commands then
            modules.commands.registerCommand("setAICValue", self.onCommandSetAICValue)
            modules.commands.registerCommand("loadAICsFromFile", self.onCommandloadAICsFromFile)
        end
        
        hooks.registerHookCallback("afterInit", function()
            
            saveVanillaAIC()
            
            isInitialized = true
            
            if config.aicFiles then
                if type(config.aicFiles) == "table" then
                    for i, fileName in pairs(config.aicFiles) do
                        if fileName:len() > 0 then
                            print("Overwritten AIC values from file: " .. fileName)
                            namespace.overwriteAICsFromFile(fileName)
                        end
                    end
                else
                    error("aicFiles should be a yaml array")
                end
            end
            
            log(INFO, "AIC loader initialized.")
        end)
    end,

    disable = function(self)
        if not initializedCheck() then
            return
        end
    end,

    onCommandSetAICValue = function(command)
        if not initializedCheck() then
            return
        end
      
        local aiType, fieldName, value = command:match("^/setAICValue ([A-Za-z0-9_]+) ([A-Za-z0-9_]+) ([A-Za-z0-9_]+)$")
        if aiType == nil or fieldName == nil or value == nil then
            modules.commands.displayChatText(
                "invalid command: " .. command .. " usage: " .. 
                "/setAICValue [aiType: 1-16 or AI character type] [field name] [value]"
            )
        else
            namespace.setAICValue(aiType, fieldName, value)
        end
    end,

    onCommandloadAICsFromFile = function(command)
        if not initializedCheck() then
            return
        end
      
        local path = command:match("^/loadAICsFromFile ([A-Za-z0-9_ /.:-]+)$")
        if path == nil then
            modules.commands.displayChatText(
                "invalid command: " .. command .. " usage: " .. 
                "/loadAICsFromFile [path]"
            )
        else
            namespace.overwriteAICsFromFile(path)
        end
    end,

    setAICValue = function(aiType, aicField, aicValue)
        if not initializedCheck() then
            return
        end

        local status, err = pcall(function ()
            if type(aiType) == "string" then
                aiType = aiTypeToInteger(aiType)
            end

            local aicAddr = aicArrayBaseAddr + ((4 * 169) * aiType)

            local set = false

            local fieldData = AIPersonalityFields[aicField]
            if not fieldData then
                error("Invalid aic field name specified: " .. aicField)
            end
            local fieldIndex = fieldData.fieldIndex
            local fieldType = fieldData.fieldType

            if fieldType == "integer" then
            elseif fieldType == "boolean" then
                aicValue = booleanToInteger(aicValue)
            else
                aicValue = FieldTypes[fieldType][aicValue]

                if aicValue == nil then
                    error("Invalid field value: " .. aicValue .. " for fieldName " .. aicValue)
                end
            end

            writeInteger(aicAddr + (4 * fieldIndex), aicValue)
            --TODO: optimize by writing a longer array of bytes...
        end)

        if not status then
            log(WARNING, string.format("Error while setting '%s': '%s' Value ignored.", aicField, err))
        end
    end,

    overwriteAIC = function(aiType, aicSpec)
        if not initializedCheck() then
            return
        end

        for name, value in pairs(aicSpec) do
            namespace.setAICValue(aiType, name, value)
        end
    end,

    overwriteAICsFromFile = function(aicFilePath)
        if not initializedCheck() then
            return
        end

        local file = io.open(aicFilePath, "rb")
        local spec = file:read("*all")

        local aicSpec = json:decode(spec)
        local aics = aicSpec.AICharacters

        for k, aic in pairs(aics) do
            namespace.overwriteAIC(aic.Name, aic.Personality)
        end
    end,
    
    resetAIC = function(aiType)
        if not initializedCheck() then
            return
        end

        if type(aiType) == "string" then
            aiType = aiTypeToInteger(aiType)
        end
        
        for aiIndex, vanillaData in pairs(vanillaAIC) do
            local aicAddr = aicArrayBaseAddr + ((4 * 169) * aiIndex)

            for fieldIndex, aicValue in pairs(vanillaData) do
                writeInteger(aicAddr + (4 * fieldIndex), aicValue)
            end
        end
    end
}

return namespace
