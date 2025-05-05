local L0_1, L1_1, L2_1, L3_1
L0_1 = {}
VorpCore = L0_1
L0_1 = TriggerEvent
L1_1 = "getCore"
function L2_1(A0_2)
  local L1_2
  VorpCore = A0_2
end
L0_1(L1_1, L2_1)
L0_1 = RegisterServerEvent
L1_1 = "rm_prison:check_prison_time"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "rm_prison:check_prison_time"
function L2_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = source
  L1_2 = GetPlayerIdentifier
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  L2_2 = VorpCore
  L2_2 = L2_2.getUser
  L3_2 = L0_2
  L2_2 = L2_2(L3_2)
  L3_2 = L2_2.getUsedCharacter
  L4_2 = L3_2.charIdentifier
  L5_2 = exports
  L5_2 = L5_2.ghmattimysql
  L6_2 = L5_2
  L5_2 = L5_2.execute
  L7_2 = "SELECT * FROM rm_prison WHERE identifier = @identifier AND characterid = @characterid"
  L8_2 = {}
  L8_2["@identifier"] = L1_2
  L8_2["@characterid"] = L4_2
  function L9_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    L1_3 = A0_3[1]
    if nil ~= L1_3 then
      L1_3 = tonumber
      L2_3 = A0_3[1]
      L2_3 = L2_3.prison_number
      L1_3 = L1_3(L2_3)
      L2_3 = tonumber
      L3_3 = A0_3[1]
      L3_3 = L3_3.prison_time
      L2_3 = L2_3(L3_3)
      L3_3 = TriggerClientEvent
      L4_3 = "rm_prison:FirstLoad_2"
      L5_3 = L0_2
      L6_3 = L1_3
      L7_3 = L2_3
      L3_3(L4_3, L5_3, L6_3, L7_3)
    end
  end
  L5_2(L6_2, L7_2, L8_2, L9_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterServerEvent
L1_1 = "rm_prison:put_in_jail"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "rm_prison:put_in_jail"
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  L3_2 = source
  L4_2 = A0_2
  L5_2 = false
  L6_2 = VorpCore
  L6_2 = L6_2.getUser
  L7_2 = L3_2
  L6_2 = L6_2(L7_2)
  L7_2 = L6_2.getUsedCharacter
  L8_2 = L7_2.job
  L9_2 = pairs
  L10_2 = Config
  L10_2 = L10_2.JobName
  L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
  for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
    if L8_2 == L14_2 and false == L5_2 then
      L5_2 = true
      L15_2 = GetPlayerIdentifier
      L16_2 = L4_2
      L15_2 = L15_2(L16_2)
      L16_2 = VorpCore
      L16_2 = L16_2.getUser
      L17_2 = L4_2
      L16_2 = L16_2(L17_2)
      L17_2 = L16_2.getUsedCharacter
      L18_2 = L17_2.charIdentifier
      L19_2 = A2_2 * 60
      L20_2 = exports
      L20_2 = L20_2.ghmattimysql
      L21_2 = L20_2
      L20_2 = L20_2.execute
      L22_2 = "INSERT INTO rm_prison (identifier, characterid, prison_number, prison_time) VALUES (@identifier, @characterid, @prison_number, @prison_time)"
      L23_2 = {}
      L23_2["@identifier"] = L15_2
      L23_2["@characterid"] = L18_2
      L23_2["@prison_number"] = A1_2
      L23_2["@prison_time"] = L19_2
      function L24_2(A0_3)
        local L1_3, L2_3, L3_3, L4_3, L5_3
        if nil ~= A0_3 then
          L1_3 = TriggerClientEvent
          L2_3 = "rm_prison:FirstLoad_2"
          L3_3 = L4_2
          L4_3 = A1_2
          L5_3 = L19_2
          L1_3(L2_3, L3_3, L4_3, L5_3)
        end
      end
      L20_2(L21_2, L22_2, L23_2, L24_2)
      break
    end
  end
end
L0_1(L1_1, L2_1)
L0_1 = RegisterServerEvent
L1_1 = "rm_prison:unjail"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "rm_prison:unjail"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L2_2 = source
  L3_2 = A0_2
  L4_2 = GetPlayerIdentifier
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = VorpCore
  L5_2 = L5_2.getUser
  L6_2 = L3_2
  L5_2 = L5_2(L6_2)
  L6_2 = L5_2.getUsedCharacter
  L7_2 = L6_2.charIdentifier
  L8_2 = exports
  L8_2 = L8_2.ghmattimysql
  L9_2 = L8_2
  L8_2 = L8_2.execute
  L10_2 = "DELETE FROM rm_prison WHERE identifier = @identifier AND characterid = @characterid"
  L11_2 = {}
  L11_2["@identifier"] = L4_2
  L11_2["@characterid"] = L7_2
  function L12_2(A0_3)
    local L1_3
  end
  L8_2(L9_2, L10_2, L11_2, L12_2)
  L8_2 = TriggerClientEvent
  L9_2 = "rm_prison:update_unjail"
  L10_2 = L3_2
  L8_2(L9_2, L10_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterServerEvent
L1_1 = "rm_prison:update_prison_time"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "rm_prison:update_prison_time"
function L2_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = source
  L1_2 = GetPlayerIdentifier
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  L2_2 = VorpCore
  L2_2 = L2_2.getUser
  L3_2 = L0_2
  L2_2 = L2_2(L3_2)
  L3_2 = L2_2.getUsedCharacter
  L4_2 = L3_2.charIdentifier
  L5_2 = exports
  L5_2 = L5_2.ghmattimysql
  L6_2 = L5_2
  L5_2 = L5_2.execute
  L7_2 = "SELECT * FROM rm_prison WHERE identifier = @identifier AND characterid = @characterid"
  L8_2 = {}
  L8_2["@identifier"] = L1_2
  L8_2["@characterid"] = L4_2
  function L9_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    L1_3 = A0_3[1]
    if nil ~= L1_3 then
      L1_3 = A0_3[1]
      L1_3 = L1_3.prison_time
      L1_3 = L1_3 - 60
      L2_3 = exports
      L2_3 = L2_3.ghmattimysql
      L3_3 = L2_3
      L2_3 = L2_3.execute
      L4_3 = "UPDATE rm_prison SET prison_time = @prison_time WHERE identifier = @identifier AND characterid = @characterid"
      L5_3 = {}
      L5_3["@prison_time"] = L1_3
      L6_3 = L1_2
      L5_3["@identifier"] = L6_3
      L6_3 = L4_2
      L5_3["@characterid"] = L6_3
      L2_3(L3_3, L4_3, L5_3)
    end
  end
  L5_2(L6_2, L7_2, L8_2, L9_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterCommand
L1_1 = Config
L1_1 = L1_1.JailMenuCommand
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L3_2 = A0_2
  L4_2 = false
  L5_2 = VorpCore
  L5_2 = L5_2.getUser
  L6_2 = L3_2
  L5_2 = L5_2(L6_2)
  L6_2 = L5_2.getUsedCharacter
  L7_2 = L6_2.job
  L8_2 = pairs
  L9_2 = Config
  L9_2 = L9_2.JobName
  L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
  for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
    if L7_2 == L13_2 and false == L4_2 then
      L4_2 = true
      L14_2 = TriggerClientEvent
      L15_2 = "rm_prison:open_jail_menu"
      L16_2 = L3_2
      L14_2(L15_2, L16_2)
      break
    end
  end
end
L3_1 = false
L0_1(L1_1, L2_1, L3_1)
L0_1 = AddEventHandler
L1_1 = "onResourceStart"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if L1_2 ~= A0_2 then
    return
  end
  -- L1_2 = print
  -- L2_2 = "^6 "
  -- L3_2 = A0_2
  -- L4_2 = "^2 Successfully Loaded ^7"
  -- L2_2 = L2_2 .. L3_2 .. L4_2
  -- L1_2(L2_2)
  -- L1_2 = print
  -- L2_2 = "^1 Developed by fm ^7"
  -- L1_2(L2_2)
  -- L1_2 = print
  -- L2_2 = "^7 If you got any question or require support join:^5  ^7"
  -- L1_2(L2_2)
end
L0_1(L1_1, L2_1)
