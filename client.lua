ESX = nil

local display = false
local action, pinHp, pinDmg, maxDist, solvePadd = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(50)
    end
end)

function DebugPrint(str)
    if Config.DebugMode then print("daily_lockpick: " .. str) end
end

RegisterNetEvent("daily_lockpick:startPicking")
AddEventHandler("daily_lockpick:startPicking",
                function(cb, pinHp, pinDmg, maxDist, solvePadd)

    if pinHp == nil then
        pinHp = Config.DefaultPinHealth
        DebugPrint("Pin Health => " .. pinHp)
    end

    if pinDmg == nil then
        pinDmg = Config.DefaultPinDamage
        DebugPrint("Pin Damage => " .. pinDmg)
    end

    if maxDist == nil then
        maxDist = Config.DefaultMaxDistance
        DebugPrint("Max Distance => " .. maxDist)
    end

    if solvePadd == nil then
        solvePadd = Config.DefaultSolvePadding
        DebugPrint("Solve Padding => " .. solvePadd)
    end

    ESX.TriggerServerCallback('daily_lockpick:getItems',
                              function(bobbypin, screwdriver)

        if bobbypin > 0 and screwdriver > 0 then
            DebugPrint("Can pick, has " .. bobbypin .. " pins and " ..
                           screwdriver .. " screwdrivers")
            SetDisplay(not display, bobbypin, pinHp, pinDmg, maxDist, solvePadd)

            Citizen.CreateThread(function()
                while true do
                    Citizen.Wait(0)
                    if action == "unlocked" then
                        action = nil

                        -- TAKE THIS LINE OUT IF YOU ADDING THIS SCRIPT TO YOUR OWN SCRIPTS --
                        if Config.DebugMode ~= true then
                            cb(true) -- ONLY LEAVE THIS
                        end
                        ---------------------------------------------------------------------

                        break
                    elseif action == "failed" then
                        action = nil

                        -- TAKE THIS LINE OUT IF YOU ADDING THIS SCRIPT TO YOUR OWN SCRIPTS --
                        if Config.DebugMode ~= true then
                            cb(false) -- ONLY LEAVE THIS
                        end
                        ---------------------------------------------------------------------

                        break
                    end
                end
            end)
        else
            DebugPrint("Cannot pick, doesnt have required items")
            ESX.ShowNotification("You dont have the required items", "", 10000)

        end
    end)
end)

function SetDisplay(trigger, amount, health, damage, distance, padding)
    display = trigger
    SetNuiFocus(trigger, trigger)
    SendNUIMessage({
        type = "lockpick",
        enable = trigger,
        pins = amount,
        pinhp = health,
        pindmg = damage,
        maxdist = distance,
        solvepadd = padding
    })
end

RegisterNUICallback('exit', function() SetDisplay(false) end)

RegisterNUICallback('action', function(data, cb)

    if data.action == "break" then
        TriggerServerEvent("daily_lockpick:removeItem")
    elseif data.action == "failed" then
        DebugPrint("You're out of pins!")
        ESX.ShowNotification("You have run out of pins!", "", 10000)

        SetDisplay(false)
        action = data.action
    elseif data.action == "unlocked" then
        DebugPrint("You've unlocked a thing!")
        ESX.ShowNotification("SUCCESS!", "", 10000)

        SetDisplay(false)
        action = data.action
    end

    cb('ok')
end)

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)

        DisableControlAction(0, 1, display)
        DisableControlAction(0, 2, display)
        DisableControlAction(0, 142, display)
        DisableControlAction(0, 18, display)
        DisableControlAction(0, 322, display)
        DisableControlAction(0, 106, display)

    end
end)
