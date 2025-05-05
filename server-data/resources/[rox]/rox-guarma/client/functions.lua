function InitPrompt()
	CreatePromptButton('guarma',"Buy Ticket to Guarma",Config.Keys.enter,1000)
	CreatePromptButton('hanover',"Buy Ticket to New Hanover",Config.Keys.enter,1000)
end

function SpawnPed(id)
	if DoesEntityExist(tempStore.ped) then return end
	if not Config.Locations[id].pedModel then return end
	if IsModelValid(Config.Locations[id].pedModel) then
			RequestModel(Config.Locations[id].pedModel)
			while not HasModelLoaded(Config.Locations[id].pedModel) do
				Citizen.Wait(100)
			end
			local ped = CreatePed(Config.Locations[id].pedModel, Config.Locations[id].pedCoords, false,true,false,false);
			SetRandomOutfitVariation(ped, true)
			SetEntityNoCollisionEntity(PlayerPedId(), ped, false)
			SetEntityCanBeDamaged(ped, false)
			SetEntityInvincible(ped, true)
			Citizen.InvokeNative(0x9587913B9E772D29, ped, true)
			SetBlockingOfNonTemporaryEvents(ped, true)
			Citizen.Wait(1000)
			FreezeEntityPosition(ped, true)
			tempStore.ped = ped
	else
		print("Error: Model is not valid! If you changed pedModel revert to original or verify correct name.")
		return false
	end
end

function IsTableEmpty(_table)
	for _,_ in pairs (_table) do
		return false
	end
	return true
end


function clearTempVariable()
	if DoesEntityExist(tempStore.ped) then DeleteEntity(tempStore.ped) end
	tempStore = {}
end

function DisableKeys()
	for _,key in pairs (Config.KeysDisabled) do
		DisableControlAction(0,key,false)
	end
	for _,key in pairs (Config.Keys) do
		EnableControlAction(0,joaat(key),true)
	end
end


function isTableEgal(table1,table2)
	for key,value in pairs (table1) do
		if value ~= table2[key] then
			return false
		end
	end
	for key,value in pairs (table2) do
		if value ~= table1[key] then
			return false
		end
	end
	return true
end



