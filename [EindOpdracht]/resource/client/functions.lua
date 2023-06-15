--
-- ON-SCREEN TEXT
--

function DrawText3D(x, y, z, text, scale) -- Draw text in 3D space
    local onScreen, worldX, worldY = GetScreenCoordFromWorldCoord(x, y, z)
    local camCoords = GetFinalRenderedCamCoord()
    local _scale = scale * 200 / (GetGameplayCamFov() * #(camCoords - vector3(x, y, z)))
    if onScreen then
        SetTextScale(1.0, 0.5 * _scale)
        SetTextFont(4)
        SetTextColour(255, 255, 255, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextProportional(true)
        SetTextOutline()
        SetTextCentre(true)
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(worldX, worldY)
    end
end

function ShowText3DAtCoords(coords, text, scale, conditionfunc)
    CreateThread(function()
        while true do
            Wait(0)
            if (conditionfunc)() then
                DrawText3D(coords.x, coords.y, coords.z, text, scale)
            end
        end
    end)
end

function ShowSubtitles(message, duration)
    BeginTextCommandPrint('STRING')
    AddTextComponentString(message)
    EndTextCommandPrint(duration, true)
end

function ShowNotification(message, sender, subject, textureDict, iconType, saveToBrief, color)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(message)
    ThefeedNextPostBackgroundColor(color)
    EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
    EndTextCommandThefeedPostTicker(false, saveToBrief)
end

function ShowMissionText3D()
    local coords = vector3(MissionCirclePos.x, MissionCirclePos.y, MissionCirclePos.z + 0.4)
    ShowText3DAtCoords(coords, "~b~Start Challenge~s~ [E]", 2,
        function()
            return not MissionActive and #(GetEntityCoords(PlayerPedId()) - MissionCirclePos) < 5.0
        end
    )
end

function ShowMechanicRentText3D()
    local mechanicPos = vector4(53.56, 6470.12, 33, 228.2)
    ShowText3DAtCoords(mechanicPos, "~g~Rent a car~s~ [E]", 2,
        function() return InsideGarageZone and MissionActive and CarRentable end)
end

function ShowMechanicReturnText3D()
    local mechanicPos = vector4(53.56, 6470.12, 33, 228.2)
    ShowText3DAtCoords(mechanicPos, "~g~Return car~s~ [E]", 2,
        function() return InsideGarageZone and MissionActive and not CarRentable end)
end

function ShowPickUpText3D()
    ShowText3DAtCoords(WeedCoords, "~g~Pick up weed~s~ [E]", 2,
        function() return MissionActive and InsideWeedZone and WeedPickupActive end)
end

function ShowDropoffText3D()
    local dropoffCoords = vector3(DropoffCoords.x, DropoffCoords.y, DropoffCoords.z + 1)
    ShowText3DAtCoords(dropoffCoords, "~g~Drop off weed~s~ [E]", 2,
        function() return InsideDropoffZone and DropoffActive end)
end

--
-- CAR
--

function SpawnTempesta(spawnPoint)
    QBCore.Functions.TriggerCallback("resource:server:paydeposit", function(returnValue)
        if returnValue then
            QBCore.Functions.SpawnVehicle('tempesta', function(veh)                         -- Spawn vehicle
                exports['LegacyFuel']:SetFuel(veh, 100.0)                                   -- Set fuel to 100%
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh)) -- Set vehicle owner
                SetVehicleEngineOn(veh, true, true, false)                                  -- Turn engine on

                SetVehicleModKit(veh, 0)                                                    -- enable SetVehicleMod
                SetVehicleCustomPrimaryColour(veh, 25, 25, 200)                             -- Set color to blue
                SetVehicleCustomSecondaryColour(veh, 0, 0, 30)                              -- Set secondary color to dark blue
                SetVehicleMod(veh, 0, 2, false)                                             -- Adding a spoiler
                SetVehicleMod(veh, 1, 1, false)                                             -- Adding a Front Bumper
            end, spawnPoint, true, false)
        end
    end)
    Wait(1000)
end

--
-- MISSION
--

function StartMission()
    ShowGarageBlip()
    MissionActive = true
    CarRentable = true
    ShowGarageDirections('Go to the ~g~Garage~s~ and rent a car.')
    ShowNotification(
        "Get a car from my guy around the corner. I'll get back to you after.",
        "Unknown",
        '',
        'CHAR_BLANK_ENTRY',
        2,
        false,
        130
    )
    ShowMechanicMarker()
    ShowMechanicRentText3D()
end

function ShowGarageDirections(message)
    CreateThread(
        function()
            while true do
                if MissionActive then
                    DisplayRadar(true)
                    ShowSubtitles(message, 1)
                end
                Wait(0)
            end
        end
    )
end

function SpawnMissionTempesta()
    SpawnTempesta(TempestaPos)
    SetBalconyObjective()
    CarRentable = false
end

function SetBalconyObjective()
    WeedPickupActive = true
    if GarageBlip ~= nil then RemoveBlip(GarageBlip) end
    ShowWeedBlip()
    ShowWeedMarker()
    ShowPickUpText3D()
    ShowBalconyDirections()
    CreateEnemies()
    GiveWeaponToPed(PlayerPedId(), GetHashKey('weapon_specialcarbine'), 100, false, true)
    ShowNotification(
        "My guy had some gat for you to take kush from some junkies. Get there stat.",
        "Unknown",
        '',
        'CHAR_BLANK_ENTRY',
        2,
        false,
        130
    )
end

function CreateEnemies()
    for i = 1, math.random(3, 6) do
        local npc = SpawnHostileNPC('a_m_m_hillbilly_02',
            vector4(-451.38 + math.random(), 6262.49 + math.random(), 33.33, 356.9),
            'weapon_ceramicpistol', 10, 50)
    end
end

function ShowBalconyDirections()
    CreateThread(
        function()
            while true do
                if MissionActive then
                    ShowSubtitles('Go up to the ~g~Balcony~s~ and take the weed.', 1)
                end
                Wait(0)
            end
        end
    )
end

function ShowDropoffDirections()
    CreateThread(
        function()
            while true do
                Wait(0)
                if MissionActive then
                    ShowSubtitles('Go to the ~g~Drop Off~s~.', 1)
                end
            end
        end
    )
end

function SetDropoffObjective()
    if WeedBlip ~= nil then RemoveBlip(WeedBlip) end
    DropoffActive = true
    ShowDropoffBlip()
    ShowDropoffText3D()
    ShowDropoffMarker()
    ShowDropoffDirections()
    ShowNotification(
        "Took care if those junkies? Great, now get the stuff to my buyer.",
        "Unknown",
        '',
        'CHAR_BLANK_ENTRY',
        2,
        false,
        130
    )
end
