local send_value = nil

RegisterNetEvent('bulgar_inputs:getInput')
AddEventHandler('bulgar_inputs:getInput', function(title, subtext, cb)
	local transfer_value = nil
	SetNuiFocus(true, true);
	SendNUIMessage({type= "open", title = subtext, subtext = title})
	while (send_value == nil) do
		Citizen.Wait(5)
	end
	SendNUIMessage({type= "close"})
	SetNuiFocus(false, false);
	transfer_value = send_value;
	send_value = nil
	cb(transfer_value)
end)

RegisterNUICallback('button_2', function(data, cb)
	send_value = data.text
end)

RegisterNUICallback('button_1', function(data, cb)
	send_value = "close"
end)