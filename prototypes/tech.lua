data:extend(
{
    {
        type = "technology",
        name = "telemetry",
        icon = "__RadioNetwork__/graphics/tech.png",
        icon_size = 128,
        effects = 
        {
            {
                type = "unlock-recipe",
                recipe = "radio-transmitter-1"
            },
            {
                type = "unlock-recipe",
                recipe = "radio-receiver-1"
            }
        },
        prerequisites = {"circuit-network", "advanced-electronics", "battery"},
        unit =
        {
            count = 50,
            ingredients = 
            {
                {"science-pack-1", 1},
                {"science-pack-2", 1},
                {"science-pack-3", 1},
            },
            time = 30
        },
        order = "a-d-e",
    },
    {
        type = "technology",
        name = "circuit-transmitters-2",
        icon = "__RadioNetwork__/graphics/tech.png",
        icon_size = 128,
        effects = 
        {
            {
                type = "unlock-recipe",
                recipe = "radio-repeater"
            },
            {
                type = "unlock-recipe",
                recipe = "radio-transmitter-2"
            }
        },
        prerequisites = {"telemetry", "speed-module", "advanced-electronics-2"},
		upgrade = true,
        unit =
        {
            count = 100,
            ingredients = 
            {
                {"science-pack-1", 1},
                {"science-pack-2", 1},
                {"science-pack-3", 1},
            },
            time = 45
        },
        order = "a-d-e",
    },
    {
        type = "technology",
        name = "circuit-receivers-2",
        icon = "__RadioNetwork__/graphics/tech.png",
        icon_size = 128,
        effects = 
        {
            {
                type = "unlock-recipe",
                recipe = "radio-receiver-2"
            }
        },
        prerequisites = {"telemetry"},
		upgrade = true,
        unit =
        {
            count = 100,
            ingredients = 
            {
                {"science-pack-1", 1},
                {"science-pack-2", 1},
                {"science-pack-3", 1},
            },
            time = 45
        },
        order = "a-d-e",
    },
    {
        type = "technology",
        name = "circuit-receivers-3",
        icon = "__RadioNetwork__/graphics/tech.png",
        icon_size = 128,
        effects = 
        {
            {
                type = "unlock-recipe",
                recipe = "radio-receiver-3"
            }
        },
        prerequisites = {"circuit-receivers-2", "advanced-electronics-2"},
		upgrade = true,
        unit =
        {
            count = 100,
            ingredients = 
            {
                {"science-pack-1", 1},
                {"science-pack-2", 1},
                {"science-pack-3", 1},
            },
            time = 45
        },
        order = "a-d-e",
    },
    {
        type = "technology",
        name = "circuit-transmitters-3",
        icon = "__RadioNetwork__/graphics/tech.png",
        icon_size = 128,
        effects = 
        {
            {
                type = "unlock-recipe",
                recipe = "radio-transmitter-3"
            },
        },
        prerequisites = {"circuit-transmitters-2", "rocket-silo", "effectivity-module-3"},
		upgrade = true,
        unit =
        {
            count = 400,
            ingredients = 
            {
                {"science-pack-1", 1},
                {"science-pack-2", 1},
                {"science-pack-3", 1},
                {"high-tech-science-pack", 1},
            },
            time = 45
        },
        order = "a-d-e",
    },
}
)