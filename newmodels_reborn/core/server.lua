local function loadModels()
    if not pathIsDirectory("models") then
        return false, "models directory not found"
    end
    local filesAndFolders = pathListDir("models")
    if not filesAndFolders then
        return false, "failed to list models directory"
    end
    for _, modelType in pairs({"vehicle", "object", "ped"}) do
        local modelTypePath = "models/" .. modelType
        -- Directory is optional, user might not have any custom models for this type
        if pathIsDirectory(modelTypePath) then
            local filesAndFoldersHere = pathListDir(modelTypePath)
            if not filesAndFoldersHere then
                return false, "failed to list " .. modelTypePath .. " directory"
            end
            for _, fileOrFolder in pairs(filesAndFoldersHere) do
                local fullPath = modelTypePath .. "/" .. fileOrFolder
                if pathIsDirectory(fullPath) then
                    local baseModel = tonumber(fileOrFolder)
                    if baseModel then
                        if not isDefaultID(modelType, baseModel) then
                            return false, "invalid " .. modelType .. " base model: " .. baseModel
                        end
                        local filesAndFoldersInside = pathListDir(fullPath)
                        if not filesAndFoldersInside then
                            return false, "failed to list " .. fullPath .. " directory"
                        end
                        local customModelInfo = {}
                        local function parseOneFile(thisFileName, thisFullPath, name)
                            local fileType = string.sub(thisFileName, -3)
                            if not (fileType == "dff" or fileType == "txd" or fileType == "col") then
                                return false, "invalid " .. modelType .. " file type: " .. fileType
                            end
                            local customModel = tonumber(string.sub(thisFileName, 1, -5))
                            if not customModel then
                                return false, "invalid " .. modelType .. " custom model: " .. thisFileName
                            end
                            if isDefaultID(modelType, customModel) then
                                return false, "custom " .. modelType .. " model is a default ID: " .. customModel
                            end
                            if customModels[customModel] then
                                return false, "duplicate " .. modelType .. " custom model: " .. customModel
                            end
                            if not customModelInfo[customModel] then
                                customModelInfo[customModel] = {}
                            end
                            customModelInfo[customModel][fileType] = thisFullPath
                            if name then
                                customModelInfo[customModel].name = name
                            end
                            return true
                        end
                        for _, fileOrFolderInside in pairs(filesAndFoldersInside) do
                            local fullPathInside = fullPath .. "/" .. fileOrFolderInside
                            if pathIsDirectory(fullPathInside) then
                                local filesAndFoldersInsideThis = pathListDir(fullPathInside)
                                if not filesAndFoldersInsideThis then
                                    return false, "failed to list " .. fullPathInside .. " directory"
                                end
                                for _, fileOrFolderInsideThis in pairs(filesAndFoldersInsideThis) do
                                    local fullPathInsideThis = fullPathInside .. "/" .. fileOrFolderInsideThis
                                    local parsed, failReason = parseOneFile(fileOrFolderInsideThis, fullPathInsideThis, fileOrFolderInside)
                                    if not parsed then
                                        return false, failReason
                                    end
                                end
                            elseif pathIsFile(fullPathInside) then
                                local parsed, failReason = parseOneFile(fileOrFolderInside, fullPathInside)
                                if not parsed then
                                    return false, failReason
                                end
                            end
                        end
                        for customModel, info in pairs(customModelInfo) do
                            customModels[customModel] = {
                                type = modelType,
                                baseModel = baseModel,
                                dff = info.dff,
                                txd = info.txd,
                                col = info.col,
                                name = info.name or "Unnamed"
                            }
                        end
                    end
                end
            end
        end
    end
    return true
end

local result, failReason = loadModels()
if not result then
    outputServerLog("[loadModels] " .. failReason)
    outputDebugString("Failed to load models. See server log for details.", 1)
    return
end

addEventHandler("onPlayerResourceStart", root, function(res)
    if res == resource then
        triggerClientEvent(source, "newmodels_reborn:receiveCustomModels", resourceRoot, customModels)
    end
end)
