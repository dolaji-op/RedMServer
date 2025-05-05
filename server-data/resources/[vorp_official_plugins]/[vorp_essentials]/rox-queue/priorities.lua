priorityPlayers = {}

function LoadPriorities()


	exports.oxmysql:execute("SELECT identifier, `group` FROM users", {},
	function(staffPlayers)
		for _, v in pairs(staffPlayers) do
			local points = 0

			if v.group == "owner" then
				points = 10
			elseif v.group == "admin" then
				points = 9
			end

			if points > 0 then
				priorityPlayers[v.identifier] = points
                Queue.AddPriority(v.identifier, points)
			end
		end

		exports.oxmysql:execute("SELECT steam, priority FROM vorp_queue", {},
		function(result)
			for _, v in pairs(result) do
				if priorityPlayers[v.steam] == nil then
					priorityPlayers[v.steam] = v.priority
                    Queue.AddPriority(v.steam, v.priority)
				end
			end
		end)
	end)

	print("Loaded queue priorities")
end

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	LoadPriorities()
end)