local display = false

RegisterCommand("nui", function(source, args)
    if InsideGarageZone and CarRentable then
        SetDisplay(not display)
    end
end, true)

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("complete", function(data)
    SetDisplay(false)
    SpawnMissionTempesta()
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

CreateThread(function()
    while display do
        Wait(0)
        DisableControlAction(0, 1, display)   -- LookLeftRight
        DisableControlAction(0, 2, display)   -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display)  -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)
