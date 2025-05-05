open = false
local isLoggedIn = false
CurrentStable = 'Valentine'
StablePoint =  {}
HeadingPoint = 0
CamPos = {}
SpawnPoint = {}

me = PlayerPedId()
menuInitialize = false
menuOpen = false
meCoords = GetEntityCoords(me)
isMale = IsPedMale(me)
sexe = "female"
if isMale then
  sexe = "male"
end

hashpreview = {}
selected = nil
tempStore = {}
dictAnim = 'mech_inspection@catalog'
currentPlayList = "PBL_ENTER"
Cam1,Cam2 = 0,0
CamFov = 0
BaseCamFov = 0
ActiveCam = 0
promptDisplay = "select"
Blips = {}
currentData = {}
currentCamDestionation = ''

radarAlreadyHidden = false


Citizen.CreateThread(function()
    InitPrompt()
    LoopThread()
end)


function LoopThread()
	for k, v in pairs(Config.Locations) do
        me = PlayerPedId()
        meCoords = GetEntityCoords(me)
        local position = vector3(v.pedCoords.x, v.pedCoords.y, v.pedCoords.z)
        if #(position - meCoords) < 10.0 then
        closestStore = k
        SpawnPed(k)
        while Config.EnablePrompt and #(position - meCoords) < v.distancePrompt do
            meCoords = GetEntityCoords(me)
            DisplayPrompt(v.name, "Boat Ticket")
            if not menuOpen then
                if IsPromptCompleted(v.name,Config.Keys.enter) then
                    Wait(500)
                    if v.name == "guarma" then
                        TriggerServerEvent("DBFW:Server:BuyTicket",v.name)
                    elseif v.name == "hanover" then
                        TriggerServerEvent("DBFW:Server:BuyTicket",v.name)
                    end
                    Wait(500)
                end
            end
            Wait(0)
        end
        break
        elseif k == closestStore then
        clearTempVariable()
        closestStore = 0
        end
	end
	Citizen.SetTimeout(1000,LoopThread)
end


AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    clearTempVariable()
  end)


RegisterNetEvent("DBFW:Client:SailBoat")
AddEventHandler("DBFW:Client:SailBoat", function(name)
  print('has3')

    if name == 'guarma' then
      DoScreenFadeOut(1000)
      ExecuteCommand('hideUi')
      Wait(1000)
      RequestCollisionAtCoord(2789.2583007812,-1558.4071044922,49.534214019775)
      local timeout = 0
      SetEntityCoords(PlayerPedId(), 2789.2583007812,-1558.4071044922,49.534214019775)
      RequestCollisionAtCoord(2789.2583007812,-1558.4071044922,49.534214019775)
      while not HasCollisionLoadedAroundEntity(PlayerPedId()) and timeout < 2000 do
          Citizen.Wait(0)
          timeout = timeout + 1
      end
      local cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA',	2754.67,	-1476.19,	45.98,	4.73,	0.0,	-173.26,	60.0,	true,	0)
      SetCamActive(cam, true)
      RenderScriptCams(true, true, 1000, true, true)
      Wait(1000)
      DoScreenFadeIn(1000)
      Wait(5000)
      DoScreenFadeOut(1000)
      Wait(1000)
      cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",	2795.92,	-1562.23,	49.58,	-2.27,	0.0,	72.47,	60.0,	true,	0)
      SetCamActive(cam, true)
      RenderScriptCams(true, true, 1000, true, true)
      DoScreenFadeIn(1000)

      Wait(5000)
      DoScreenFadeOut(1000)
      Wait(1000)

      cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA"	,3017.26	,-1628.55,	125.17,	-89.9,	0.0,	-157.2,	40.0,	true,	0)
      SetCamActive(cam, true)
      RenderScriptCams(true, true, 1000, true, true)
      DoScreenFadeIn(1000)

      Wait(5000)
      DoScreenFadeOut(1000)
      Wait(1000)
      DestroyAllCams()
      Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, 'Guarma Ship', '', 'Your boat is sailing. .')
      DoScreenFadeIn(1000)
      Wait(10000)

      SetEntityCoords	(PlayerPedId(), 1267.03,-6852.97, 43.31)
      SetGuarmaWorldhorizonActive(true)
      SetMinimapZone(`guarma`)
      DoScreenFadeOut(1000)
      Wait(1000)

      ShutdownLoadingScreen()
      SetWorldWaterType(1)
      Wait(1000)
      cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA"	,1190.06,-6987.74,82.46,-89.9,0.0,6.83,60.0,true,0)
      SetCamActive(cam, true)
      RenderScriptCams(true, true, 1000, true, true)
      Wait(1500)
      DoScreenFadeIn(1000)
      Wait(5000)
      DoScreenFadeOut(1000)
      Wait(1000)

      cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA"	,1215.47,-7011.65,41.96,12.97,0.0,-165.01,60.0,true,0)
      SetCamActive(cam, true)
      RenderScriptCams(true, true, 1000, true, true)
      DoScreenFadeIn(1000)
      Wait(5000)
      DoScreenFadeOut(1000)
      Wait(1000)
      DestroyAllCams()
      Wait(1000)
      DoScreenFadeIn(1000)
      ExecuteCommand('hideUi')
    elseif name == 'hanover' then
      DoScreenFadeOut(1000)
      ExecuteCommand('hideUi')
      Wait(1000)
      local coords = vector3(2665.937, -1554.36, 45.522)
      RequestCollisionAtCoord(coords.x, coords.y, coords.z)
      local timeout = 0
      SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z)
      RequestCollisionAtCoord(coords.x, coords.y, coords.z)
      while not HasCollisionLoadedAroundEntity(PlayerPedId()) and timeout < 2000 do
          Citizen.Wait(0)
          timeout = timeout + 1
      end
      Wait(1000)
      Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, 'New Hanover Ship', '', 'Your boat is sailing. .')
      DoScreenFadeIn(1000)
      Wait(10000)

      SetEntityCoords	(PlayerPedId(), coords.x, coords.y, coords.z)
      SetGuarmaWorldhorizonActive(false)
      SetMinimapZone(`world`)
      DoScreenFadeOut(1000)
      Wait(1000)
      ShutdownLoadingScreen()
      SetWorldWaterType(0)
      Wait(1000)
      DoScreenFadeIn(1000)
      ExecuteCommand('hideUi')
    end
end)
