AddRelationshipGroup("JUNKIE")                                              --creates a new relationship group for junkie
SetRelationshipBetweenGroups(5, GetHashKey("JUNKIE"), GetHashKey("PLAYER")) --sets junkie to hate player peds
SetRelationshipBetweenGroups(0, GetHashKey("JUNKIE"), GetHashKey("JUNKIE")) --sets submarine crew to be companions with each other


function SpawnMechanicNPC()
    exports['qb-target']:SpawnPed({
        model = 's_m_m_lathandy_01',                    -- Dit is het ped-model dat zal verschijnen op de opgegeven positie
        coords = vector4(53.56, 6470.12, 31.43, 228.2), -- Dit is de positie waarop de ped zal verschijnen, het moet altijd een vector4 zijn en de waarde w is de richting
        minusOne = true,                                -- Zet dit op true als je ped boven de grond zweeft maar je hem op de grond wilt hebben (optioneel)
        spawnNow = true,                                -- Zet dit op true als je wilt dat de ped onmiddellijk verschijnt (optioneel)
        freeze = true,                                  -- Zet dit op true als je wilt dat de ped bevroren blijft op de opgegeven positie (optioneel)
        invincible = true,                              -- Zet dit op true als je wilt dat de ped geen schade oploopt van welke bron dan ook (optioneel)
        blockevents = true,                             -- Zet dit op true als je wilt dat de ped niet reageert op de omgeving (optioneel)
        scenario = 'WORLD_HUMAN_CLIPBOARD',             -- Dit is het scenario dat zal worden afgespeeld zolang de ped verschijnt, dit kan niet gecombineerd worden met anim en animDict (optioneel)
    })
end

function SpawnDropoffNPC()
    exports['qb-target']:SpawnPed({
        model = 'g_m_y_mexgoon_01',                     -- Dit is het ped-model dat zal verschijnen op de opgegeven positie
        coords = vector4(751.1, 6457.75, 31.58, 59.95), -- Dit is de positie waarop de ped zal verschijnen, het moet altijd een vector4 zijn en de waarde w is de richting
        minusOne = true,                                -- Zet dit op true als je ped boven de grond zweeft maar je hem op de grond wilt hebben (optioneel)
        spawnNow = true,                                -- Zet dit op true als je wilt dat de ped onmiddellijk verschijnt (optioneel)
        freeze = true,                                  -- Zet dit op true als je wilt dat de ped bevroren blijft op de opgegeven positie (optioneel)
        invincible = true,                              -- Zet dit op true als je wilt dat de ped geen schade oploopt van welke bron dan ook (optioneel)
        blockevents = true,                             -- Zet dit op true als je wilt dat de ped niet reageert op de omgeving (optioneel)
    })
end

--- Spawn een NPC
-- @param model integer of string (hash - https://docs.fivem.net/docs/game-references/ped-models/)
-- @param position vector3
-- @param weapon integer (hash - https://wiki.rage.mp/index.php?title=Weapons)
-- @param acc_min integer
-- @param acc_max integer
-- @return ped handle of nil
---
function SpawnHostileNPC(model, position, weapon, acc_min, acc_max)
    --- Controleer of het model een string of integer is en zet het om naar een integer (hash)
    local model = type(model) == "number" and model or GetHashKey(model)

    --- Load het model
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(20)
    end

    --- Spawn de ped
    local npc = CreatePed(4, model, position.x, position.y, position.z, position.w, true, false)

    --- Geef de client een aantal milliseconden om de ped te spawnen
    local timeOut = 100
    while npc == 0 and timeOut > 0 do
        timeOut = timeOut - 1
        Wait(1)
    end

    --- Als de ped niet is gespawned, return nil
    if timeOut > 0 and npc ~= 0 and npc ~= nil then
        --- Zet de ped op de grond
        PlaceObjectOnGroundProperly(npc)

        --- Set de ped eigenschappen

        -- Set de ped als een junkie, deze ped valt de speler alleen aan als de speler de ped aanvalt
        SetPedRelationshipGroupHash(npc, GetHashKey("JUNKIE"))

        --- Laat de ped rondlopen
        TaskWanderInArea(npc, position.x, position.y, position.z, 10.0, 10.0, 10.0)
        SetPedKeepTask(npc, true)

        --- Geef de ped een wapen
        GiveWeaponToPed(npc, weapon, 10, false, true)
        SetPedCanSwitchWeapon(npc, true)

        --- Zet de accuracy van de ped
        SetPedAccuracy(npc, math.random(acc_min, acc_max))

        --- Zet de ped als een netwerk ped
        SetNetworkIdCanMigrate(PedToNet(npc), true)

        --- Zet dat de ped damage kan krijgen
        SetEntityInvincible(npc, false)

        --- Zet de health van de ped
        SetEntityMaxHealth(npc, 200)
        SetEntityHealth(npc, 200)

        --- Zet headshot damage uit
        SetPedSuffersCriticalHits(npc, false)

        --- Zet de ped als een combat ped
        SetPedCombatAbility(npc, 1)

        --- Zet de combat attributes van de ped
        SetPedCombatAttributes(npc, 0, true) --[[ BF_CanUseCover ]]
        SetPedCombatAttributes(npc, 1, true) --[[ BF_CanUseVehicles ]]
        SetPedCombatAttributes(npc, 2, true) --[[ BF_CanDoDrivebys ]]
        SetPedCombatAttributes(npc, 3, true) --[[ BF_CanLeaveVehicle ]]
        SetPedCombatAttributes(npc, 5, true) --[[ BF_CanFightArmedPedsWhenNotArmed ]]
        SetPedCombatAttributes(npc, 20, true) --[[ BF_CanTauntInVehicle ]]
        SetPedCombatAttributes(npc, 46, true) --[[ BF_AlwaysFight ]]

        --- Zorg er voor dat de ped niet wegrent
        SetPedFleeAttributes(npc, 0, false)

        --- Als de ped dood gaat, laat de ped zijn wapen niet vallen
        SetPedDropsWeaponsWhenDead(npc, false)

        --- Zorg dat de ped zichtbaar is op de minimap, zoals in normaal GTA
        SetPedHasAiBlip(npc, true)
        SetPedAiBlipForcedOn(npc, true)

        TaskCombatPed(npc, PlayerPedId(), 0, 16)
        SetPedSeeingRange(npc, 100.0)
        SetPedHearingRange(npc, 100.0)

        return npc
    end

    return nil
end
