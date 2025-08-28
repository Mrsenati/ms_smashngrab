
-- CreateThread(function()
--     while true do
--         local coords = GetEntityCoords(cache.ped)
--         local veh = lib.getClosestVehicle(coords, 5, false)
--         -- print(GetVehicleClass(veh)) -- Debug: Uncomment for development
--         if not IsEntityAMissionEntity(veh) and NetworkGetEntityIsNetworked(veh) then
--             local netVehId = VehToNet(veh)
--             local class = GetVehicleClass(veh)
--             SetEntityAsMissionEntity(veh, true, true)
--             TriggerServerEvent('var_smashngrab:registerVehicle', netVehId, class)
--         end
--         Wait(5000)
--     end
-- end)

local function objinteraction(netObjId, spotIndex, spot)
      interact.addEntity(netObjId, {
        label = "Take Item",
        name = NetId,
        distance = 5,
        canInteract = function(entity, distance, coords, name)
            if not spot.window and not spot.door then
                return true
            end

            local vehicle = lib.getClosestVehicle(coords)
            if vehicle == 0 then
                return false
            end

            if spot.window ~= nil and not IsVehicleWindowIntact(vehicle, 1) then
                return true
            end

            if spot.door ~= nil and GetVehicleDoorAngleRatio(vehicle, spot.door) >= 0.1 then
                return true
            end

            if spot.trunk ~= nil and GetVehicleDoorAngleRatio(vehicle, spot.door) >= 0.1 then
                return true
            end

            return false
        end,
        onSelect = function(data) 
            local netObjId = NetworkGetNetworkIdFromEntity(data.entity)
            local vehicle = lib.getClosestVehicle(data.coords)
            local netVehId = VehToNet(vehicle)
            TriggerServerEvent('var_smashngrab:takeLoot', netVehId, netObjId, spotIndex)
        end
    })
end


RegisterNetEvent('var_smashngrab:spawnLootObject', function(netVehId, spotIndex, chosenLoot, spot)
    local veh = NetToVeh(netVehId)
    if not DoesEntityExist(veh) then return end
    lib.requestModel(chosenLoot.model)
    local obj = CreateObject(chosenLoot.model, 0,0,0, true, true, false)
    SetModelAsNoLongerNeeded(model)
    NetworkRegisterEntityAsNetworked(obj)
    local netObjId = NetworkGetNetworkIdFromEntity(obj)
    SetNetworkIdCanMigrate(netObjId, true)
    SetNetworkIdExistsOnAllMachines(netObjId, true)
    
    objinteraction(netObjId, spotIndex, spot)
    local bone = GetEntityBoneIndexByName(veh, spot.bone)
    AttachEntityToEntity(obj, veh, bone,
        chosenLoot.offset.x, chosenLoot.offset.y, chosenLoot.offset.z,
        chosenLoot.rotation.x, chosenLoot.rotation.y, chosenLoot.rotation.z,
        true, true, false, true, 1, true
    )
    TriggerServerEvent('var_smashngrab:registerObject', netVehId, spotIndex, netObjId)
end)


RegisterNetEvent('var_smashngrab:removeLootObject', function(netVehId, netObjId)
    local obj = NetToObj(netObjId)
    NetworkRequestControlOfEntity(obj)
    DeleteEntity(obj)
    local veh = NetToVeh(netVehId)
    -- Wait(15000)
    -- DeleteVehicle(veh)
end)

lib.callback.register('var_smashngrab:getvehclass', function(netVehId)
    local veh = NetToVeh(netVehId)
    local isveh = IsEntityAVehicle(veh)
    local class = GetVehicleClass(veh)
    print(class)
    return class
end)