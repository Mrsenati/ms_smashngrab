local VehicleLoot = {}
local config = require '/config/server'

RegisterNetEvent('ms_smashngrab:registerVehicle', function(netVehId, class)
    if VehicleLoot[netVehId] then return end
    VehicleLoot[netVehId] = {}
    print('class', class)
    local validSpots = {}
    for i, spot in ipairs(config.VehicleLootSpots) do
        if not spot.class or spot.class == class then
            table.insert(validSpots, {index = i, data = spot})
        end
    end


    local chosen = validSpots[math.random(1, #validSpots)]
    local spotIndex = chosen.index
    local spot = chosen.data

    local chosenLoot = nil
    print(json.encode(chosen))
    for _, loot in ipairs(spot.lootTable) do
        -- print(class, json.encode(spot.carclass))
        if not class == spot.carclass then return end
        if math.random(100) <= loot.chance then
            chosenLoot = {
                model = loot.model,
                offset = loot.offset,
                rotation = loot.rotation,
                item = loot.item,
                amount = loot.amount or {1, 1},
                taken = false
            }
            break
        end
    end

    if chosenLoot then
        VehicleLoot[netVehId][spotIndex] = chosenLoot
        TriggerClientEvent('ms_smashngrab:spawnLootObject', -1, netVehId, spotIndex, chosenLoot, spot)
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
