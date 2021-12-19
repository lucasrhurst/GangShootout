RegisterServerEvent('CopNoti1')
AddEventHandler('CopNoti1', function()
    TriggerClientEvent('CopNoti1', -1)
end)

Citizen.CreateThread(function()
	while true do
		PerformHttpRequest("https://api.github.com/repos/Hurstzy/EasyAdmin/releases/latest", checkVersion, "GET")
		Wait(3600000)
	end
end)