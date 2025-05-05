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
L0_1 = exports
L0_1 = L0_1.vorp_inventory
L1_1 = L0_1
L0_1 = L0_1.vorp_inventoryApi
L0_1 = L0_1(L1_1)
Inventory = L0_1
L0_1 = RegisterServerEvent
L1_1 = "rm_sheriff_vorp:paysheriff"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "rm_sheriff_vorp:paysheriff"
function L2_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L0_2 = source
  L1_2 = false
  L2_2 = VorpCore
  L2_2 = L2_2.getUser
  L3_2 = L0_2
  L2_2 = L2_2(L3_2)
  L3_2 = L2_2.getUsedCharacter
  L4_2 = L3_2.job
  L5_2 = pairs
  L6_2 = Config
  L6_2 = L6_2.SheriffJobName
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    if L4_2 == L10_2 and false == L1_2 then
      L1_2 = true
      L11_2 = L3_2.addCurrency
      L12_2 = 0
      L13_2 = Config
      L13_2 = L13_2.PaymentMoney
      L11_2(L12_2, L13_2)
      L11_2 = TriggerClientEvent
      L12_2 = "rm_sheriff_vorp:not_payment"
      L13_2 = L0_2
      L11_2(L12_2, L13_2)
      break
    end
  end
end
L0_1(L1_1, L2_1)
L0_1 = RegisterServerEvent
L1_1 = "rm_sheriff_vorp:openofficemenu"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "rm_sheriff_vorp:openofficemenu"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L2_2 = source
  L3_2 = false
  L4_2 = VorpCore
  L4_2 = L4_2.getUser
  L5_2 = L2_2
  L4_2 = L4_2(L5_2)
  L5_2 = L4_2.getUsedCharacter
  L6_2 = L5_2.job
  L7_2 = pairs
  L8_2 = Config
  L8_2 = L8_2.SheriffJobName
  L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
  for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
    if L6_2 == L12_2 and false == L3_2 then
      L3_2 = true
      if true == A1_2 then
        L13_2 = TriggerClientEvent
        L14_2 = "rm_sheriff_vorp:SheriffOfficeMenu"
        L15_2 = L2_2
        L16_2 = A0_2
        L17_2 = A1_2
        L13_2(L14_2, L15_2, L16_2, L17_2)
        break
      end
      if false == A1_2 then
        L13_2 = nil
        L14_2 = false
        L15_2 = TriggerClientEvent
        L16_2 = "rm_sheriff_vorp:SheriffOfficeMenu"
        L17_2 = L2_2
        L18_2 = L13_2
        L19_2 = L14_2
        L15_2(L16_2, L17_2, L18_2, L19_2)
      end
      break
    end
  end
  if false == L3_2 then
    L7_2 = TriggerClientEvent
    L8_2 = "rm_sheriff_vorp:failed_not_sheriff"
    L9_2 = L2_2
    L7_2(L8_2, L9_2)
  end
end
L0_1(L1_1, L2_1)
L0_1 = RegisterCommand
L1_1 = Config
L1_1 = L1_1.SheriffMobileMenuCommand
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
  L9_2 = L9_2.SheriffJobName
  L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
  for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
    if L7_2 == L13_2 and false == L4_2 then
      L4_2 = true
      L14_2 = TriggerClientEvent
      L15_2 = "rm_sheriff_vorp:SheriffMobileMenu"
      L16_2 = L3_2
      L14_2(L15_2, L16_2)
      break
    end
  end
  if false == L4_2 then
    L8_2 = TriggerClientEvent
    L9_2 = "rm_sheriff_vorp:failed_not_sheriff"
    L10_2 = L3_2
    L8_2(L9_2, L10_2)
  end
end
L3_1 = false
L0_1(L1_1, L2_1, L3_1)
L0_1 = RegisterServerEvent
L1_1 = "rm_sheriff_vorp:getitemitem"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "rm_sheriff_vorp:getitemitem"
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  L3_2 = source
  L4_2 = false
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = A2_2
  L8_2 = L7_2 * L6_2
  L9_2 = VorpCore
  L9_2 = L9_2.getUser
  L10_2 = L3_2
  L9_2 = L9_2(L10_2)
  L10_2 = L9_2.getUsedCharacter
  L11_2 = L10_2.job
  L12_2 = pairs
  L13_2 = Config
  L13_2 = L13_2.SheriffJobName
  L12_2, L13_2, L14_2, L15_2 = L12_2(L13_2)
  for L16_2, L17_2 in L12_2, L13_2, L14_2, L15_2 do
    if L11_2 == L17_2 and false == L4_2 then
      L4_2 = true
      L18_2 = L10_2.money
      if L8_2 <= L18_2 then
        if L8_2 > 0 then
          L18_2 = L10_2.removeCurrency
          L19_2 = 0
          L20_2 = L8_2
          L18_2(L19_2, L20_2)
        end
        L18_2 = Inventory
        L18_2 = L18_2.addItem
        L19_2 = L3_2
        L20_2 = L5_2
        L21_2 = L7_2
        L18_2(L19_2, L20_2, L21_2)
        L18_2 = TriggerClientEvent
        L19_2 = "rm_sheriff_vorp:not_payment_armory"
        L20_2 = L3_2
        L21_2 = L5_2
        L22_2 = L7_2
        L23_2 = L8_2
        L24_2 = true
        L18_2(L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
        break
      end
      L18_2 = TriggerClientEvent
      L19_2 = "rm_sheriff_vorp:not_payment_armory"
      L20_2 = L3_2
      L21_2 = L5_2
      L22_2 = L7_2
      L23_2 = L8_2
      L24_2 = false
      L18_2(L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
      break
    end
  end
  if false == L4_2 then
    L12_2 = TriggerClientEvent
    L13_2 = "rm_sheriff_vorp:failed_not_sheriff"
    L14_2 = L3_2
    L12_2(L13_2, L14_2)
  end
end
L0_1(L1_1, L2_1)
L0_1 = RegisterServerEvent
L1_1 = "rm_sheriff_vorp:openwagonsmenu"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "rm_sheriff_vorp:openwagonsmenu"
function L2_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L4_2 = source
  L5_2 = false
  L6_2 = VorpCore
  L6_2 = L6_2.getUser
  L7_2 = L4_2
  L6_2 = L6_2(L7_2)
  L7_2 = L6_2.getUsedCharacter
  L8_2 = L7_2.job
  L9_2 = pairs
  L10_2 = Config
  L10_2 = L10_2.SheriffJobName
  L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
  for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
    if L8_2 == L14_2 and false == L5_2 then
      L5_2 = true
      L15_2 = TriggerClientEvent
      L16_2 = "rm_sheriff_vorp:SheriffWagonsMenu"
      L17_2 = L4_2
      L18_2 = A0_2
      L19_2 = A1_2
      L20_2 = A2_2
      L21_2 = A3_2
      L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      break
    end
  end
  if false == L5_2 then
    L9_2 = TriggerClientEvent
    L10_2 = "rm_sheriff_vorp:failed_not_sheriff"
    L11_2 = L4_2
    L9_2(L10_2, L11_2)
  end
end
L0_1(L1_1, L2_1)
L0_1 = RegisterServerEvent
L1_1 = "rm_sheriff_vorp:search_money"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "rm_sheriff_vorp:search_money"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = source
  L2_2 = VorpCore
  L2_2 = L2_2.getUser
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = L2_2.getUsedCharacter
  L4_2 = L3_2.identifier
  L5_2 = {}
  L6_2 = table
  L6_2 = L6_2.insert
  L7_2 = L5_2
  L8_2 = {}
  L9_2 = Config
  L9_2 = L9_2.MoneyName
  L8_2.Name = L9_2
  L9_2 = L3_2.money
  L8_2.Quantity = L9_2
  L6_2(L7_2, L8_2)
  L6_2 = TriggerClientEvent
  L7_2 = "rm_sheriff_vorp:inspectPlayerClient"
  L8_2 = L1_2
  L9_2 = L4_2
  L10_2 = L5_2
  L6_2(L7_2, L8_2, L9_2, L10_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterServerEvent
L1_1 = "rm_sheriff_vorp:steal_money"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "rm_sheriff_vorp:steal_money"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = source
  L3_2 = VorpCore
  L3_2 = L3_2.getUser
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = L3_2.getUsedCharacter
  L5_2 = L4_2.money
  if A1_2 <= L5_2 then
    L5_2 = TriggerEvent
    L6_2 = "vorp:addMoney"
    L7_2 = L2_2
    L8_2 = 0
    L9_2 = tonumber
    L10_2 = A1_2
    L9_2, L10_2 = L9_2(L10_2)
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
    L5_2 = TriggerEvent
    L6_2 = "vorp:removeMoney"
    L7_2 = A0_2
    L8_2 = 0
    L9_2 = tonumber
    L10_2 = A1_2
    L9_2, L10_2 = L9_2(L10_2)
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  end
  L5_2 = TriggerClientEvent
  L6_2 = "rm_sheriff_vorp:smainmenuopen"
  L7_2 = L2_2
  L5_2(L6_2, L7_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterServerEvent
L1_1 = "rm_sheriff_vorp:search_item"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "rm_sheriff_vorp:search_item"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = source
  L2_2 = VorpCore
  L2_2 = L2_2.getUser
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = L2_2.getUsedCharacter
  L4_2 = L3_2.identifier
  L5_2 = {}
  L6_2 = TriggerEvent
  L7_2 = "vorpCore:getUserInventory"
  L8_2 = tonumber
  L9_2 = A0_2
  L8_2 = L8_2(L9_2)
  function L9_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L1_3 = pairs
    L2_3 = A0_3
    L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3)
    for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
      L7_3 = table
      L7_3 = L7_3.insert
      L8_3 = L5_2
      L9_3 = {}
      L10_3 = L6_3.name
      L9_3.Id = L10_3
      L10_3 = L6_3.label
      L9_3.Name = L10_3
      L10_3 = L6_3.count
      L9_3.Quantity = L10_3
      L7_3(L8_3, L9_3)
    end
  end
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = TriggerClientEvent
  L7_2 = "rm_sheriff_vorp:inspectPlayerClient2"
  L8_2 = L1_2
  L9_2 = L4_2
  L10_2 = L5_2
  L6_2(L7_2, L8_2, L9_2, L10_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterServerEvent
L1_1 = "rm_sheriff_vorp:steal_items"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "rm_sheriff_vorp:steal_items"
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L3_2 = source
  L4_2 = VorpCore
  L4_2 = L4_2.getUser
  L5_2 = A1_2
  L4_2 = L4_2(L5_2)
  L5_2 = L4_2.getUsedCharacter
  L6_2 = Inventory
  L6_2 = L6_2.getItemCount
  L7_2 = A1_2
  L8_2 = A0_2
  L6_2 = L6_2(L7_2, L8_2)
  L7_2 = tonumber
  L8_2 = A2_2
  L7_2 = L7_2(L8_2)
  if L6_2 >= L7_2 then
    L7_2 = Inventory
    L7_2 = L7_2.addItem
    L8_2 = L3_2
    L9_2 = A0_2
    L10_2 = tonumber
    L11_2 = A2_2
    L10_2, L11_2 = L10_2(L11_2)
    L7_2(L8_2, L9_2, L10_2, L11_2)
    L7_2 = Inventory
    L7_2 = L7_2.subItem
    L8_2 = A1_2
    L9_2 = A0_2
    L10_2 = tonumber
    L11_2 = A2_2
    L10_2, L11_2 = L10_2(L11_2)
    L7_2(L8_2, L9_2, L10_2, L11_2)
  end
  L7_2 = TriggerClientEvent
  L8_2 = "rm_sheriff_vorp:smainmenuopen"
  L9_2 = L3_2
  L7_2(L8_2, L9_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterServerEvent
L1_1 = "rm_sheriff_vorp:search_weapon"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "rm_sheriff_vorp:search_weapon"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = source
  L2_2 = VorpCore
  L2_2 = L2_2.getUser
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = L2_2.getUsedCharacter
  L4_2 = L3_2.identifier
  L5_2 = {}
  L6_2 = TriggerEvent
  L7_2 = "vorpCore:getUserWeapons"
  L8_2 = A0_2
  function L9_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    if nil ~= A0_3 then
      L1_3 = pairs
      L2_3 = A0_3
      L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3)
      for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
        L7_3 = table
        L7_3 = L7_3.insert
        L8_3 = L5_2
        L9_3 = {}
        L10_3 = getWeaponNameFromId
        L11_3 = L6_3.id
        L10_3 = L10_3(L11_3)
        L9_3.Id = L10_3
        L10_3 = getWeaponNameFromId
        L11_3 = L6_3.name
        L10_3 = L10_3(L11_3)
        L9_3.Name = L10_3
        L9_3.Quantity = "1"
        L10_3 = L6_3.name
        L9_3.Realname = L10_3
        L7_3(L8_3, L9_3)
      end
    end
  end
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = TriggerClientEvent
  L7_2 = "rm_sheriff_vorp:inspectPlayerClient3"
  L8_2 = L1_2
  L9_2 = L4_2
  L10_2 = L5_2
  L6_2(L7_2, L8_2, L9_2, L10_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterServerEvent
L1_1 = "rm_sheriff_vorp:steal_weapon"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "rm_sheriff_vorp:steal_weapon"
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = source
  L4_2 = VorpCore
  L4_2 = L4_2.getUser
  L5_2 = A1_2
  L4_2 = L4_2(L5_2)
  L5_2 = L4_2.getUsedCharacter
  L6_2 = TriggerEvent
  L7_2 = "vorpCore:getUserWeapons"
  L8_2 = A1_2
  function L9_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3
    if nil ~= A0_3 then
      L1_3 = Inventory
      L1_3 = L1_3.giveWeapon
      L2_3 = L3_2
      L3_3 = A0_2
      L4_3 = A1_2
      L1_3(L2_3, L3_3, L4_3)
    end
  end
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = TriggerClientEvent
  L7_2 = "rm_sheriff_vorp:smainmenuopen"
  L8_2 = L3_2
  L6_2(L7_2, L8_2)
end
L0_1(L1_1, L2_1)
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2
  L1_2 = {}
  L2_2 = {}
  L2_2.id = "WEAPON_MELEE_KNIFE_TRADER"
  L3_2 = Config
  L3_2 = L3_2.WEAPON_MELEE_KNIFE_TRADER
  L2_2.name = L3_2
  L3_2 = {}
  L3_2.id = "WEAPON_MELEE_KNIFE"
  L4_2 = Config
  L4_2 = L4_2.WEAPON_MELEE_KNIFE
  L3_2.name = L4_2
  L4_2 = {}
  L4_2.id = "WEAPON_MELEE_KNIFE_JAWBONE"
  L5_2 = Config
  L5_2 = L5_2.WEAPON_MELEE_KNIFE_JAWBONE
  L4_2.name = L5_2
  L5_2 = {}
  L5_2.id = "WEAPON_MELEE_CLEAVER"
  L6_2 = Config
  L6_2 = L6_2.WEAPON_MELEE_CLEAVER
  L5_2.name = L6_2
  L6_2 = {}
  L6_2.id = "WEAPON_MELEE_HATCHET_HUNTER"
  L7_2 = Config
  L7_2 = L7_2.WEAPON_MELEE_HATCHET_HUNTER
  L6_2.name = L7_2
  L7_2 = {}
  L7_2.id = "WEAPON_MELEE_MACHETE"
  L8_2 = Config
  L8_2 = L8_2.WEAPON_MELEE_MACHETE
  L7_2.name = L8_2
  L8_2 = {}
  L8_2.id = "WEAPON_MELEE_MACHETE_COLLECTOR"
  L9_2 = Config
  L9_2 = L9_2.WEAPON_MELEE_MACHETE_COLLECTOR
  L8_2.name = L9_2
  L9_2 = {}
  L9_2.id = "WEAPON_BOW"
  L10_2 = Config
  L10_2 = L10_2.WEAPON_BOW
  L9_2.name = L10_2
  L10_2 = {}
  L10_2.id = "WEAPON_BOW_IMPROVED"
  L11_2 = Config
  L11_2 = L11_2.WEAPON_BOW_IMPROVED
  L10_2.name = L11_2
  L11_2 = {}
  L11_2.id = "WEAPON_RIFLE_ELEPHANT"
  L12_2 = Config
  L12_2 = L12_2.WEAPON_RIFLE_ELEPHANT
  L11_2.name = L12_2
  L12_2 = {}
  L12_2.id = "WEAPON_RIFLE_VARMINT"
  L13_2 = Config
  L13_2 = L13_2.WEAPON_RIFLE_VARMINT
  L12_2.name = L13_2
  L13_2 = {}
  L13_2.id = "WEAPON_SNIPERRIFLE_ROLLINGBLOCK"
  L14_2 = Config
  L14_2 = L14_2.WEAPON_SNIPERRIFLE_ROLLINGBLOCK
  L13_2.name = L14_2
  L14_2 = {}
  L14_2.id = "WEAPON_SNIPERRIFLE_CARCANO"
  L15_2 = Config
  L15_2 = L15_2.WEAPON_SNIPERRIFLE_CARCANO
  L14_2.name = L15_2
  L15_2 = {}
  L15_2.id = "WEAPON_RIFLE_SPRINGFIELD"
  L16_2 = Config
  L16_2 = L16_2.WEAPON_RIFLE_SPRINGFIELD
  L15_2.name = L16_2
  L16_2 = {}
  L16_2.id = "WEAPON_RIFLE_BOLTACTION"
  L17_2 = Config
  L17_2 = L17_2.WEAPON_RIFLE_BOLTACTION
  L16_2.name = L17_2
  L17_2 = {}
  L17_2.id = "WEAPON_REPEATER_WINCHESTER"
  L18_2 = Config
  L18_2 = L18_2.WEAPON_REPEATER_WINCHESTER
  L17_2.name = L18_2
  L18_2 = {}
  L18_2.id = "WEAPON_REPEATER_HENRY"
  L19_2 = Config
  L19_2 = L19_2.WEAPON_REPEATER_HENRY
  L18_2.name = L19_2
  L19_2 = {}
  L19_2.id = "WEAPON_REPEATER_EVANS"
  L20_2 = Config
  L20_2 = L20_2.WEAPON_REPEATER_EVANS
  L19_2.name = L20_2
  L20_2 = {}
  L20_2.id = "WEAPON_REPEATER_CARBINE"
  L21_2 = Config
  L21_2 = L21_2.WEAPON_REPEATER_CARBINE
  L20_2.name = L21_2
  L21_2 = {}
  L21_2.id = "WEAPON_PISTOL_SEMIAUTO"
  L22_2 = Config
  L22_2 = L22_2.WEAPON_PISTOL_SEMIAUTO
  L21_2.name = L22_2
  L22_2 = {}
  L22_2.id = "WEAPON_PISTOL_MAUSER"
  L23_2 = Config
  L23_2 = L23_2.WEAPON_PISTOL_MAUSER
  L22_2.name = L23_2
  L23_2 = {}
  L23_2.id = "WEAPON_PISTOL_VOLCANIC"
  L24_2 = Config
  L24_2 = L24_2.WEAPON_PISTOL_VOLCANIC
  L23_2.name = L24_2
  L24_2 = {}
  L24_2.id = "WEAPON_PISTOL_M1899"
  L25_2 = Config
  L25_2 = L25_2.WEAPON_PISTOL_M1899
  L24_2.name = L25_2
  L25_2 = {}
  L25_2.id = "WEAPON_REVOLVER_SCHOFIELD"
  L26_2 = Config
  L26_2 = L26_2.WEAPON_REVOLVER_SCHOFIELD
  L25_2.name = L26_2
  L26_2 = {}
  L26_2.id = "WEAPON_REVOLVER_LEMAT"
  L27_2 = Config
  L27_2 = L27_2.WEAPON_REVOLVER_LEMAT
  L26_2.name = L27_2
  L27_2 = {}
  L27_2.id = "WEAPON_REVOLVER_DOUBLEACTION"
  L28_2 = Config
  L28_2 = L28_2.WEAPON_REVOLVER_DOUBLEACTION
  L27_2.name = L28_2
  L28_2 = {}
  L28_2.id = "WEAPON_REVOLVER_CATTLEMAN"
  L29_2 = Config
  L29_2 = L29_2.WEAPON_REVOLVER_CATTLEMAN
  L28_2.name = L29_2
  L29_2 = {}
  L29_2.id = "WEAPON_REVOLVER_NAVY"
  L30_2 = Config
  L30_2 = L30_2.WEAPON_REVOLVER_NAVY
  L29_2.name = L30_2
  L30_2 = {}
  L30_2.id = "WEAPON_THROWN_TOMAHAWK"
  L31_2 = Config
  L31_2 = L31_2.WEAPON_THROWN_TOMAHAWK
  L30_2.name = L31_2
  L31_2 = {}
  L31_2.id = "WEAPON_THROWN_THROWING_KNIVES"
  L32_2 = Config
  L32_2 = L32_2.WEAPON_THROWN_THROWING_KNIVES
  L31_2.name = L32_2
  L32_2 = {}
  L32_2.id = "WEAPON_THROWN_POISONBOTTLE"
  L33_2 = Config
  L33_2 = L33_2.WEAPON_THROWN_POISONBOTTLE
  L32_2.name = L33_2
  L33_2 = {}
  L33_2.id = "WEAPON_THROWN_BOLAS"
  L34_2 = Config
  L34_2 = L34_2.WEAPON_THROWN_BOLAS
  L33_2.name = L34_2
  L34_2 = {}
  L34_2.id = "WEAPON_THROWN_DYNAMITE"
  L35_2 = Config
  L35_2 = L35_2.WEAPON_THROWN_DYNAMITE
  L34_2.name = L35_2
  L35_2 = {}
  L35_2.id = "WEAPON_THROWN_MOLOTOV"
  L36_2 = Config
  L36_2 = L36_2.WEAPON_THROWN_MOLOTOV
  L35_2.name = L36_2
  L36_2 = {}
  L36_2.id = "WEAPON_SHOTGUN_SEMIAUTO"
  L37_2 = Config
  L37_2 = L37_2.WEAPON_SHOTGUN_SEMIAUTO
  L36_2.name = L37_2
  L37_2 = {}
  L37_2.id = "WEAPON_SHOTGUN_SAWEDOFF"
  L38_2 = Config
  L38_2 = L38_2.WEAPON_SHOTGUN_SAWEDOFF
  L37_2.name = L38_2
  L38_2 = {}
  L38_2.id = "WEAPON_SHOTGUN_REPEATING"
  L39_2 = Config
  L39_2 = L39_2.WEAPON_SHOTGUN_REPEATING
  L38_2.name = L39_2
  L39_2 = {}
  L39_2.id = "WEAPON_SHOTGUN_PUMP"
  L40_2 = Config
  L40_2 = L40_2.WEAPON_SHOTGUN_PUMP
  L39_2.name = L40_2
  L40_2 = {}
  L40_2.id = "WEAPON_SHOTGUN_DOUBLEBARREL"
  L41_2 = Config
  L41_2 = L41_2.WEAPON_SHOTGUN_DOUBLEBARREL
  L40_2.name = L41_2
  L41_2 = {}
  L41_2.id = "WEAPON_LASSO"
  L42_2 = Config
  L42_2 = L42_2.WEAPON_LASSO
  L41_2.name = L42_2
  L42_2 = {}
  L42_2.id = "WEAPON_LASSO_REINFORCED"
  L43_2 = Config
  L43_2 = L43_2.WEAPON_LASSO_REINFORCED
  L42_2.name = L43_2
  L43_2 = {}
  L43_2.id = "WEAPON_KIT_BINOCULARS_IMPROVED"
  L44_2 = Config
  L44_2 = L44_2.WEAPON_KIT_BINOCULARS_IMPROVED
  L43_2.name = L44_2
  L44_2 = {}
  L44_2.id = "WEAPON_KIT_BINOCULARS"
  L45_2 = Config
  L45_2 = L45_2.WEAPON_KIT_BINOCULARS
  L44_2.name = L45_2
  L45_2 = {}
  L45_2.id = "WEAPON_FISHINGROD"
  L46_2 = Config
  L46_2 = L46_2.WEAPON_FISHINGROD
  L45_2.name = L46_2
  L46_2 = {}
  L46_2.id = "WEAPON_KIT_CAMERA"
  L47_2 = Config
  L47_2 = L47_2.WEAPON_KIT_CAMERA
  L46_2.name = L47_2
  L47_2 = {}
  L47_2.id = "WEAPON_KIT_CAMERA_ADVANCED"
  L48_2 = Config
  L48_2 = L48_2.WEAPON_KIT_CAMERA_ADVANCED
  L47_2.name = L48_2
  L48_2 = {}
  L48_2.id = "WEAPON_MELEE_LANTERN"
  L49_2 = Config
  L49_2 = L49_2.WEAPON_MELEE_LANTERN
  L48_2.name = L49_2
  L49_2 = {}
  L49_2.id = "WEAPON_MELEE_DAVY_LANTERN"
  L50_2 = Config
  L50_2 = L50_2.WEAPON_MELEE_DAVY_LANTERN
  L49_2.name = L50_2
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L1_2[3] = L4_2
  L1_2[4] = L5_2
  L1_2[5] = L6_2
  L1_2[6] = L7_2
  L1_2[7] = L8_2
  L1_2[8] = L9_2
  L1_2[9] = L10_2
  L1_2[10] = L11_2
  L1_2[11] = L12_2
  L1_2[12] = L13_2
  L1_2[13] = L14_2
  L1_2[14] = L15_2
  L1_2[15] = L16_2
  L1_2[16] = L17_2
  L1_2[17] = L18_2
  L1_2[18] = L19_2
  L1_2[19] = L20_2
  L1_2[20] = L21_2
  L1_2[21] = L22_2
  L1_2[22] = L23_2
  L1_2[23] = L24_2
  L1_2[24] = L25_2
  L1_2[25] = L26_2
  L1_2[26] = L27_2
  L1_2[27] = L28_2
  L1_2[28] = L29_2
  L1_2[29] = L30_2
  L1_2[30] = L31_2
  L1_2[31] = L32_2
  L1_2[32] = L33_2
  L1_2[33] = L34_2
  L1_2[34] = L35_2
  L1_2[35] = L36_2
  L1_2[36] = L37_2
  L1_2[37] = L38_2
  L1_2[38] = L39_2
  L1_2[39] = L40_2
  L1_2[40] = L41_2
  L1_2[41] = L42_2
  L1_2[42] = L43_2
  L1_2[43] = L44_2
  L1_2[44] = L45_2
  L1_2[45] = L46_2
  L1_2[46] = L47_2
  L1_2[47] = L48_2
  L1_2[48] = L49_2
  L2_2 = nil
  L3_2 = pairs
  L4_2 = L1_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = L8_2.id
    if A0_2 == L9_2 then
      L2_2 = L8_2.name
    end
  end
  if nil == L2_2 then
    L2_2 = A0_2
  end
  return L2_2
end
getWeaponNameFromId = L0_1
L0_1 = Citizen
L0_1 = L0_1.CreateThread
function L1_1()
  local L0_2, L1_2
  L0_2 = GetCurrentResourceName
  L0_2 = L0_2()
  if "rm_sheriff_vorp" ~= L0_2 then
    -- L0_2 = print
    -- L1_2 = "^1====================================="
    -- L0_2(L1_2)
    -- L0_2 = print
    -- L1_2 = "^1SCRIPT NAME OTHER THAN ORIGINAL"
    -- L0_2(L1_2)
    -- L0_2 = print
    -- L1_2 = "^1THERE WILL/MAY BE PROBLEMS WITH THE SCRIPT IF THE NAME IS CHANGED"
    -- L0_2(L1_2)
    -- L0_2 = print
    -- L1_2 = "^1CHANGE NAME TO: ^2rm_sheriff_vorp^1"
    -- L0_2(L1_2)
    -- L0_2 = print
    -- L1_2 = "^1=====================================^0"
    -- L0_2(L1_2)
  end
end
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "onResourceStart"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if L1_2 ~= A0_2 then
    return
  end

end
L0_1(L1_1, L2_1)
