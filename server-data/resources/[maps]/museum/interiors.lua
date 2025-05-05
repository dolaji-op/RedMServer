local unlocked_door_hashes = {
    1963415953,
    2847752952,
    }

AddEventHandler('onClientMapStart', function()
    Citizen.CreateThread(function()
        for k, v in pairs(unlocked_door_hashes) do
            Citizen.InvokeNative(0xD99229FE93B46286, v, 1, 0, 0, 0, 0, 0)
            DoorSystemSetDoorState(v, 0)
        end
    end)
end)
