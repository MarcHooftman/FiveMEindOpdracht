local garage = BoxZone:Create(vector3(55.64, 6472.28, 31.43), 18, 18, {
    name = "garage",
    heading = 315,
})

local missionstart = CircleZone:Create(vector3(-25.06, 6459.22, 31.45), 2.0, {
    name = "missionstart",
    useZ = false,
    debugPoly = true
})

local weed = PolyZone:Create({
    vector2(-452.740234375, 6262.228515625),
    vector2(-454.95956420898, 6262.9165039062),
    vector2(-454.09780883789, 6265.2241210938),
    vector2(-452.11614990234, 6264.4819335938)
}, {
    name = "weed",
    minZ = 32.330070495605,
    maxZ = 35.330070495605,
})

local dropoff = BoxZone:Create(vector3(749.68, 6458.43, 31.46), 8, 8, {
    name = "dropoff",
    heading = 328,
})

---@param isPointInside boolean
---@param point vector3
missionstart:onPlayerInOut(function(isPointInside, point)
    InsideMissionZone = isPointInside
end)

---@param isPointInside boolean
---@param point vector3
garage:onPlayerInOut(function(isPointInside, point)
    InsideGarageZone = isPointInside
end)

---@param isPointInside boolean
---@param point vector3
weed:onPlayerInOut(function(isPointInside, point)
    InsideWeedZone = isPointInside
end)

---@param isPointInside boolean
---@param point vector3
dropoff:onPlayerInOut(function(isPointInside, point)
    InsideDropoffZone = isPointInside
end)
