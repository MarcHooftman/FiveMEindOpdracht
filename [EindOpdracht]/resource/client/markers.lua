function ShowMarkerAtCoords(coords, conditionfunc)
    -- this needs to be a lambda or func so it can be re-evaluated every loop iteration
    local conditionfunc = conditionfunc or (function() return true end)

    CreateThread(function()
        while true do
            if (conditionfunc)() then
                DrawMarker(2, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0,
                    0.0, 0.0, 0.5, 0.3, 0.25, 255, 255, 255, 255, false, false, false, true, false, false, false)
            end
            Wait(0)
        end
    end)
end

function ShowMechanicMarker()
    local mechanicPos = vector4(53.56, 6470.12, 32.43, 228.2)
    ShowMarkerAtCoords(mechanicPos, function() return MissionActive and InsideGarageZone end)
end

function ShowWeedMarker()
    ShowMarkerAtCoords(WeedCoords,
        function() return #(GetEntityCoords(PlayerPedId()) - WeedCoords) < 5.0 and WeedPickupActive end)
end

function ShowDropoffMarker()
    local dropoffCoords = vector3(DropoffCoords.x, DropoffCoords.y, DropoffCoords.z + 1)
    ShowMarkerAtCoords(dropoffCoords, function() return InsideDropoffZone and DropoffActive end)
end

function ShowMissionMarker()
    local condition = function() return not MissionActive and #(GetEntityCoords(PlayerPedId()) - MissionCirclePos) < 5.0 end
    ShowMarkerAtCoords(MissionCirclePos, condition)
end
