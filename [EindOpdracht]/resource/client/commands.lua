RegisterCommand('startmission', function()
    if InsideMissionZone then
        StartMission()
    end
end, true)

-- spawns car to make travelling while testing easier
RegisterCommand('getcar', function()
    SpawnTempesta(GetEntityCoords(PlayerPedId()))
end, false)

RegisterCommand('takeweed', function()
    if InsideWeedZone and WeedPickupActive then
        QBCore.Functions.TriggerCallback('resource:server:giveweed', function() end)
        WeedPickupActive = false
        SetDropoffObjective()
        ShowDropoffDirections()
        ShowDropoffMarker()
    end
end, true)

RegisterCommand('dropoffweed', function()
    if InsideDropoffZone then
        QBCore.Functions.TriggerCallback('resource:server:dropoffweed', function(result)
            if result then
                TriggerEvent('QBCore:Notify', "Dropped off weed", "success")
                ShowGarageDirections("Return your car to the ~g~Garage~s~.")
                if DropoffBlip ~= nil then RemoveBlip(DropoffBlip) end
                ShowGarageBlip()
                ShowMechanicReturnText3D()
                ShowNotification(
                    "Just got word that everything went according to plan. My guy is gonna want that ride back tho.",
                    "Unknown",
                    '',
                    'CHAR_BLANK_ENTRY',
                    2,
                    false,
                    130
                )
                DropoffActive = false
            else
                TriggerEvent('QBCore:Notify', "Something went wrong", "error")
            end
        end)
    end
end, true)

RegisterCommand('returntempesta', function()
    if InsideGarageZone and MissionActive and not CarRentable then
        local veh = GetVehiclePedIsIn(PlayerPedId(), true)
        QBCore.Functions.TriggerCallback('resource:server:returndeposit', function(result)
            if result then
                DeleteVehicle(veh)
                ShowSubtitles('-', 1)
                ShowNotification(
                    "My guy is all good now. Here's some cash for doing my dirty work for me.",
                    "Unknown",
                    '',
                    'CHAR_BLANK_ENTRY',
                    2,
                    false,
                    130
                )
                QBCore.Functions.TriggerCallback('resource:server:payout')
                if GarageBlip ~= nil then RemoveBlip(GarageBlip) end
                MissionActive = false
            end
        end)
    end
end, true)
