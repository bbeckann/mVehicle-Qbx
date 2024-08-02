

local animDictLockPick = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
local animLockPick = "machinic_loop_mechandplayer"

local animDicHotWire = "veh@std@ds@base"
local animHotWire = "hotwire"

lib.callback.register('mVehicle:PlayerItems', function(action, entity)
    local ped = cache.ped
    if action == 'changeplate' then
        if lib.progressBar({
                duration = Config.FakePlateItem.ChangePlateTime,
                label = locale('fakeplate4'),
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                    move = true,
                },
                anim = {
                    dict = animDictLockPick,
                    clip = animLockPick,
                    flag = 1,

                },
                prop = {
                    model = 'p_num_plate_01',
                    pos = vec3(0.0, 0.2, 0.1),
                    rot = vec3(100, 100.0, 0.0)
                },
            }) then
            return true
        else
            return false
        end
    elseif action == 'lockpick' then
        if not NetworkDoesNetworkIdExist(entity) then return false end
        local vehicle = NetToVeh(entity)
        local pedInVehicle = IsPedInVehicle(ped, vehicle)
        if pedInVehicle then return end
        lib.requestAnimDict(animDictLockPick)
        TaskPlayAnim(ped, animDictLockPick, animLockPick, 8.0, 8.0, -1, 48, 1, false, false, false)
        local coords = GetEntityCoords(vehicle)
        local skillCheck = Config.LockPickItem.skillCheck()
        if skillCheck then
            Config.LockPickItem.dispatch(cache.serverId, vehicle, coords)
        end
        ClearPedTasks(ped)
        return skillCheck
    elseif action == 'hotwire' then
        local vehicle = GetVehiclePedIsIn(ped, false)
        if not vehicle then return false end
        local pedInVehicle = IsPedInVehicle(ped, vehicle, -1)
        if not pedInVehicle then return false end
        lib.requestAnimDict(animDicHotWire)
        TaskPlayAnim(ped, animDicHotWire, animHotWire, 8.0, 8.0, -1, 48, 1, false, false, false)
        local coords = GetEntityCoords(vehicle)
        local skillCheck = Config.HotWireItem.skillCheck()
        if skillCheck then
            Config.HotWireItem.dispatch(cache.serverId, vehicle, coords)
            SetVehicleEngineOn(vehicle, true, true, true)
        end
        ClearPedTasks(ped)
        return skillCheck
    end
end)
