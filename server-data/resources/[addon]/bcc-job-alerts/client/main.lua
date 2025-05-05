function SetBlip(Coords, Hash, Radius, Title)
  local blip = N_0x554d9d53f696d002(1664425300, Coords)
  SetBlipSprite(blip, Hash, 1)
  SetBlipScale(blip, Radius)
  Citizen.InvokeNative(0x9CB1A1623062F402, blip, Title)
  Citizen.InvokeNative(0xEDD964B7984AC291, blip, GetHashKey('BLIP_STYLE_AREA_BURN'));
  return blip
end

RegisterNetEvent('bcc:alertplayer')
AddEventHandler('bcc:alertplayer', function(msg, time, job, bliphash, x, y, z, shape, radius, bliptime)
    TriggerEvent("vorp:NotifyLeft", job, msg, 'generic_textures', shape, time)
    print('TESTING TESTING TESTING', x,y,z)
    local Blip = SetBlip(vec3(x,y,z), -695368421, 1.0, 'Medical Assistance');
    Wait(bliptime)
	RemoveBlip(Blip)
end)


RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
	Wait(1000)
    TriggerServerEvent('bcc:alerts:register')

end)