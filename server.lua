ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterCommand('testing', 'user', function(xPlayer)

    xPlayer.triggerEvent("daily_lockpick:startPicking")

end, false, {help = "Testing LockPick"})

ESX.RegisterServerCallback('daily_lockpick:getItems', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local bobbypins = xPlayer.getInventoryItem('bobbypin')
    local screwdriver = xPlayer.getInventoryItem('screwdriver')

    if bobbypins ~= nil and screwdriver ~= nil then
        cb(bobbypins.count, screwdriver.count)
    else
        cb(0, 0)
    end
end)

RegisterServerEvent('daily_lockpick:removeItem')
AddEventHandler('daily_lockpick:removeItem', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('bobbypin', 1)
end)
