Citizen.CreateThread(function()
    if Config.UsingESX then

        while ESX == nil do
            TriggerEvent(Config.ESXTriggers.main, function(obj) ESX = obj end)
            Citizen.Wait(0)
        end

        RegisterNetEvent(Config.ESXTriggers.load)
        AddEventHandler(Config.ESXTriggers.load, function(xPlayer, isNew)
            ESX.PlayerData = xPlayer
            ESX.PlayerLoaded = true
        end)

        if Config.UsingMulticharacter then
            RegisterNetEvent(Config.ESXTriggers.logout) -- multichar
            AddEventHandler(Config.ESXTriggers.logout, function(xPlayer, isNew)
                ESX.PlayerLoaded = false
                ESX.PlayerData = {}
            end)
        end

        RegisterNetEvent(Config.ESXTriggers.job)
        AddEventHandler(Config.ESXTriggers.job, function(job)
            ESX.PlayerData.job = job
        end)
    end
end)

Citizen.CreateThread(function()

    while true do

        sleep = 500

        for k,v in pairs(Config.Locations) do
            if #(GetEntityCoords(PlayerPedId()) - v.start) < 50.0 then
                sleep = 0
                DrawMarker(v.marker.type, vector3(v.start.x, v.start.y, v.start.z-0.98), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.marker.size, v.marker.size, 1.0, v.marker.r, v.marker.g, v.marker.b, v.marker.a, false, false, false, false, false, false, false)
            end

            if #(GetEntityCoords(PlayerPedId()) - vector3(v.start)) < 1.5 then
                HelpNotification(v.startText)
                if IsControlJustPressed(0, 38) then
                    StartShootout()
                end
            end
        end
        
        Citizen.Wait(sleep)
    end
end)

function StartShootout()

    local name, settings = GetCurrentShootout()

    TriggerServerEvent('GangShootout:AlertPolice', name)

    for _,ped in pairs(settings.peds) do
        RequestModel(ped)
        while not HasModelLoaded(ped) do
            RequestModel(ped)
            Wait(1)
        end
    end

    for i=1, settings.count do
        local ped = CreatePed(1, settings.peds[math.random(1, #settings.peds)], settings.spawnlocs[math.random(1, #settings.spawnlocs)], 10.55, true, false)

        SetPedRelationshipGroupHash(ped, GetHashKey('AMBIENT_GANG_LOST'))
        GiveWeaponToPed(ped, settings.weapons[math.random(1, #settings.weapons)], 999, false, true)
        TaskCombatPed(ped, PlayerPedId(), 0, 16)
    end
end

RegisterNetEvent('GangShootout:AlertPolice')
AddEventHandler('GangShootout:AlertPolice', function(location)

    if Config.Police == 'sem' then
        if exports['SEM_InteractionMenu']:IsOndutyLEO() then
            PoliceAlert(location)
        end
    elseif Config.Police == 'esx' then
        for _, job in pairs(Config.PoliceJobs) do
            if ESX.PlayerData.job == job then
                PoliceAlert(location)
            end
        end
    elseif Config.Police == 'custom' then
        -- Insert code here
    end
end)