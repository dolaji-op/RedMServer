-- Helper function to find value in table
local function table_find(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

VORP = exports.vorp_core:vorpAPI()

RegisterNetEvent("bst-law:SendNotifications")
AddEventHandler("bst-law:SendNotifications", function(players, coords)
  for each, player in ipairs(players) do
    local user = VORP.getCharacter(player)
    if user ~= nil then
      local job = user.job
      if table_find(Config.LawJob, job) then
        TriggerClientEvent("bst-law:NotifyLaw", player, coords)
      end
    else
      print("Notified???")
    end
  end
end)

RegisterNetEvent("bst-law:CheckJob")
AddEventHandler("bst-law:CheckJob", function()
  local _source = source
  TriggerEvent("vorp:getCharacter", _source, function(user)
    local job = user.job
    print('Job: ' .. job)
    if not table_find(Config.LawJob, job) then
      TriggerClientEvent("bst-law:TriggerWanted", _source)
      print("WantedTriggered")
    end
  end)
end)







