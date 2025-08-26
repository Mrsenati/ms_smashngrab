return {
        Deleteobject = true -- Delete Object if not taken by player
        Objecttime = 1000000 -- Timer To delete item if not taken by player
        DeleteVeh = true -- Delete the vehicle if Object is spawned and taken
        Vehicletime = 1000000 -- Timer to delete vehicle
        VehicleLootSpots = {
        {
            bone = "seat_pside_f",
            carclass = {0, 1, 4},
            window = nil, -- set nil if no window           
            lootTable = {
                { model = "prop_ld_handbag", offset = vector3(0.0, 0.15, 0.35), rotation = vector3(0.0, 0.0, 90.0), item = "cash", chance = 50, amount = {100, 500} },
            }
        },
        {
            bone = "seat_pside_f",
            carclass = {0, 1, 4},
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
