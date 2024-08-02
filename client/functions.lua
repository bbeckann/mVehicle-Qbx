-- Get label from vehicle model like 'Karin Sulta'
function VehicleLabel(model)
    if not IsModelValid(model) then
        lib.print.warn(model .. ' - Model invalid')
        return 'Unknown'
    end

    local makeName = GetMakeNameFromVehicleModel(model)

    if not makeName then
        lib.print.warn(model .. ' - No Make Name')
        return 'Unknown'
    end
    makeName = makeName:sub(1, 1):upper() .. makeName:sub(2):lower()

    local displayName = GetDisplayNameFromVehicleModel(model)

    displayName = displayName:sub(1, 1):upper() .. displayName:sub(2):lower()
    return makeName .. ' ' .. displayName
end

--Get Player keys
function KeyItem(plate)
    if not Config.ItemKeys then return true end
    local havekey = false
    if Config.Inventory == 'ox' then
        local carkeys = exports.ox_inventory:Search('slots', Config.CarKeyItem)
        for _, v in pairs(carkeys) do
            if v.metadata.plate:gsub("%s+", "") == plate:gsub("%s+", "") then
                havekey = true
                break
            end
        end

        if havekey then
            return true
        else
            return false
        end
    elseif Config.Inventory == 'qs' then
        local items = exports['qs-inventory']:getUserInventory()
        for item, meta in pairs(items) do
            if meta.info.plate:gsub("%s+", "") == plate:gsub("%s+", "") then
                havekey = true
                break
            end
        end
        if havekey then
            return true
        else
            return false
        end
    end
end

-- Get Vector4 from entity
function GetVector4(entity)
    local c, h = GetEntityCoords(entity), GetEntityHeading(entity)
    return vec4(c.x, c.y, c.z, h)
end

-- Notifications
function Notification(data)
    lib.notify({
        title = data.title,
        description = data.description,
        position = data.position or 'center-left',
        icon = data.icon or 'ban',
        type = data.type or 'warning',
        iconAnimation = data.iconAnimation or 'beat',
        iconColor = data.iconColor or '#C53030',
        duration = data.duration or 2000,
        showDuration = true,
    })
end

--- Retrieves the vehicle model name from its hash.
-- @param hash number The hash of the vehicle model.
-- @return string The model name if found, or "Unknown" if not.
function GetVehicleModelNameFromHash(hash)
    for k, v in pairs(exports.qbx_core:GetVehiclesByName()) do
        if GetHashKey(v.model) == hash then
            return v.model
        end
    end
    return "Unknown"
end

--- Registers a callback to get the vehicle name from hash.
-- @param name string The name of the callback event.
-- @param callback function The callback function to register.
lib.callback.register('mVehicle:GetVehicleNameFromHash', function(hash)
    if hash then
        local modelName = GetVehicleModelNameFromHash(hash)
        return modelName ~= "" and modelName or "Unknown"
    else
        return "CARNOTFOUND"
    end
end)


RegisterNetEvent('mVehicle:Notification', Notification)

if Config.Debug then
    Citizen.CreateThread(function()
        while true do
            SetPedDensityMultiplierThisFrame(0.0)
            SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
            SetVehicleDensityMultiplierThisFrame(0.0)
            SetRandomVehicleDensityMultiplierThisFrame(0.0)
            SetParkedVehicleDensityMultiplierThisFrame(0.0)
            Citizen.Wait(0)
        end
    end)
end
