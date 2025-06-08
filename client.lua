ESX = exports['es_extended']:getSharedObject()

local uiOpen = false
local currentItems = {}

function DrawText3D(coords, text)
    local x, y, z = table.unpack(coords + vector3(0.0, 0.0, 1.0))
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local sleep = 1500
        local found = false

        for propName, data in pairs(Config.VendingProps) do
            local obj = GetClosestObjectOfType(coords, 2.0, GetHashKey(propName), false, false, false)
            if obj ~= 0 then
                local propCoords = GetEntityCoords(obj)
                DrawText3D(propCoords, "[E] Automat öffnen")
                found = true
                sleep = 0
                if IsControlJustReleased(0, Config.InteractKey) and not uiOpen then
                    currentItems = data.items
                    SetNuiFocus(true, true)
                    SendNUIMessage({action = "open", items = currentItems})
                    uiOpen = true
                end
            end
        end

        if not found then
            sleep = 1000
        end

        Wait(sleep)
    end
end)

RegisterNUICallback("buy", function(data)
    TriggerServerEvent("vending:buyItem", data)
end)

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
    SendNUIMessage({action = "close"})
    uiOpen = false
end)