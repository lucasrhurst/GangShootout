function GetVersion()
	local resourceName = GetCurrentResourceName()
	local version = GetResourceMetadata(resourceName, 'version', 0)
	return version
end

curVersion = GetVersion()
local resourceName = "GangShootout ("..GetCurrentResourceName()..")"
function VersionCheck(err, response, headers)
	if err == 200 then
		local data = json.decode(response)
		local remoteVersion = data.tag_name

		if curVersion ~= remoteVersion and tonumber(curVersion) < tonumber(remoteVersion) then
			print("\n--------------------------------------------------------------------------")
			print("\n" .. resourceName .. " is outdated.\nNewest Version: " .. remoteVersion .. "\nYour Version: " .. curVersion .. "\nPlease update it from " .. data.html_url)
			print("\n--------------------------------------------------------------------------")
		end
	else
		Citizen.Trace("^7"..GetCurrentResourceName() .. "^7: Version check failed, please make sure GangAttack is up to date!^7\n")
	end
end

-- Credit to Blumlaut for version check code