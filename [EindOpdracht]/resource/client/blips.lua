function ShowGarageBlip()
    GarageBlip = AddBlipForCoord(TempestaPos.x, TempestaPos.y, TempestaPos.z)
    SetBlipRoute(GarageBlip, true)
    SetBlipRouteColour(GarageBlip, 69)
    SetBlipSprite(GarageBlip, 810)
    SetBlipColour(GarageBlip, 69)
    SetBlipFlashes(GarageBlip, true)
end

function ShowWeedBlip()
    WeedBlip = AddBlipForCoord(WeedCoords.x, WeedCoords.y, WeedCoords.z)
    SetBlipRoute(WeedBlip, true)
    SetBlipRouteColour(WeedBlip, 69)
    SetBlipSprite(WeedBlip, 496)
    SetBlipColour(WeedBlip, 69)
    SetBlipFlashes(WeedBlip, true)
end

function ShowDropoffBlip()
    DropoffBlip = AddBlipForCoord(DropoffCoords.x, DropoffCoords.y, DropoffCoords.z)
    SetBlipRoute(DropoffBlip, true)
    SetBlipRouteColour(DropoffBlip, 69)
    SetBlipSprite(DropoffBlip, 496)
    SetBlipColour(DropoffBlip, 69)
    SetBlipFlashes(DropoffBlip, true)
end

function ShowMissionBlip()
    local missionBlip = AddBlipForCoord(MissionCirclePos.x, MissionCirclePos.y, MissionCirclePos.z)
    SetBlipSprite(missionBlip, 496)
    SetBlipColour(missionBlip, 69)
end
