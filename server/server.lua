local config = require '/config/server'

-- Helper function to generate loot for a vehicle
local function generateVehicleLoot(class)
    local loot = {}
    for i = 1, #config.VehicleLootSpots do
        local spot = config.VehicleLootSpots[i]
        if spot.class == class then
            local chance = math.random(100)
            for j = 1, #spot.lootTable do
                local lootItem = spot.lootTable[j]
                if chance <= lootItem.chance then
                    loot[i] = {
                        model = lootItem.model,
                        offset = lootItem.offset,
                        rotation = lootItem.rotation,
                        item = lootItem.item,
                        amount = lootItem.amount or {1,1},
                        taken = false
                    }
                    break
                end
            end
        end
    end
    return loot
end

AddEventHandler("entityCreated", function(entity)
    if entity and DoesEntityExist(entity) and GetEntityType(entity) == 2 then
        local netId = NetworkGetNetworkIdFromEntity(entity)
        local owner = NetworkGetEntityOwner(entity)
        local class = lib.callback.await('var_smashngrab:getvehclass', owner, netId)
        if owner and owner > 0 then
            print(class)
        end
    end
end)

RegisterNetEvent('var_smashngrab:registerVehicle', function(netVehId, class)
    local entity = NetworkGetEntityFromNetworkId(netVehId)
    if not entity then return end
    
    -- Check if loot is already generated
    local stateBag = Entity(entity).state
    if stateBag.loot then return end

    -- Generate and set loot in statebag
    local loot = generateVehicleLoot(class)
    stateBag.loot = loot

    -- Spawn loot objects for all clients
    for spotIndex, lootData in pairs(loot) do
        TriggerClientEvent('var_smashngrab:spawnLootObject', -1, netVehId, spotIndex, lootData, config.VehicleLootSpots[spotIndex])
        print(("✅ Loot spawned for Veh %s | Spot %s | Model %s"):format(netVehId, spotIndex, lootData.model))
    end
end)

RegisterNetEvent('var_smashngrab:takeLoot', function(netVehId, spotIndex)
    local src = source
    local entity = NetworkGetEntityFromNetworkId(netVehId)
    if not entity then return end

    local stateBag = Entity(entity).state
    local loot = stateBag.loot
    
    if loot and loot[spotIndex] and not loot[spotIndex].taken then
        local data = loot[spotIndex]
        local amount = math.random(data.amount[1], data.amount[2])
        exports.ox_inventory:AddItem(src, data.item, amount)
        
        -- Update the statebag
        loot[spotIndex].taken = true
        stateBag.loot = loot
        
        TriggerClientEvent('var_smashngrab:removeLootObject', -1, netVehId, spotIndex)
    end
end)
