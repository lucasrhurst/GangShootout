function HelpNotification(msg)
    AddTextEntry('GangShootoutHelpNotification', msg)
    BeginTextCommandDisplayHelp('GangShootoutHelpNotification')
    EndTextCommandDisplayHelp(0, false, false, -1)
end

function PoliceAlert(location)
	AddTextEntry('GangShootoutAdvancedNotification', 'A shootout has begun at ' .. location)
	BeginTextCommandThefeedPost('GangShootoutAdvancedNotification')
	EndTextCommandThefeedPostMessagetext('CHAR_CALL911', 'CHAR_CALL911', false, 1, '911 Call', 'Shots Fired')
	EndTextCommandThefeedPostTicker(false, false)
end

function GetCurrentShootout()

    local closestDistance = -1
    local index = -1

    for k,v in pairs(Config.Locations) do
        local distance = #(GetEntityCoords(PlayerPedId()) - v.start)
        if closestDistance == -1 or distance < closestDistance then
            closestDistance = distance
            index = k
        end
    end

    return index, Config.Locations[index]
end