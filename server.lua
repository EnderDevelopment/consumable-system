local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('water_bottle', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('ConsumableSystem:useItem', source, 'water_bottle')
end)

ESX.RegisterUsableItem('burger', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('ConsumableSystem:useItem', source, 'burger')
end)

ESX.RegisterUsableItem('beer', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('ConsumableSystem:useItem', source, 'beer')
end)

RegisterServerEvent('ConsumableSystem:consumeItem')
AddEventHandler('ConsumableSystem:consumeItem', function(itemName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(itemName)

    if item.count > 0 then
        xPlayer.removeInventoryItem(itemName, 1)
        MySQL.Async.execute('UPDATE consumables SET durability = durability - 10 WHERE item_name = @itemName', {
            ['@itemName'] = itemName
        }, function(rowsChanged)
            if rowsChanged > 0 then
                MySQL.Async.fetchScalar('SELECT durability FROM consumables WHERE item_name = @itemName', {
                    ['@itemName'] = itemName
                }, function(durability)
                    if durability <= 0 then
                        xPlayer.removeInventoryItem(itemName, 1)
                    end
                end)
            end
        end)
    end
end)

RegisterServerEvent('ConsumableSystem:placeItem')
AddEventHandler('ConsumableSystem:placeItem', function(itemName, surface)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(itemName)

    if item.count > 0 then
        xPlayer.removeInventoryItem(itemName, 1)
        TriggerClientEvent('ConsumableSystem:placeItem', source, itemName, surface)
    end
end)