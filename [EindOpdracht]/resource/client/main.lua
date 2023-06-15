--
-- GLOBALS
--

QBCore = exports['qb-core']:GetCoreObject()

MissionCirclePos = vector3(-25.06, 6459.22, 31.45)
TempestaPos = vector4(61.79, 6466.19, 30.7, 227.9)
WeedCoords = vector4(-454.25, 6263.38, 33.33, 107.68)
DropoffCoords = vector4(751.1, 6457.75, 31.58, 59.95)

CarRentable = false
MissionActive = false
WeedPickupActive = false
DropoffActive = false

InsideGarageZone = false
InsideMissionZone = false
InsideWeedZone = false
InsideDropoffZone = false

GarageBlip = nil
WeedBlip = nil
DropoffBlip = nil

--
-- NPCS
--

CreateThread(function()
    SpawnMechanicNPC()
    SpawnDropoffNPC()
end)

--
-- MINIMAP
--

-- Always show minimap
CreateThread(
    function()
        while true do
            DisplayRadar(true)
            Wait(0)
        end
    end
)

--
-- MISSION
--
CreateThread(
    function()
        ShowMissionMarker()
        ShowMissionText3D()
        ShowMissionBlip()
    end
)
