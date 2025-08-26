return {
        Deleteobject = true, -- Delete Object if not taken by player
        Objecttime = 1000000, -- Timer To delete item if not taken by player
        DeleteVeh = true, -- Delete the vehicle if Object is spawned and taken
        Vehicletime = 1000000, -- Timer to delete vehicle
        VehicleLootSpots = {
        {
            class = 1,
            bone = "seat_pside_f",
            window = nil, -- set nil if no broken window
            door = 1, -- set nil if no need be closed
            trunk = nil, -- set nil if object is not spawned in trunk
            lootTable = {
                { model = "prop_ld_handbag", offset = vector3(0.0, 0.15, 0.35), rotation = vector3(0.0, 0.0, 90.0), item = "cash", chance = 90, amount = {100, 500} },
                { model = "prop_laptop_01a", offset = vector3(0.0, 0.15, 0.35), rotation = vector3(0.0, 0.0, 90.0), item = "cash", chance = 100, amount = {100, 500} },
            }
        },
        {
            class = 2,
            bone = "seat_pside_f",
            window = nil,            
            lootTable = {
                { model = "prop_laptop_01a", offset = vector3(0.0, 0.15, 0.35), rotation = vector3(0.0, 0.0, 90.0), item = "cash", chance = 50, amount = {100, 500} },
            }
        },
        -- {
        --     bone = "seat_pside_r",  -- achterbank rechts
        --     offset = vector3(0.0, 0.15, 0.35),  -- hoogte en positie op stoel aanpassen
        --     rotation = vector3(0.0, 0.0, 90.0),  -- draaiing zodat tas goed ligt
        --     lootTable = {
        --         { prop = "prop_cash_case_01", item = "cash", chance = 50, amount = {100, 500} },
        --     }
        -- }
    }
}


--
-- Vehicle Classes:  
-- 0: Compacts  
-- 1: Sedans  
-- 2: SUVs  
-- 3: Coupes  
-- 4: Muscle  
-- 5: Sports Classics  
-- 6: Sports  
-- 7: Super  
-- 8: Motorcycles  
-- 9: Off-road  
-- 10: Industrial  
-- 11: Utility  
-- 12: Vans  
-- 13: Cycles  
-- 14: Boats  
-- 15: Helicopters  
-- 16: Planes  
-- 17: Service  
-- 18: Emergency  
-- 19: Military  
-- 20: Commercial  
-- 21: Trains  
-- 22: Open Wheel