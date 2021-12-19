Config = {}

Config.Locations = {

    ['Yellow Jack'] = { -- Can be named anything

        start = vector3(1994.6085, 3052.9604, 47.2145), -- Will display the marker to start the shootout

        count = 10, -- Amount of peds that will spawn

        startText = 'Press ~INPUT_CONTEXT~ to start a fight', -- Text that will appear when in the start marker (~INPUT_CONTEXT~ makes the E showup)

        marker = {
            type = 1,
            size = 1.7,
            r = 255, 
            g = 255,
            b = 255,
            a = 255
        },

        peds = { -- Peds that will spawn in when attack starts
            GetHashKey('g_m_y_lost_01'),
            GetHashKey('g_m_y_lost_02'),
            GetHashKey('g_m_y_lost_03'),
        },

        weapons = { -- Weapons that the peds will use for attack
            'weapon_revolver',
            'weapon_sawnoffshotgun',
        },

        spawnlocs = { -- Where peds will spawn when attack starts
            vector3(1980.1401, 3049.2549, 50.4318),
            vector3(1983.0621, 3026.5354, 47.7965),
            vector3(1997.4485, 3039.3652, 47.0267),
            vector3(1994.8364, 3046.3088, 47.2152),
            vector3(1972.1107, 3056.3047, 46.9456),
            vector3(1974.9384, 3052.2219, 47.1787)
        },
    },
}