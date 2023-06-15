QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('resource:server:paydeposit', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        local Paid = Player.Functions.RemoveMoney('cash', 100, 'auto-borg')
        if Paid then
            TriggerClientEvent('QBCore:Notify', source, "You rented a car", "success")
        else
            TriggerClientEvent('QBCore:Notify', source, "Not enough cash", "error")
        end
        cb(Paid)
    end
end)

QBCore.Functions.CreateCallback('resource:server:returnBorg', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        Player.Functions.AddMoney('cash', 100, 'auto-borg')
        TriggerClientEvent('QBCore:Notify', source, "You returned the car", 'success')
        cb(true)
    end
end)

QBCore.Functions.CreateCallback('resource:server:giveweed', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem('weed_brick', 5)
    TriggerClientEvent('QBCore:Notify', source, "Picked up weed", "success")
end)

QBCore.Functions.CreateCallback('resource:server:dropoffweed', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local item = Player.Functions.GetItemByName('weed_brick')
    local removed = Player.Functions.RemoveItem(item.name, 5, item.slot)
    if removed then Player.Functions.AddMoney('cash', 1000, 'dropoff-money') end
    cb(removed)
end)

QBCore.Functions.CreateCallback('resource:server:returndeposit', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        Player.Functions.AddMoney('cash', 100, 'auto-borg')
        cb(true)
    end
end)

QBCore.Functions.CreateCallback('resource:server:payout', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddMoney('cash', 750, 'payout')
end)
