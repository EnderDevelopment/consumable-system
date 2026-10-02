local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local function playEmote(emote)
    RequestAnimDict('amb@world_human_drinking@beer@male@idle_a')
    while not HasAnimDictLoaded('amb@world_human_drinking@beer@male@idle_a') do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), 'amb@world_human_drinking@beer@male@idle_a', emote, 8.0, -8.0, -1, 49, 0, false, false, false)
end

RegisterNetEvent('ConsumableSystem:useItem')
AddEventHandler('ConsumableSystem:useItem', function(itemName)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local closestSurface = nil
    local closestDistance = 1000

    for _, surface in ipairs(Config.Surfaces) do
        local surfaceHash = GetHashKey(surface)
        local surfaceCoords = GetClosestObjectOfType(coords.x, coords.y, coords.z, 1.0, surfaceHash, false, false, false)
        if surfaceCoords ~= 0 then
            local distance = #(coords - surfaceCoords)
            if distance < closestDistance then
                closestDistance = distance
                closestSurface = surfaceCoords
            end
        end
    end

    if closestSurface then
        TriggerServerEvent('ConsumableSystem:placeItem', itemName, closestSurface)
    else
        playEmote('idle_a')
        Citizen.Wait(Config.Consumables[itemName].duration)
        ClearPedTasks(playerPed)
        TriggerServerEvent('ConsumableSystem:consumeItem', itemName)
    end
end)

RegisterNetEvent('ConsumableSystem:placeItem')
AddEventHandler('ConsumableSystem:placeItem', function(itemName, surface)
    local playerPed = PlayerPedId()
    local itemModel = Config.Consumables[itemName].model
    local itemHash = GetHashKey(itemModel)

    RequestModel(itemHash)
    while not HasModelLoaded(itemHash) do
        Citizen.Wait(0)
    end

    local item = CreateObject(itemHash, GetEntityCoords(playerPed), true, false, false)
    AttachEntityToEntity(item, surface, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)

    Citizen.Wait(Config.Consumables[itemName].duration)
    DeleteObject(item)
    TriggerServerEvent('ConsumableSystem:consumeItem', itemName)
end)