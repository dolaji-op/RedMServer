prompts = {}
promptGroups = {}
promptName = ''
timerkey = {}

function IsPromptCompleted(group,key)
  if not UiPromptIsEnabled(promptGroups[group].prompts[key]) then return end
  if UiPromptHasHoldMode(promptGroups[group].prompts[key]) then
    if PromptHasHoldModeCompleted(promptGroups[group].prompts[key]) then
      UiPromptSetEnabled(promptGroups[group].prompts[key], false)
      Citizen.CreateThread(function()
        local group = group
        local key = key
        while IsDisabledControlPressed(0,joaat(key)) or IsControlPressed(0,joaat(key)) do
          Wait(0)
        end
        UiPromptSetEnabled(promptGroups[group].prompts[key], true)
      end)
      return true
    end
  else
    if IsControlJustPressed(0,joaat(key)) then
      return true
    end
  end
  return false
end

function IsPromptEnabled(group,key)
  return UiPromptIsEnabled(promptGroups[group].prompts[key])
end

function CreatePromptButton(group, str, key, holdTime)
  --Check if group exist
  if (promptGroups[group] == nil) then
    if type(group) == "string" then
      promptGroups[group] = {
        group = GetRandomIntInRange(0, 0xffffff),
        prompts = {}
      }
    else
       promptGroups[group] = {
        group = group,
        prompts = {}
      }
    end
  end
  if type(key) == "table" then
    local keys = key
    key = keys[1]
    promptGroups[group].prompts[key] = PromptRegisterBegin()
    for _,k in pairs (keys) do
      promptGroups[group].prompts[k] = promptGroups[group].prompts[key]
      PromptSetControlAction(promptGroups[group].prompts[key], joaat(k))
    end
  else
    promptGroups[group].prompts[key] = PromptRegisterBegin()
    PromptSetControlAction(promptGroups[group].prompts[key], joaat(key))
  end
  str = CreateVarString(10, 'LITERAL_STRING', str)
  PromptSetText(promptGroups[group].prompts[key], str)
  PromptSetEnabled(promptGroups[group].prompts[key], true)
  PromptSetVisible(promptGroups[group].prompts[key], true)
  if holdTime then
    PromptSetHoldMode(promptGroups[group].prompts[key], holdTime)
  end
  PromptSetGroup(promptGroups[group].prompts[key], promptGroups[group].group)
  PromptRegisterEnd(promptGroups[group].prompts[key])
end


function EditPromptText(group,key,str)
  str = CreateVarString(10, 'LITERAL_STRING', str)
  PromptSetText(promptGroups[group].prompts[key], str)
end

function UiPromptIsValid(...)
 return Citizen.InvokeNative(0x347469FBDD1589A9,...)
end

function UiPromptIsPressed(group,key)
 return Citizen.InvokeNative(0xC7D70EAEF92EFF48,promptGroups[group].prompts[key])
end

function UiPromptRestartModes(...)
 return Citizen.InvokeNative(0xDC6C55DFA2C24EE5,...)
end

function UiPromptDelete(...)
 return Citizen.InvokeNative(Hash,...)
end

function UiPromptSetType(...)
 return Citizen.InvokeNative(0x00EDE88D4D13CF59,...)
end

function DisplayPrompt(group,str)
  local promptName  = CreateVarString(10, 'LITERAL_STRING', str)
  PromptSetActiveGroupThisFrame(promptGroups[group].group, promptName)
end

function UiPromptHasHoldMode(...)
  return Citizen.InvokeNative(0xB60C9F9ED47ABB76, ...)
end

function SetRandomOutfitVariation(...)
  return Citizen.InvokeNative(0x283978A15512B2FE,...)
 end


function UiPromptDisablePromptTypeThisFrame(...)
  return Citizen.InvokeNative(0xFC094EF26DD153FA,...)
end

function UiPromptSetEnabled(...)
  return Citizen.InvokeNative(0x8A0FB4D03A630D21,...)
end

function UiPromptIsEnabled(...)
 return Citizen.InvokeNative(0x0D00EDDFB58B7F28,...)
end

function SetPromptVisible(group,key,value)
  UiPromptSetVisible(promptGroups[group].prompts[key],value)
  UiPromptSetEnabled(promptGroups[group].prompts[key],value)
end

function ApplyShopItemToPed(...)
 return Citizen.InvokeNative(0xD3A7B003ED343FD9,...)
end

function RemoveTagFromMetaPed(...)
 return Citizen.InvokeNative(0xD710A5007C2AC539,...)
end

function SetEntityCoordsAndHeading(...)
 return Citizen.InvokeNative(0x203BEFFDBE12E96A,...)
end

function BlipAddForCoords(...)
  return Citizen.InvokeNative(0x554D9D53F696D002, ...)
end

function SetBlipNameFromPlayerString(...)
  return Citizen.InvokeNative(0x9CB1A1623062F402, ...)
end

function TaskUseNearestScenarioToCoord(...)
 return Citizen.InvokeNative(0xA3A9299C4F2ADB98,...)
end

function NatiTaskUseNearestScenarioChainToCoordWarpve(...)
 return Citizen.InvokeNative(0x97A28E63F0BA5631,...)
end

function SetPedShouldPlayImmediateScenarioExit(...)
 return Citizen.InvokeNative(0xF1C03A5352243A30,...)
end

function GetScenarioPointPedIsUsing(...)
 return Citizen.InvokeNative(0xDF7993356F52359A,...)
end

function GetScenarioPointType(...)
 return Citizen.InvokeNative(0xA92450B5AE687AAF,...)
end

function GetScenarioPointEntity(...)
 return Citizen.InvokeNative(0x7467165EE97D3C68,...)
end

function DoesScenarioOfTypeExistInAreaHash(...)
 return Citizen.InvokeNative(0x6EEAD6AF637DA752,...)
end

function FindScenarioOfTypeHash(...)
 return Citizen.InvokeNative(0xF533D68FF970D190,...)
end

function IsEntityFrozen(...)
 return Citizen.InvokeNative(0x083D497D57B7400F,...)
end

function DeleteScenarioPoint(...)
 return Citizen.InvokeNative(0x81948DFE4F5A0283,...)
end
function DoesScenarioPointExist(...)
 return Citizen.InvokeNative(0x841475AC96E794D1,...)
end

function SetScenarioPointCoords(...)
 return Citizen.InvokeNative(0x2056AB38DF06825C,...)
end

function CanPedUseScenarioPoint(...)
 return Citizen.InvokeNative(0xAB643407D0B26F07,...)
end

function SetBlipName(...)
 return Citizen.InvokeNative(0x9CB1A1623062F402,...)
end

function CreateScenarioPointHashAttachedToEntity(...)
 return Citizen.InvokeNative(0x794AB1379A74064D,...)
end

function LoadAnimScene(...)
  return Citizen.InvokeNative(0xAF068580194D9DC7,...)
end

function RequestAnimScenePlayList(...)
  return Citizen.InvokeNative(0xDF7B5144E25CD3FE,...)
end

function IsAnimSceneLoaded(...)
 return Citizen.InvokeNative(0x477122B8D05E7968,...)
end

function DeleteAnimScene(...)
 return Citizen.InvokeNative(0x84EEDB2C6E650000,...)
end

function ForceFirstPersonCamThisFrame(...)
 return Citizen.InvokeNative(0x90DA5BA5C2635416,...)
end

function DrawMarker(...)
  return Citizen.InvokeNative(0x2A32FAA57B937173, ...)
end

function Marker(coords,size,r,g,b,a,permanent)
	if permanent then
		DrawMarker(-1795314153, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, size.x, size.x, size.y, r, g, b, a, 0, 0, 2, 0, 0, 0, 0)
	else
		if Config.Debug then
			DrawMarker(-1795314153, coords.x, coords.y, coords.z, 0, 0, 0, 0, 0, 0, size.x, size.x, size.y, r, g, b, a, 0, 0, 2, 0, 0, 0, 0)
		end
	end
end

function IsAnimScenePlaybackListPhaseActive(...)
 return Citizen.InvokeNative(0x1F0E401031E20146,...)
end

function SetAnimScenePlayList(...)
 return Citizen.InvokeNative(0x15598CFB25F3DC7E,...)
end

function ReleaseAnimScenePlayList(...)
 return Citizen.InvokeNative(0xAE6ADA8FE7E84ACC,...)
end

function DoesAnimSceneExist(...)
 return Citizen.InvokeNative(0x25557E324489393C,...)
end

function DetachAnimScene(...)
 return Citizen.InvokeNative(0x6843A1AA3A336DFF,...)
end

function DoesAnimScenePlayListExist(...)
 return Citizen.InvokeNative(0xA9016536015DE29D,...)
end

function IsAnimSceneRunning(...)
 return Citizen.InvokeNative(0xCBFC7725DE6CE2E0,...)
end

function UpdatePedVariation(...)
 return Citizen.InvokeNative(0xCC8CA3E88256E58F,...)
end

function RefreshMetaPedShopItems(...)
 return Citizen.InvokeNative(0x59BD177A1A48600A,...)
end

function UiPromptSetVisible(...)
 return Citizen.InvokeNative(0x71215ACCFDE075EE,...)
end

function GetShopPedComponentCategory(...)
 return Citizen.InvokeNative(0x5FF9A878C3D115B8,...)
end

function IsLoadingScreenVisible(...)
 return Citizen.InvokeNative(0xB54ADBE65D528FCB,...)
end

function UpdateShopItemWearableState(...)
 return Citizen.InvokeNative(0x66B957AAC2EAAEAB,...)
end

function GetMetaPedType(ped)
    return Citizen.InvokeNative(0xEC9A1261BF0CE510, ped)
end

function GetShopItemNumWearableStates(...)
 return Citizen.InvokeNative(0xFFCC2DB2D9953401,...)
end

function GetShopItemWearableStateByIndex(...)
 return Citizen.InvokeNative(0x6243635AF2F1B826,...)
end


function SetPlayerModel(...)
 return Citizen.InvokeNative(0xED40380076A31506,...)
end

function EquipMetaPedOutfitPreset(...)
 return Citizen.InvokeNative(0x77FF8D35EEC6BBC4,...)
end

function IsPedReadyToRender(...)
 return Citizen.InvokeNative(0xA0BC8FAED8CFEB3C,...)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    -- TextEntry        -->    The Text above the typing field in the black square
    -- ExampleText        -->    An Example Text, what it should say in the typing field
    -- MaxStringLenght    -->    Maximum String Lenght

    AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
    DisplayOnscreenKeyboard(0, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() --Gets the result of the typing
        Citizen.Wait(100) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
        return result --Returns the result
    else
        Citizen.Wait(100) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
        return false --Returns nil if the typing got aborted
    end
end

function UiFeedClearAllChannels(...)
 return Citizen.InvokeNative(0x6035E8FBCA32AC5E,...)
end

function UiFeedPostSampleToastRight(...)
 return Citizen.InvokeNative(0xB249EBCB30DD88E0,...)
end
