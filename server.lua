ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent("vending:buyItem")
AddEventHandler("vending:buyItem", function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = data.price

    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        if data.weapon then
            xPlayer.addWeapon(data.name, 42)
        else
            xPlayer.addInventoryItem(data.name, 1)
        end
        TriggerClientEvent('esx:showNotification', source, "Gekauft: " .. data.label)
    else
        TriggerClientEvent('esx:showNotification', source, "Nicht genug Geld!")
    end
end)