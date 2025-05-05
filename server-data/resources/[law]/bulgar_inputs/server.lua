--
AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
	-- print('^6 '..resourceName..'^2 Successfully Loaded ^7')
	-- print('^1 Developed by  ^7')
	-- print('^7 If you got any question or require support join:^5 https://discord.gg/ ^7')
end)
--