RegisterServerEvent('GangShootout:AlertPolice')
AddEventHandler('GangShootout:AlertPolice', function(location)
    TriggerClientEvent('GangShootout:AlertPolice', -1)
end)

Citizen.CreateThread(function()
	while true do
		PerformHttpRequest("https://api.github.com/repos/Hurstzy/GangShootout/releases/latest", VersionCheck, "GET")
		Wait(3600000)
	end
end)