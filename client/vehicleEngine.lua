if Config.Debug then


    RegisterCommand('howToGetEntity', function(source, args, raw)
        local ped = PlayerPedId()
        local entity = GetVehiclePedIsIn(ped, false)


        if DoesEntityExist(entity) then
            local NetId = VehToNet(entity)

            print(('NetworkID: %s  , Entity: %s'):format(NetId, entity))
        else
            print('Vehicle Entity does exists')
        end
    end)


    --- Vehicle engine sounds from https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound
    local vehicelSounds = {
        { value = 'brabus850',  label = 'Brabus 850 6.0L V8-TT v1.3 (brabus850)' },
        { value = 'toysupmk4',  label = 'Toyota 2JZ-GTE 3.0L I6-T v1.3 (toysupmk4)' },
        { value = 'lambov10',   label = 'Audi/Lamborghini 5.2L V10 v1.0 (lambov10)' },
        { value = 'rb26dett',   label = 'Nissan RB26DETT 2.6L I6-TT v1.2 (rb26dett)' },
        { value = 'rotary7',    label = 'Mazda 13B-REW 1.3L Twin-Rotor v1.0 (rotary7)' },
        { value = 'musv8',      label = 'Dragster Twin-Charged V8SCT v1.0 (musv8)' },
        { value = 'm297zonda',  label = 'Pagani-AMG M297 7.3L V12 v1.0 (m297zonda)' },
        { value = 'm158huayra', label = 'Pagani-AMG M158 6.0L V12TT v1.0 (m158huayra)' },
        { value = 'k20a',       label = 'Honda K20A 2.0L I4 v1.0 (k20a)' },
        { value = 'gt3flat6',   label = 'Porsche RS 4.0L Flat-6 v1.0 (gt3flat6)' },
        { value = 'predatorv8', label = 'Ford-Shelby Predator 5.2L V8SC v1.0 (predatorv8)' }
    }


    exports.ox_target:addGlobalVehicle({
        {
            distance = 10.0,
            label = 'Change Sound',
            onSelect = function(data)
                local input = lib.inputDialog('Vehicle Sound', {
                    { type = 'select', label = 'Text input', options = vehicelSounds },

                })

                if not input then return end
                TriggerServerEvent('mVehicle:SetEngineSound', VehToNet(data.entity), input[1])
            end
        },
    })

    AddStateBagChangeHandler('engineSound', nil, function(bagName, key, value)
        if not value then return end
        local entity = GetEntityFromStateBagName(bagName)

        if NetworkGetEntityOwner(entity) ~= PlayerId() then return end

        ForceUseAudioGameObject(entity, value)
        
        Entity(entity).state:set('engineSound', nil, true)
    end)

end
