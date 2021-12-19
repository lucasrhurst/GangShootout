local peds = {
    GetHashKey('g_m_y_lost_01'),
    GetHashKey('g_m_y_lost_02'),
    GetHashKey('g_m_y_lost_03'),
}

local weapons = {
    'weapon_pistol',
    'weapon_sawnoffshotgun',
    'weapon_microsmg',
    'weapon_compactrifle',
}

local spawnlocs = {
    vector3(1990.45, 3045.11, 47.22),
    vector3(1974.08, 3052.15, 47.17),
    vector3(2009.96, 3038.36, 47.1),
    vector3(1993.62, 3025.73, 47.06),
}

Citizen.CreateThread(function()

    while true do

        for k,v in pairs(Config.Locations) do
            if #(GetEntityCoords(PlayerPedId()) - v.start) < 50.0 then
                DrawMarker(v.marker.type, vector3(v.start.x, v.start.y, v.start.z-0.98), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.marker.size, v.marker.size, 1.0, v.marker.r, v.marker.g, v.marker.b, v.marker.a, false, false, false, false, false, false, false)
            end

            if #(GetEntityCoords(PlayerPedId()) - vector3(v.start)) < 1.5 then
                ShowHelpNotification(v.startText)
                if IsControlJustPressed(0, 38) then
                    StartShootOut()
                end
            end
        end
        
        Citizen.Wait(0)
    end
end)

function StartShootOut()

    local settings = GetCurrentAttack()

    for k,v in pairs(settings.peds) do
        RequestModel(v)
        while not HasModelLoaded(v) do
            RequestModel(v)
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

function GetCurrentAttack()

    local closestDistance = -1
    local index = -1

    for k,v in pairs(Config.Locations) do

        local distance = #(GetEntityCoords(PlayerPedId()) - v.start)
        if closestDistance == -1 or distance < closestDistance then
            closestDistance = distance
            index = k
        end

    end

    return Config.Locations[index]
end

function ShowHelpNotification(msg, thisFrame, beep, duration)
	AddTextEntry('hurstzyGangHelpNotification', msg)

	if thisFrame then
		DisplayHelpTextThisFrame('hurstzyGangHelpNotification', false)
	else
		if beep == nil then beep = true end
		BeginTextCommandDisplayHelp('hurstzyGangHelpNotification')
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end

RegisterNetEvent('CopNoti1')
AddEventHandler('CopNoti1', function()
    if exports['SEM_InteractionMenu-master']:IsOndutyLEO() then
        ShowAdvancedNotification('911 Call', 'Shootout', 'Shootout at yellow jack!', 'CHAR_CALL911', 4)
    end
end)