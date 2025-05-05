local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1
L0_1 = nil
L1_1 = nil
L2_1 = nil
L3_1 = Config
L3_1 = L3_1.vorp
if nil == L3_1 then
  L3_1 = Config
  L3_1.vorp = false
end
L3_1 = Config
L3_1 = L3_1.vorp
if L3_1 then
  L3_1 = TriggerEvent
  L4_1 = "getCore"
  function L5_1(A0_2)
    local L1_2
    L0_1 = A0_2
  end
  L3_1(L4_1, L5_1)
  L3_1 = exports
  L3_1 = L3_1.vorp_inventory
  L4_1 = L3_1
  L3_1 = L3_1.vorp_inventoryApi
  L3_1 = L3_1(L4_1)
  L1_1 = L3_1
else
  L3_1 = Config
  L3_1 = L3_1.redem
  if L3_1 then
    L3_1 = {}
    L2_1 = L3_1
    L3_1 = TriggerEvent
    L4_1 = "redemrp_inventory:getData"
    function L5_1(A0_2)
      local L1_2
      L2_1 = A0_2
    end
    L3_1(L4_1, L5_1)
  end
end
L3_1 = Config
L3_1 = L3_1.redem
if L3_1 then
  L3_1 = AddEventHandler
  L4_1 = "redemrp:playerLoaded"
  function L5_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2
    L2_2 = A0_2
    L3_2 = TriggerClientEvent
    L4_2 = "redem:hasLoaded"
    L5_2 = L2_2
    L3_2(L4_2, L5_2)
  end
  L3_1(L4_1, L5_1)
end
L3_1 = {}
farms = L3_1
L3_1 = {}
waterwagons = L3_1
L3_1 = {}
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = pairs
  L2_2 = L3_1
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    if L6_2 == A0_2 then
      L7_2 = true
      return L7_2
    end
  end
  L1_2 = false
  return L1_2
end
inprocessing = L4_1
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = pairs
  L2_2 = L3_1
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    if L6_2 == A0_2 then
      L7_2 = table
      L7_2 = L7_2.remove
      L8_2 = L3_1
      L9_2 = L5_2
      L7_2(L8_2, L9_2)
    end
  end
end
trem = L4_1
L4_1 = AddEventHandler
L5_1 = "onResourceStart"
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 == L1_2 then
    L1_2 = Wait
    L2_2 = 1000
    L1_2(L2_2)
    L1_2 = exports
    L1_2 = L1_2.ghmattimysql
    L2_2 = L1_2
    L1_2 = L1_2.execute
    L3_2 = "SELECT charid, farm FROM playerfarms"
    L4_2 = {}
    function L5_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
      L1_3 = 1
      L2_3 = #A0_3
      L3_3 = 1
      for L4_3 = L1_3, L2_3, L3_3 do
        L5_3 = json
        L5_3 = L5_3.decode
        L6_3 = A0_3[L4_3]
        L6_3 = L6_3.charid
        L5_3 = L5_3(L6_3)
        L6_3 = json
        L6_3 = L6_3.decode
        L7_3 = A0_3[L4_3]
        L7_3 = L7_3.farm
        L6_3 = L6_3(L7_3)
        L7_3 = farms
        L7_3[L5_3] = L6_3
      end
    end
    L1_2(L2_2, L3_2, L4_2, L5_2)
  end
end
L4_1(L5_1, L6_1)
L4_1 = Citizen
L4_1 = L4_1.CreateThread
function L5_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2
  while true do
    L0_2 = Citizen
    L0_2 = L0_2.Wait
    L1_2 = 60000
    L0_2(L1_2)
    L0_2 = os
    L0_2 = L0_2.time
    L0_2 = L0_2()
    L1_2 = os
    L1_2 = L1_2.date
    L2_2 = "*t"
    L3_2 = L0_2
    L1_2 = L1_2(L2_2, L3_2)
    L1_2 = L1_2.hour
    L2_2 = os
    L2_2 = L2_2.date
    L3_2 = "*t"
    L4_2 = L0_2
    L2_2 = L2_2(L3_2, L4_2)
    L2_2 = L2_2.min
    L3_2 = tonumber
    L4_2 = L1_2
    L5_2 = L2_2
    L4_2 = L4_2 .. L5_2
    L3_2 = L3_2(L4_2)
    L4_2 = pairs
    L5_2 = Config
    L5_2 = L5_2.restarttime
    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
    for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
      if L3_2 == L9_2 then
        L10_2 = next
        L11_2 = farms
        L10_2 = L10_2(L11_2)
        if nil ~= L10_2 then
          L10_2 = pairs
          L11_2 = farms
          L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
          for L14_2, L15_2 in L10_2, L11_2, L12_2, L13_2 do
            L16_2 = pairs
            L17_2 = L15_2
            L16_2, L17_2, L18_2, L19_2 = L16_2(L17_2)
            for L20_2, L21_2 in L16_2, L17_2, L18_2, L19_2 do
              L22_2 = pairs
              L23_2 = L21_2
              L22_2, L23_2, L24_2, L25_2 = L22_2(L23_2)
              for L26_2, L27_2 in L22_2, L23_2, L24_2, L25_2 do
                L28_2 = farms
                L28_2 = L28_2[L14_2]
                L28_2 = L28_2[L20_2]
                L28_2 = L28_2[L26_2]
                L28_2 = L28_2.lifetime
                if nil ~= L28_2 then
                  L28_2 = farms
                  L28_2 = L28_2[L14_2]
                  L28_2 = L28_2[L20_2]
                  L28_2 = L28_2[L26_2]
                  L29_2 = farms
                  L29_2 = L29_2[L14_2]
                  L29_2 = L29_2[L20_2]
                  L29_2 = L29_2[L26_2]
                  L29_2 = L29_2.lifetime
                  L29_2 = L29_2 + 1
                  L28_2.lifetime = L29_2
                end
              end
            end
            L16_2 = {}
            L16_2.charid = L14_2
            L17_2 = json
            L17_2 = L17_2.encode
            L18_2 = L15_2
            L17_2 = L17_2(L18_2)
            L16_2.farm = L17_2
            L17_2 = exports
            L17_2 = L17_2.ghmattimysql
            L18_2 = L17_2
            L17_2 = L17_2.execute
            L19_2 = "insert into playerfarms (`charid`, `farm`) values (@charid, @farm) on duplicate key update `farm` = @farm;"
            L20_2 = L16_2
            L17_2(L18_2, L19_2, L20_2)
          end
        end
      end
    end
  end
end
L4_1(L5_1)
L4_1 = AddEventHandler
L5_1 = "onResourceStop"
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 == L1_2 then
    L1_2 = pairs
    L2_2 = farms
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = {}
      L7_2.charid = L5_2
      L8_2 = json
      L8_2 = L8_2.encode
      L9_2 = L6_2
      L8_2 = L8_2(L9_2)
      L7_2.farm = L8_2
      L8_2 = exports
      L8_2 = L8_2.ghmattimysql
      L9_2 = L8_2
      L8_2 = L8_2.execute
      L10_2 = "insert into playerfarms (`charid`, `farm`) values (@charid, @farm) on duplicate key update `farm` = @farm;"
      L11_2 = L7_2
      L8_2(L9_2, L10_2, L11_2)
    end
  end
end
L4_1(L5_1, L6_1)
L4_1 = GetGameTimer
L4_1 = L4_1()
L5_1 = Citizen
L5_1 = L5_1.CreateThread
function L6_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  while true do
    L0_2 = Wait
    L1_2 = 0
    L0_2(L1_2)
    L0_2 = GetGameTimer
    L0_2 = L0_2()
    L1_2 = L4_1
    L0_2 = L0_2 - L1_2
    L1_2 = Config
    L1_2 = L1_2.timesave
    L1_2 = 60000 * L1_2
    if L0_2 > L1_2 then
      L0_2 = next
      L1_2 = farms
      L0_2 = L0_2(L1_2)
      if nil ~= L0_2 then
        L0_2 = pairs
        L1_2 = farms
        L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
        for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
          L6_2 = {}
          L6_2.charid = L4_2
          L7_2 = json
          L7_2 = L7_2.encode
          L8_2 = L5_2
          L7_2 = L7_2(L8_2)
          L6_2.farm = L7_2
          L7_2 = exports
          L7_2 = L7_2.ghmattimysql
          L8_2 = L7_2
          L7_2 = L7_2.execute
          L9_2 = "insert into playerfarms (`charid`, `farm`) values (@charid, @farm) on duplicate key update `farm` = @farm;"
          L10_2 = L6_2
          L7_2(L8_2, L9_2, L10_2)
        end
      end
      L0_2 = GetGameTimer
      L0_2 = L0_2()
      L4_1 = L0_2
    end
  end
end
L5_1(L6_1)
L5_1 = Citizen
L5_1 = L5_1.CreateThread
function L6_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  while true do
    L0_2 = Citizen
    L0_2 = L0_2.Wait
    L1_2 = 60000
    L0_2(L1_2)
    L0_2 = pairs
    L1_2 = farms
    L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
    for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
      L6_2 = pairs
      L7_2 = L5_2
      L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
      for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
        L12_2 = pairs
        L13_2 = L11_2
        L12_2, L13_2, L14_2, L15_2 = L12_2(L13_2)
        for L16_2, L17_2 in L12_2, L13_2, L14_2, L15_2 do
          L18_2 = Config
          L18_2 = L18_2.seeds
          L19_2 = farms
          L19_2 = L19_2[L4_2]
          L19_2 = L19_2[L10_2]
          L19_2 = L19_2[L16_2]
          L19_2 = L19_2.type
          L18_2 = L18_2[L19_2]
          L18_2 = L18_2.timetowater
          L19_2 = farms
          L19_2 = L19_2[L4_2]
          L19_2 = L19_2[L10_2]
          L19_2 = L19_2[L16_2]
          L19_2 = L19_2.watered
          if not L19_2 then
            L19_2 = farms
            L19_2 = L19_2[L4_2]
            L19_2 = L19_2[L10_2]
            L19_2 = L19_2[L16_2]
            L19_2 = L19_2.timer
            if L19_2 == L18_2 then
          end
          else
            L19_2 = farms
            L19_2 = L19_2[L4_2]
            L19_2 = L19_2[L10_2]
            L19_2 = L19_2[L16_2]
            L19_2 = L19_2.timer
            if L19_2 > 0 then
              L19_2 = farms
              L19_2 = L19_2[L4_2]
              L19_2 = L19_2[L10_2]
              L19_2 = L19_2[L16_2]
              L20_2 = farms
              L20_2 = L20_2[L4_2]
              L20_2 = L20_2[L10_2]
              L20_2 = L20_2[L16_2]
              L20_2 = L20_2.timer
              L20_2 = L20_2 - 1
              L19_2.timer = L20_2
            end
          end
          L19_2 = farms
          L19_2 = L19_2[L4_2]
          L19_2 = L19_2[L10_2]
          L19_2 = L19_2[L16_2]
          L19_2 = L19_2.lifetime
          if nil ~= L19_2 then
            L19_2 = farms
            L19_2 = L19_2[L4_2]
            L19_2 = L19_2[L10_2]
            L19_2 = L19_2[L16_2]
            L19_2 = L19_2.lifetime
            L20_2 = Config
            L20_2 = L20_2.totallife
            if L19_2 >= L20_2 then
              L19_2 = farms
              L19_2 = L19_2[L4_2]
              L19_2 = L19_2[L10_2]
              L19_2[L16_2] = nil
            end
          end
        end
      end
    end
  end
end
L5_1(L6_1)
L5_1 = RegisterServerEvent
L6_1 = "rm_farming:checkbucket"
L5_1(L6_1)
L5_1 = AddEventHandler
L6_1 = "rm_farming:checkbucket"
function L7_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = source
  L2_2 = L1_1.getItemCount
  L3_2 = L1_2
  L4_2 = Config
  L4_2 = L4_2.emptycan
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 > 0 then
    L3_2 = TriggerClientEvent
    L4_2 = "rm_farming:pumpbucket"
    L5_2 = L1_2
    L6_2 = A0_2
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = L1_1.subItem
    L4_2 = L1_2
    L5_2 = Config
    L5_2 = L5_2.emptycan
    L6_2 = 1
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = L1_1.addItem
    L4_2 = L1_2
    L5_2 = Config
    L5_2 = L5_2.cleanwateritem
    L6_2 = 1
    L3_2(L4_2, L5_2, L6_2)
  else
    L3_2 = TriggerClientEvent
    L4_2 = "rm_farming:clearonholdbucket"
    L5_2 = L1_2
    L3_2(L4_2, L5_2)
    L3_2 = TriggerClientEvent
    L4_2 = "vorp:TipRight"
    L5_2 = L1_2
    L6_2 = language
    L6_2 = L6_2.needempty
    L7_2 = 50000
    L3_2(L4_2, L5_2, L6_2, L7_2)
  end
end
L5_1(L6_1, L7_1)
L5_1 = RegisterServerEvent
L6_1 = "rm_farming:sendwagonfillrequest"
L5_1(L6_1)
L5_1 = AddEventHandler
L6_1 = "rm_farming:sendwagonfillrequest"
function L7_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L3_2 = source
  L4_2 = containswagon
  L5_2 = waterwagons
  L6_2 = A1_2
  L4_2, L5_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L6_2 = Config
    L6_2 = L6_2.waterwagons
    L6_2 = L6_2[A0_2]
    L7_2 = waterwagons
    L7_2 = L7_2[A1_2]
    if L6_2 > L7_2 then
      L6_2 = waterwagons
      L7_2 = waterwagons
      L7_2 = L7_2[A1_2]
      L7_2 = L7_2 + 1
      L6_2[A1_2] = L7_2
    else
      L6_2 = TriggerClientEvent
      L7_2 = "vorp:TipRight"
      L8_2 = L3_2
      L9_2 = language
      L9_2 = L9_2.wagonfull
      L10_2 = 50000
      L6_2(L7_2, L8_2, L9_2, L10_2)
    end
  else
    L6_2 = waterwagons
    L6_2[A1_2] = 1
  end
  L6_2 = TriggerClientEvent
  L7_2 = "rm_farming:recinfowagons"
  L8_2 = L3_2
  L9_2 = waterwagons
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = TriggerClientEvent
  L7_2 = "rm_farming:recst"
  L8_2 = L3_2
  L6_2(L7_2, L8_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterServerEvent
L6_1 = "rm_farming:waterfromwagon"
L5_1(L6_1)
L5_1 = AddEventHandler
L6_1 = "rm_farming:waterfromwagon"
function L7_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = source
  L2_2 = waterwagons
  L3_2 = waterwagons
  L3_2 = L3_2[A0_2]
  L3_2 = L3_2 - 1
  L2_2[A0_2] = L3_2
  L2_2 = waterwagons
  L2_2 = L2_2[A0_2]
  if 0 == L2_2 then
    L2_2 = waterwagons
    L2_2[A0_2] = nil
  end
  L2_2 = TriggerClientEvent
  L3_2 = "rm_farming:recinfowagons"
  L4_2 = L1_2
  L5_2 = waterwagons
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = TriggerClientEvent
  L3_2 = "rm_farming:recst"
  L4_2 = L1_2
  L2_2(L3_2, L4_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterServerEvent
L6_1 = "rm_farming:watefromriver"
L5_1(L6_1)
L5_1 = AddEventHandler
L6_1 = "rm_farming:watefromriver"
function L7_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = source
  L1_2 = L1_1.subItem
  L2_2 = L0_2
  L3_2 = Config
  L3_2 = L3_2.emptycan
  L4_2 = 1
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = L1_1.addItem
  L2_2 = L0_2
  L3_2 = Config
  L3_2 = L3_2.dirtywateritem
  L4_2 = 1
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = Wait
  L2_2 = 1000
  L1_2(L2_2)
  L1_2 = trem
  L2_2 = L0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterServerEvent
L6_1 = "rm_farming:termbucket"
L5_1(L6_1)
L5_1 = AddEventHandler
L6_1 = "rm_farming:termbucket"
function L7_1()
  local L0_2, L1_2, L2_2
  L0_2 = source
  L1_2 = trem
  L2_2 = L0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterServerEvent
L6_1 = "rm_farming:requestinfo"
L5_1(L6_1)
L5_1 = AddEventHandler
L6_1 = "rm_farming:requestinfo"
function L7_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = source
  L1_2 = TriggerClientEvent
  L2_2 = "rm_farming:recinfo"
  L3_2 = L0_2
  L4_2 = farms
  L5_2 = "true"
  L1_2(L2_2, L3_2, L4_2, L5_2)
  L1_2 = next
  L2_2 = waterwagons
  L1_2 = L1_2(L2_2)
  if nil ~= L1_2 then
    L1_2 = TriggerClientEvent
    L2_2 = "rm_farming:recinfowagons"
    L3_2 = L0_2
    L4_2 = waterwagons
    L1_2(L2_2, L3_2, L4_2)
  end
end
L5_1(L6_1, L7_1)
L5_1 = RegisterServerEvent
L6_1 = "rm_farming:rain"
L5_1(L6_1)
L5_1 = AddEventHandler
L6_1 = "rm_farming:rain"
function L7_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L0_2 = pairs
  L1_2 = farms
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = pairs
    L7_2 = L5_2
    L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
    for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
      L12_2 = pairs
      L13_2 = L11_2
      L12_2, L13_2, L14_2, L15_2 = L12_2(L13_2)
      for L16_2, L17_2 in L12_2, L13_2, L14_2, L15_2 do
        L18_2 = farms
        L18_2 = L18_2[L4_2]
        L18_2 = L18_2[L10_2]
        L18_2 = L18_2[L16_2]
        L18_2 = L18_2.watered
        if not L18_2 then
          L18_2 = farms
          L18_2 = L18_2[L4_2]
          L18_2 = L18_2[L10_2]
          L18_2 = L18_2[L16_2]
          L18_2.watered = true
        end
      end
    end
  end
end
L5_1(L6_1, L7_1)
L5_1 = Citizen
L5_1 = L5_1.CreateThread
function L6_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = L1_1.RegisterUsableItem
  L1_2 = Config
  L1_2 = L1_2.emptycan
  function L2_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = inprocessing
    L2_3 = A0_3.source
    L1_3 = L1_3(L2_3)
    if not L1_3 then
      L1_3 = TriggerClientEvent
      L2_3 = "rm_farming:usebucketinwater"
      L3_3 = A0_3.source
      L1_3(L2_3, L3_3)
      L1_3 = table
      L1_3 = L1_3.insert
      L2_3 = L3_1
      L3_3 = A0_3.source
      L1_3(L2_3, L3_3)
    end
  end
  L0_2(L1_2, L2_2)
  L0_2 = pairs
  L1_2 = Config
  L1_2 = L1_2.watercanitems
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = L1_1.RegisterUsableItem
    L7_2 = L5_2
    function L8_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3
      L1_3 = L1_1.subItem
      L2_3 = A0_3.source
      L3_3 = L5_2
      L4_3 = 1
      L1_3(L2_3, L3_3, L4_3)
      L1_3 = L1_1.addItem
      L2_3 = A0_3.source
      L3_3 = Config
      L3_3 = L3_3.emptycan
      L4_3 = 1
      L1_3(L2_3, L3_3, L4_3)
      L1_3 = TriggerClientEvent
      L2_3 = "rm_farming:wateringcan"
      L3_3 = A0_3.source
      L1_3(L2_3, L3_3)
    end
    L6_2(L7_2, L8_2)
  end
  L0_2 = pairs
  L1_2 = Config
  L1_2 = L1_2.seeds
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = L1_1.RegisterUsableItem
    L7_2 = L5_2.seedname
    function L8_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
      L1_3 = L0_1.getUser
      L2_3 = A0_3.source
      L1_3 = L1_3(L2_3)
      L1_3 = L1_3.getUsedCharacter
      L2_3 = L1_3.job
      L3_3 = L5_2.joblocked
      if 0 ~= L3_3 then
        L3_3 = contains
        L4_3 = L5_2.joblocked
        L5_3 = L2_3
        L3_3 = L3_3(L4_3, L5_3)
        if not L3_3 then
     
        end
      end
      L3_3 = L1_1.getItemCount
      L4_3 = A0_3.source
      L5_3 = Config
      L5_3 = L5_3.plantingitem
      L3_3 = L3_3(L4_3, L5_3)
      if L3_3 > 0 then
        L4_3 = L1_1.getItemCount
        L5_3 = A0_3.source
        L6_3 = L5_2.seedname
        L4_3 = L4_3(L5_3, L6_3)
        L5_3 = L5_2.seedreq
        if L4_3 >= L5_3 then
          L5_3 = inprocessing
          L6_3 = A0_3.source
          L5_3 = L5_3(L6_3)
          if not L5_3 then
            L5_3 = TriggerClientEvent
            L6_3 = "rm_farming:usedseed"
            L7_3 = A0_3.source
            L8_3 = L4_2
            L5_3(L6_3, L7_3, L8_3)
            L5_3 = table
            L5_3 = L5_3.insert
            L6_3 = L3_1
            L7_3 = A0_3.source
            L5_3(L6_3, L7_3)
          end
        else
          L5_3 = TriggerClientEvent
          L6_3 = "vorp:TipRight"
          L7_3 = A0_3.source
          L8_3 = language
          L8_3 = L8_3.notenoughseeds
          L9_3 = 50000
          L5_3(L6_3, L7_3, L8_3, L9_3)
        end
      else
        L4_3 = TriggerClientEvent
        L5_3 = "vorp:TipRight"
        L6_3 = A0_3.source
        L7_3 = language
        L7_3 = L7_3.nohoe
        L8_3 = 50000
        L4_3(L5_3, L6_3, L7_3, L8_3)
   
        L3_3 = TriggerClientEvent
        L4_3 = "vorp:TipRight"
        L5_3 = A0_3.source
        L6_3 = language
        L6_3 = L6_3.joblock
        L7_3 = 50000
        L3_3(L4_3, L5_3, L6_3, L7_3)
      end
      ::lbl_68::
    end
    L6_2(L7_2, L8_2)
  end
end
L5_1(L6_1)
L5_1 = RegisterServerEvent
L6_1 = "rm_farming:interact"
L5_1(L6_1)
L5_1 = AddEventHandler
L6_1 = "rm_farming:interact"
function L7_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2
  L3_2 = source
  L4_2 = pairs
  L5_2 = farms
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = pairs
    L11_2 = L9_2
    L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
    for L14_2, L15_2 in L10_2, L11_2, L12_2, L13_2 do
      L16_2 = pairs
      L17_2 = L15_2
      L16_2, L17_2, L18_2, L19_2 = L16_2(L17_2)
      for L20_2, L21_2 in L16_2, L17_2, L18_2, L19_2 do
        L22_2 = L21_2.render
        if L22_2 == A2_2 then
          if "fert" == A0_2 then
            L22_2 = Config
            L22_2 = L22_2.seeds
            L22_2 = L22_2[A1_2]
            L22_2 = L22_2.fert
            L23_2 = L1_1.getItemCount
            L24_2 = L3_2
            L25_2 = L22_2
            L23_2 = L23_2(L24_2, L25_2)
            if L23_2 > 0 then
              L24_2 = L1_1.subItem
              L25_2 = L3_2
              L26_2 = L22_2
              L27_2 = 1
              L24_2(L25_2, L26_2, L27_2)
              L24_2 = farms
              L24_2 = L24_2[L8_2]
              L24_2 = L24_2[L14_2]
              L24_2 = L24_2[L20_2]
              L24_2.fert = true
              L24_2 = farms
              L24_2 = L24_2[L8_2]
              L24_2 = L24_2[L14_2]
              L24_2 = L24_2[L20_2]
              L25_2 = Config
              L25_2 = L25_2.seeds
              L25_2 = L25_2[A1_2]
              L25_2 = L25_2.timetowater
              L24_2.timer = L25_2
              L24_2 = TriggerClientEvent
              L25_2 = "rm_farming:animationtrigger"
              L26_2 = L3_2
              L27_2 = A0_2
              L24_2(L25_2, L26_2, L27_2)
            else
              L24_2 = TriggerClientEvent
              L25_2 = "vorp:TipRight"
              L26_2 = L3_2
              L27_2 = language
              L27_2 = L27_2.nofert
              L28_2 = 50000
              L24_2(L25_2, L26_2, L27_2, L28_2)
            end
          elseif "remove" == A0_2 then
            L22_2 = language
            L22_2 = L22_2.remove
            L23_2 = GetPlayerName
            L24_2 = L3_2
            L23_2 = L23_2(L24_2)
            L24_2 = L21_2.type
            L25_2 = Discord
            L26_2 = L22_2
            L27_2 = L23_2
            L28_2 = L24_2
            L25_2(L26_2, L27_2, L28_2)
            L25_2 = TriggerClientEvent
            L26_2 = "rm_farming:removeplant"
            L27_2 = L3_2
            L28_2 = L8_2
            L29_2 = L14_2
            L30_2 = L20_2
            L25_2(L26_2, L27_2, L28_2, L29_2, L30_2)
            L25_2 = farms
            L25_2 = L25_2[L8_2]
            L25_2 = L25_2[L14_2]
            L25_2[L20_2] = nil
          elseif "water" == A0_2 then
            L22_2 = farms
            L22_2 = L22_2[L8_2]
            L22_2 = L22_2[L14_2]
            L22_2 = L22_2[L20_2]
            L22_2.watered = true
          elseif "trim" == A0_2 then
            L22_2 = L1_1.getItemCount
            L23_2 = L3_2
            L24_2 = Config
            L24_2 = L24_2.trimmeritem
            L22_2 = L22_2(L23_2, L24_2)
            if L22_2 > 0 then
              L23_2 = farms
              L23_2 = L23_2[L8_2]
              L23_2 = L23_2[L14_2]
              L23_2 = L23_2[L20_2]
              L23_2.trem = true
              L23_2 = TriggerClientEvent
              L24_2 = "rm_farming:animationtrigger"
              L25_2 = L3_2
              L26_2 = A0_2
              L23_2(L24_2, L25_2, L26_2)
            else
              L23_2 = TriggerClientEvent
              L24_2 = "vorp:TipRight"
              L25_2 = L3_2
              L26_2 = language
              L26_2 = L26_2.notrimmer
              L27_2 = 50000
              L23_2(L24_2, L25_2, L26_2, L27_2)
            end
          elseif "dmg" == A0_2 then
            L22_2 = farms
            L22_2 = L22_2[L8_2]
            L22_2 = L22_2[L14_2]
            L22_2 = L22_2[L20_2]
            L23_2 = farms
            L23_2 = L23_2[L8_2]
            L23_2 = L23_2[L14_2]
            L23_2 = L23_2[L20_2]
            L23_2 = L23_2.health
            L24_2 = Config
            L24_2 = L24_2.healthlossonfail
            L23_2 = L23_2 - L24_2
            L22_2.health = L23_2
            L22_2 = farms
            L22_2 = L22_2[L8_2]
            L22_2 = L22_2[L14_2]
            L22_2 = L22_2[L20_2]
            L22_2 = L22_2.difficulty
            L23_2 = Config
            L23_2 = L23_2.maxdiff
            if L22_2 ~= L23_2 then
              L22_2 = farms
              L22_2 = L22_2[L8_2]
              L22_2 = L22_2[L14_2]
              L22_2 = L22_2[L20_2]
              L23_2 = farms
              L23_2 = L23_2[L8_2]
              L23_2 = L23_2[L14_2]
              L23_2 = L23_2[L20_2]
              L23_2 = L23_2.difficulty
              L24_2 = Config
              L24_2 = L24_2.diffinc
              L23_2 = L23_2 - L24_2
              L22_2.difficulty = L23_2
            end
            L22_2 = Config
            L22_2 = L22_2.maxdiff
            L23_2 = farms
            L23_2 = L23_2[L8_2]
            L23_2 = L23_2[L14_2]
            L23_2 = L23_2[L20_2]
            L23_2 = L23_2.difficulty
            if L22_2 >= L23_2 then
              L22_2 = farms
              L22_2 = L22_2[L8_2]
              L22_2 = L22_2[L14_2]
              L22_2 = L22_2[L20_2]
              L23_2 = Config
              L23_2 = L23_2.maxdiff
              L22_2.difficulty = L23_2
            end
            L22_2 = farms
            L22_2 = L22_2[L8_2]
            L22_2 = L22_2[L14_2]
            L22_2 = L22_2[L20_2]
            L22_2 = L22_2.health
            if L22_2 <= 0 then
              L22_2 = TriggerClientEvent
              L23_2 = "rm_farming:removeplant"
              L24_2 = L3_2
              L25_2 = L8_2
              L26_2 = L14_2
              L27_2 = L20_2
              L22_2(L23_2, L24_2, L25_2, L26_2, L27_2)
              L22_2 = farms
              L22_2 = L22_2[L8_2]
              L22_2 = L22_2[L14_2]
              L22_2[L20_2] = nil
              L22_2 = TriggerClientEvent
              L23_2 = "vorp:TipRight"
              L24_2 = L3_2
              L25_2 = language
              L25_2 = L25_2.dmgnorec
              L26_2 = 50000
              L22_2(L23_2, L24_2, L25_2, L26_2)
            else
              L22_2 = TriggerClientEvent
              L23_2 = "vorp:TipRight"
              L24_2 = L3_2
              L25_2 = language
              L25_2 = L25_2.dmgrec
              L26_2 = 50000
              L22_2(L23_2, L24_2, L25_2, L26_2)
            end
          elseif "harvest" == A0_2 then
            L22_2 = Config
            L22_2 = L22_2.seeds
            L22_2 = L22_2[A1_2]
            L22_2 = L22_2.rewarditem
            L23_2 = pairs
            L24_2 = L22_2
            L23_2, L24_2, L25_2, L26_2 = L23_2(L24_2)
            for L27_2, L28_2 in L23_2, L24_2, L25_2, L26_2 do
              L29_2 = L28_2.count
              L30_2 = farms
              L30_2 = L30_2[L8_2]
              L30_2 = L30_2[L14_2]
              L30_2 = L30_2[L20_2]
              L30_2 = L30_2.trem
              if L30_2 then
                L30_2 = Config
                L30_2 = L30_2.seeds
                L30_2 = L30_2[A1_2]
                L30_2 = L30_2.trimboost
                L29_2 = L29_2 + L30_2
              end
              L30_2 = Config
              L30_2 = L30_2.plantredhp
              L31_2 = farms
              L31_2 = L31_2[L8_2]
              L31_2 = L31_2[L14_2]
              L31_2 = L31_2[L20_2]
              L31_2 = L31_2.health
              if L30_2 >= L31_2 then
                L30_2 = Config
                L30_2 = L30_2.nohealthsubamount
                L29_2 = L29_2 - L30_2
              end
              if L29_2 <= 0 then
                L29_2 = 1
              end
              L30_2 = L1_1.addItem
              L31_2 = L3_2
              L32_2 = L28_2.name
              L33_2 = L29_2
              L30_2(L31_2, L32_2, L33_2)
              L30_2 = language
              L30_2 = L30_2.harvest
              L31_2 = GetPlayerName
              L32_2 = L3_2
              L31_2 = L31_2(L32_2)
              L32_2 = L21_2.type
              L33_2 = Discord
              L34_2 = L30_2
              L35_2 = L31_2
              L36_2 = L32_2
              L33_2(L34_2, L35_2, L36_2)
              L33_2 = nil
              L34_2 = L28_2.label
              if nil ~= L34_2 then
                L33_2 = L28_2.label
              else
                L33_2 = L28_2.name
              end
              L34_2 = TriggerClientEvent
              L35_2 = "vorp:TipRight"
              L36_2 = L3_2
              L37_2 = language
              L37_2 = L37_2.got
              L38_2 = " "
              L39_2 = L29_2
              L40_2 = " "
              L41_2 = L33_2
              L37_2 = L37_2 .. L38_2 .. L39_2 .. L40_2 .. L41_2
              L38_2 = 50000
              L34_2(L35_2, L36_2, L37_2, L38_2)
              L34_2 = TriggerClientEvent
              L35_2 = "rm_farming:removeplant"
              L36_2 = L3_2
              L37_2 = L8_2
              L38_2 = L14_2
              L39_2 = L20_2
              L34_2(L35_2, L36_2, L37_2, L38_2, L39_2)
            end
            L23_2 = farms
            L23_2 = L23_2[L8_2]
            L23_2 = L23_2[L14_2]
            L23_2[L20_2] = nil
          end
        end
      end
    end
  end
  L4_2 = TriggerClientEvent
  L5_2 = "rm_farming:recinfo"
  L6_2 = L3_2
  L7_2 = farms
  L8_2 = "true"
  L4_2(L5_2, L6_2, L7_2, L8_2)
  L4_2 = TriggerClientEvent
  L5_2 = "rm_farming:recst"
  L6_2 = L3_2
  L4_2(L5_2, L6_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterServerEvent
L6_1 = "rm_farming:approvefarming"
L5_1(L6_1)
L5_1 = AddEventHandler
L6_1 = "rm_farming:approvefarming"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  L2_2 = source
  L3_2 = L0_1.getUser
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L3_2 = L3_2.getUsedCharacter
  L4_2 = L3_2.charIdentifier
  L5_2 = L3_2.job
  L6_2 = nil
  L7_2 = L1_1.subItem
  L8_2 = L2_2
  L9_2 = Config
  L9_2 = L9_2.seeds
  L9_2 = L9_2[A0_2]
  L9_2 = L9_2.seedname
  L10_2 = Config
  L10_2 = L10_2.seeds
  L10_2 = L10_2[A0_2]
  L10_2 = L10_2.seedreq
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = next
  L8_2 = farms
  L7_2 = L7_2(L8_2)
  if nil == L7_2 then
    L6_2 = 1
  end
  L7_2 = farms
  L7_2 = L7_2[L4_2]
  if nil == L7_2 then
    L7_2 = farms
    L8_2 = {}
    L7_2[L4_2] = L8_2
  end
  if nil == L6_2 then
    L7_2 = 0
    L8_2 = pairs
    L9_2 = farms
    L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
    for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
      L14_2 = pairs
      L15_2 = L13_2
      L14_2, L15_2, L16_2, L17_2 = L14_2(L15_2)
      for L18_2, L19_2 in L14_2, L15_2, L16_2, L17_2 do
        L20_2 = pairs
        L21_2 = L19_2
        L20_2, L21_2, L22_2, L23_2 = L20_2(L21_2)
        for L24_2, L25_2 in L20_2, L21_2, L22_2, L23_2 do
          L26_2 = L25_2.render
          if L7_2 < L26_2 then
            L7_2 = L25_2.render
          end
        end
      end
    end
    L6_2 = L7_2 + 1
  end
  L7_2 = farms
  L7_2 = L7_2[L4_2]
  L7_2 = L7_2[A0_2]
  if nil == L7_2 then
    L7_2 = farms
    L7_2 = L7_2[L4_2]
    L8_2 = {}
    L7_2[A0_2] = L8_2
    L7_2 = table
    L7_2 = L7_2.insert
    L8_2 = farms
    L8_2 = L8_2[L4_2]
    L8_2 = L8_2[A0_2]
    L9_2 = {}
    L9_2.lifetime = 0
    L10_2 = Config
    L10_2 = L10_2.seeds
    L10_2 = L10_2[A0_2]
    L10_2 = L10_2.difficulty
    L9_2.difficulty = L10_2
    L10_2 = Config
    L10_2 = L10_2.seeds
    L10_2 = L10_2[A0_2]
    L10_2 = L10_2.health
    L9_2.health = L10_2
    L9_2.type = A0_2
    L10_2 = Config
    L10_2 = L10_2.seeds
    L10_2 = L10_2[A0_2]
    L10_2 = L10_2.totaltime
    L9_2.timer = L10_2
    L9_2.coords = A1_2
    L9_2.render = L6_2
    L9_2.watered = false
    L9_2.fert = false
    L9_2.trem = false
    L7_2(L8_2, L9_2)
    L7_2 = TriggerClientEvent
    L8_2 = "rm_farming:recinfo"
    L9_2 = L2_2
    L10_2 = farms
    L11_2 = "true"
    L7_2(L8_2, L9_2, L10_2, L11_2)
  else
    L7_2 = farms
    L7_2 = L7_2[L4_2]
    L7_2 = L7_2[A0_2]
    if nil ~= L7_2 then
      L7_2 = totalcount
      L8_2 = farms
      L8_2 = L8_2[L4_2]
      L7_2 = L7_2(L8_2)
      L8_2 = keysx
      L9_2 = farms
      L9_2 = L9_2[L4_2]
      L9_2 = L9_2[A0_2]
      L8_2 = L8_2(L9_2)
      L9_2 = contains
      L10_2 = Config
      L10_2 = L10_2.farmerjobs
      L11_2 = L5_2
      L9_2 = L9_2(L10_2, L11_2)
      L10_2 = Config
      L10_2 = L10_2.totalplants
      L11_2 = Config
      L11_2 = L11_2.seeds
      L11_2 = L11_2[A0_2]
      L11_2 = L11_2.maxcount
      if L9_2 then
        L12_2 = Config
        L10_2 = L12_2.maxtotal
        L12_2 = Config
        L12_2 = L12_2.maxperplant
        L11_2 = L11_2 + L12_2
      end
      if L7_2 < L10_2 then
        if L8_2 < L11_2 then
          L12_2 = table
          L12_2 = L12_2.insert
          L13_2 = farms
          L13_2 = L13_2[L4_2]
          L13_2 = L13_2[A0_2]
          L14_2 = {}
          L14_2.lifetime = 0
          L15_2 = Config
          L15_2 = L15_2.seeds
          L15_2 = L15_2[A0_2]
          L15_2 = L15_2.difficulty
          L14_2.difficulty = L15_2
          L15_2 = Config
          L15_2 = L15_2.seeds
          L15_2 = L15_2[A0_2]
          L15_2 = L15_2.health
          L14_2.health = L15_2
          L14_2.type = A0_2
          L15_2 = Config
          L15_2 = L15_2.seeds
          L15_2 = L15_2[A0_2]
          L15_2 = L15_2.totaltime
          L14_2.timer = L15_2
          L14_2.coords = A1_2
          L14_2.render = L6_2
          L14_2.watered = false
          L14_2.fert = false
          L14_2.trem = false
          L12_2(L13_2, L14_2)
          L12_2 = TriggerClientEvent
          L13_2 = "rm_farming:recinfo"
          L14_2 = L2_2
          L15_2 = farms
          L16_2 = "true"
          L12_2(L13_2, L14_2, L15_2, L16_2)
        else
          L12_2 = TriggerClientEvent
          L13_2 = "vorp:TipRight"
          L14_2 = L2_2
          L15_2 = language
          L15_2 = L15_2.toomanyofkind
          L16_2 = 50000
          L12_2(L13_2, L14_2, L15_2, L16_2)
        end
      else
        L12_2 = TriggerClientEvent
        L13_2 = "vorp:TipRight"
        L14_2 = L2_2
        L15_2 = language
        L15_2 = L15_2.toomany
        L16_2 = 50000
        L12_2(L13_2, L14_2, L15_2, L16_2)
      end
    end
  end
  L7_2 = TriggerClientEvent
  L8_2 = "rm_farming:createblip"
  L9_2 = L2_2
  L10_2 = A0_2
  L11_2 = A1_2
  L12_2 = L6_2
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterServerEvent
L6_1 = "rm_farming:cleartofarm"
L5_1(L6_1)
L5_1 = AddEventHandler
L6_1 = "rm_farming:cleartofarm"
function L7_1()
  local L0_2, L1_2, L2_2
  L0_2 = source
  L1_2 = trem
  L2_2 = L0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1)
function L5_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L3_2 = ""
  L4_2 = Config
  L4_2 = L4_2.adminwebhook
  L5_2 = Config
  L5_2 = L5_2.webhookavatar
  L6_2 = 3447003
  L7_2 = A0_2
  L8_2 = {}
  L9_2 = {}
  L9_2.color = L6_2
  L9_2.title = L7_2
  L9_2.description = A2_2
  L8_2[1] = L9_2
  L3_2 = L8_2
  L8_2 = PerformHttpRequest
  L9_2 = L4_2
  function L10_2(A0_3, A1_3, A2_3)
  end
  L11_2 = "POST"
  L12_2 = json
  L12_2 = L12_2.encode
  L13_2 = {}
  L13_2.username = A1_2
  L13_2.avatar_url = L5_2
  L13_2.embeds = L3_2
  L12_2 = L12_2(L13_2)
  L13_2 = {}
  L13_2["Content-Type"] = "application/json"
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
end
Discord = L5_1
