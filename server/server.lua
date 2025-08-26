local VehicleLoot = {}
local config = require '/config/server'

RegisterNetEvent('ms_smashngrab:registerVehicle', function(netVehId, class)
    if VehicleLoot[netVehId] then return end
    VehicleLoot[netVehId] = {}

    for i = 1, #config.VehicleLootSpots do
        local spot = config.VehicleLootSpots[i]

        if spot.class == class then
            local chosenLoot = nil  -- reset per spot
            local chance = math.random(100)

            for j = 1, #spot.lootTable do
                local loot = spot.lootTable[j]

                if chance <= loot.chance then
                    chosenLoot = {
                        model = loot.model,
                        offset = loot.offset,
                        rotation = loot.rotation,
                        item = loot.item,
                        amount = loot.amount or {1,1},
                        taken = false
                    }
                    break -- stop bij de eerste match, voorkomt meerdere items per spot
                end
            end

            if chosenLoot then
                VehicleLoot[netVehId][i] = chosenLoot
                TriggerClientEvent('ms_smashngrab:spawnLootObject', -1, netVehId, i, chosenLoot, spot)
                print(("✅ Loot spawned for Veh %s | Spot %s | Model %s"):format(netVehId, i, chosenLoot.model))
            end
        end
    end
end)

RegisterNetEvent('ms_smashngrab:registerObject', function(netVehId, spotIndex, netObjId)
    VehicleLoot[netVehId][spotIndex].netObjId = netObjId
end)


RegisterNetEvent('ms_smashngrab:takeLoot', function(netVehId, netObjId, spotIndex)
    local src = source
    local data = VehicleLoot[netVehId] and VehicleLoot[netVehId][spotIndex]
    if data and not data.taken then
        local amount = math.random(data.amount[1], data.amount[2])
        exports.ox_inventory:AddItem(src, data.item, amount)
        data.taken = true 
        TriggerClientEvent('ms_smashngrab:removeLootObject', -1, netVehId, netObjId)
    end
end)
