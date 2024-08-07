Core = nil

if Config.Framework == "esx" then
    Core = exports["es_extended"]:getSharedObject()
end

function Notification(src, data)
    TriggerClientEvent('mVehicle:Notification', src, {
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

-- Função citizenid
function citizenid(src)
    if Config.Framework == "qbox" then
        local Player = exports.qbx_core:GetPlayer(src)
        if Player then
            return Player.PlayerData.citizenid
        end
    end
    return false
end

function Identifier(src)
    if Config.Framework == "esx" then
        local Player = Core.GetPlayerFromId(src)
        if Player then
            return Player.identifier
        end
    elseif Config.Framework == "qbox" then
        local Player = exports.qbx_core:GetPlayer(src)
        if Player then
            return Player.PlayerData.license
        end
    elseif Config.Framework == "standalone" then
        return GetPlayerIdentifierByType(src, 'license')
    end
    return false
end

function GetName(src)
    if Config.Framework == "esx" then
        local Player = Core.GetPlayerFromId(src)
        if Player then
            return Player.getName()
        end
    elseif Config.Framework == "qbox" then
        local Player = exports.qbx_core:GetPlayer(src)
        if Player then
            local firstname = Player.PlayerData.charinfo.firstname
            local lastname = Player.PlayerData.charinfo.lastname
            return firstname .. ' ' .. lastname
        end
    elseif Config.Framework == "standalone" then
        return GetPlayerName(src)
    end
    return false
end

function OnlinePlayers()
    if Config.Framework == "esx" then
        return Core.GetPlayers()
    elseif Config.Framework == "qbox" then
        return exports.qbx_core:GetPlayer()
    elseif Config.Framework == "standalone" then
        return GetPlayers()
    end
end

function GetCoords(src, veh)
    local entity = src and GetPlayerPed(src) or veh
    if not entity then return end
    local coords, heading = GetEntityCoords(entity), GetEntityHeading(entity)
    return { x = coords.x, y = coords.y, z = coords.z, w = heading }
end



-- Atualização do campo 'stored' para 'state' no banco de dados
-- A troca de 'stored' para 'state' foi realizada para garantir compatibilidade total com o padrão do QBox SQL.
-- O campo 'state' é um padrão no QBox, enquanto 'stored' era usado anteriormente no exemplo.
-- Essa mudança ajuda a limpar e organizar melhor os dados no banco de dados, removendo informações desnecessárias.

local query = {
    -- type, job, coords, metadata, lastparking, pound, stored (removido), mileage
    ['qbox'] = {
        getVehicleById = 'SELECT * FROM `player_vehicles` WHERE `id` = ? LIMIT 1',
        getVehicleByPlate = 'SELECT * FROM `player_vehicles` WHERE `plate` = ? LIMIT 1',
        getVehicleByPlateOrFakeplate =
        "SELECT * FROM `player_vehicles` WHERE `plate` = ? OR JSON_UNQUOTE(JSON_EXTRACT(`metadata`, '$.fakeplate')) = ? LIMIT 1",
        setOwner = 'INSERT INTO `player_vehicles` (license, citizenid, vehicle, hash, plate, mods, type, job, coords, metadata, garage) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        deleteByPlate = 'DELETE FROM player_vehicles WHERE plate = ?',
        deleteById = 'DELETE FROM player_vehicles WHERE id = ?',
        saveMetadata = 'UPDATE player_vehicles SET metadata = ? WHERE plate = ?',
        saveProps = 'UPDATE player_vehicles SET mods = ? WHERE plate = ?',
        storeGarage =
        'UPDATE `player_vehicles` SET `parking` = ?, `state` = 1,  `coords` = NULL, `mods` = ?, metadata = ?  WHERE `plate` = ?',
        storeGarageNoProps =
        'UPDATE `player_vehicles` SET `parking` = ?, `state` = 1,  `coords` = NULL, metadata = ?  WHERE `plate` = ?',
        retryGarage = 'UPDATE `player_vehicles` SET `lastparking` = ?, `coords` = ?, `state` = 0 WHERE `plate` = ?',
        setImpound =
        'UPDATE `player_vehicles` SET `parking` = ?, `state` = 0, `pound` = 1, `coords` = NULL, metadata = ? WHERE `plate` = ?',
        retryImpound =
        'UPDATE `player_vehicles` SET `lastparking` = ?, `coords` = ?, `state` = 0, `parking` = ?, pound = NULL WHERE `plate` = ?',
        getMileage = 'SELECT `mileage` FROM player_vehicles WHERE plate = ? LIMIT 1',
        saveLeftVehicle = 'UPDATE player_vehicles SET mileage = ?, coords = ?, mods = ? WHERE plate = ?',
        updateTrailer = 'UPDATE player_vehicles SET coords = ?, mods = ? WHERE plate = ?',
        plateExist = 'SELECT 1 FROM `player_vehicles` WHERE `plate` = ?',
        saveAllPropsCoords = 'UPDATE player_vehicles SET coords = ?, mods = ?, metadata = ? WHERE plate = ?',
        saveAllCoords = 'UPDATE player_vehicles SET coords = ?, metadata = ? WHERE plate = ?',
        saveKeys = 'UPDATE player_vehicles SET `keys` = ? WHERE plate = ?',
        getVehiclesbyOwner = "SELECT * FROM `player_vehicles` WHERE `citizenid` = ?",
        getVehiclesbyOwnerAndhaveKeys = "SELECT * FROM `player_vehicles` WHERE `citizenid` = ? OR JSON_KEYS(`keys`) LIKE ?",
        selectAll = 'SELECT * FROM `player_vehicles`',
        getKeys = 'SELECT * FROM `player_vehicles` WHERE `citizenid` = ?',
    },
}

Querys = query[Config.Framework]
