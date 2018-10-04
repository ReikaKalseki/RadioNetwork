require "config"

local function createEmptySprite()
	return
	{
		filename = "__core__/graphics/empty.png",
		priority = "high",
		width = 1,
		height = 1,
		frame_count = 1,
	}
end

local function createTransmitter(tier, power)
	local name = "radio-transmitter-" .. tier
	local lockey = "entity-name.radio-transmitter"
	local desckey = "item-description.radio-transmitter"
	if tier == 3 then
		lockey = "entity-name.satellite-transmitter"
		desckey = "item-description.satellite-transmitter"
	end

	data:extend(
	{
		{
			type = "lamp",
			name = name,
			icon = "__RadioNetwork__/graphics/icons/" .. name .. ".png",
			icon_size = 32,
			localised_name = {lockey, tier},
			flags = {"placeable-player", "player-creation"},
			minable = {hardness = 0.2, mining_time = 0.75, result = name},
			max_health = 150+50*tier,
			corpse = "medium-remnants",
			collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
			selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
			vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
			fast_replaceable_group = "radio-equipment",
			energy_source =
			{
				type = "electric",
				usage_priority = "secondary-input",
				buffer_capacity = math.ceil(0.6*power) .. "kJ",
				drain = math.ceil(0.2*power) .. "kW",
			},
			energy_usage_per_tick = power .. "kW",
			darkness_for_all_lamps_on = 0.001,
			darkness_for_all_lamps_off = 0.0001,
			light =
			{
				intensity = 0.0,
				size = 0
			},
			picture_off =
			{
				filename = "__RadioNetwork__/graphics/entity/" .. name .. ".png",
				priority = "high",
				width = 235,
				height = 207,
				frame_count = 1,
				axially_symmetrical = false,
				direction_count = 1,
				shift = {2.69, -1.91},
			},
			picture_on = createEmptySprite(),
			circuit_wire_connection_point =
			{
				shadow =
				{
					red = {1.09, -0.19},
					green = {0.34, 0.56},
				},
				wire =
				{
					red = {0.66, -0.53},
					green = {-0.13, 0.22},
				}
			},
			circuit_wire_max_distance = 9+3*tier
		},
		{
			type = "item",
			name = name,
			icon = "__RadioNetwork__/graphics/icons/" .. name .. ".png",
			icon_size = 32,
			localised_name = {lockey, tier},
			localised_description = {desckey, Config.maxRange[tier]},
			flags = {"goes-to-quickbar"},
			subgroup = "circuit-network",
			order = "c[radio]-a[" .. name .. "]",
			place_result = name,
			stack_size = 10,
		},
	})
end

local function createReceiverSprite()
	return
	{
		filename = "__RadioNetwork__/graphics/entity/radio-receiver.png",
		width = 203,
		height = 179,
		frame_count = 1,
		shift = {2.25, -1.91},
	}
end

local function createReciever(tier)
	local name = "radio-receiver-" .. tier

	data:extend({
		{
			type = "constant-combinator",
			name = name,
			icon = "__RadioNetwork__/graphics/icons/radio-receiver.png",
			icon_size = 32,
			localised_name = {"entity-name.radio-receiver", tier},
			flags = {"placeable-player", "player-creation"},
			minable = {hardness = 0.2, mining_time = 0.75, result = name},
			max_health = 100+25*tier,
			corpse = "medium-remnants",
			collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
			selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
			vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
			fast_replaceable_group = "radio-equipment",
			item_slot_count = Config.maxSignals[tier],
			sprites = 
			{
				north = createReceiverSprite(),
				east = createReceiverSprite(),
				south = createReceiverSprite(),
				west = createReceiverSprite(),
			},
			activity_led_sprites =
			{
				north = createEmptySprite(),
				east = createEmptySprite(),
				south = createEmptySprite(),
				west = createEmptySprite(),
			},
			activity_led_light =
			{
				intensity = 0,
				size = 0
			},
			activity_led_light_offsets =
			{
				{0, 0},
				{0, 0},
				{0, 0},
				{0, 0}
			},
			circuit_wire_connection_points =
			{
				{
					shadow =
					{
						red = {-0.09, 0.19},
						green = {0.81, 0.47},
					},
					wire =
					{
						red = {-0.41, -0.19},
						green = {0.37, 0.0},
					}
				},
				{
					shadow =
					{
						red = {-0.09, 0.19},
						green = {0.81, 0.47},
					},
					wire =
					{
						red = {-0.41, -0.19},
						green = {0.37, 0.0},
					}
				},
				{
					shadow =
					{
						red = {-0.09, 0.19},
						green = {0.81, 0.47},
					},
					wire =
					{
						red = {-0.41, -0.19},
						green = {0.37, 0.0},
					}
				},
				{
					shadow =
					{
						red = {-0.09, 0.19},
						green = {0.81, 0.47},
					},
					wire =
					{
						red = {-0.41, -0.19},
						green = {0.37, 0.0},
					}
				}
			},
			circuit_wire_max_distance = 9+3*tier
		},
		{
			type = "item",
			name = name,
			icon = "__RadioNetwork__/graphics/icons/radio-receiver.png",
			icon_size = 32,
			localised_name = {"entity-name.radio-receiver", tier},
			localised_description = {"item-description.radio-receiver", Config.maxSignals[tier]},
			flags = {"goes-to-quickbar"},
			subgroup = "circuit-network",
			order = "c[radio]-a[" .. name .. "]",
			place_result = name,
			stack_size = 10,
		},
	})
end

createTransmitter(1, 600)
createTransmitter(2, 1200)
createTransmitter(3, 4000)

createReciever(1)
createReciever(2)
createReciever(3)

data:extend(
{
    {
        type = "beacon",
        name = "radio-repeater",
        icon = "__RadioNetwork__/graphics/icons/radio-repeater.png",
        icon_size = 32,
        flags = {"placeable-player", "player-creation"},
        minable = {hardness = 0.2, mining_time = 0.75, result = "radio-repeater"},
        max_health = 100,
        corpse = "medium-remnants",
        dying_explosion = "medium-explosion",
        collision_box = {{-0.8, -0.8}, {0.8, 0.8}},
        selection_box = {{-0.9, -0.9}, {0.9, 0.9}},
        vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
        fast_replaceable_group = "radio-equipment",
        allowed_effects = {"consumption"},
        base_picture =
        {
            filename = "__RadioNetwork__/graphics/entity/radio-repeater.png",
            width = 129,
            height = 113,
            shift = {0.91, -0.84},
			frame_count = 1,
        },
        animation = createEmptySprite(),
        animation_shadow = createEmptySprite(),
        radius_visualisation_picture = createEmptySprite(),
        supply_area_distance = 0,
        energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            buffer_capacity = "500kJ"
        },
        energy_usage = "800kW",
        distribution_effectivity = 0,
        module_specification =
        {
            module_slots = 0,
            module_info_icon_shift = {0, 0},
            module_info_multi_row_initial_height_modifier = 0
        }
    },
	{
		type = "item",
		name = "radio-repeater",
		icon = "__RadioNetwork__/graphics/icons/radio-repeater.png",
		icon_size = 32,
		localised_description = {"item-description.radio-repeater", Config.repeaterRange},
		flags = {"goes-to-quickbar"},
		subgroup = "circuit-network",
		order = "c[radio]-c[repeater]",
		place_result = "radio-repeater",
		stack_size = 10,
	},
}
)

local item = table.deepcopy(data.raw.item.satellite)
item.name = "comms-satellite"
item.icon = "__RadioNetwork__/graphics/icons/satellite.png"
item.localised_description = {"item-description.comms-satellite", Config.satelliteChannels}
item.rocket_launch_product = nil

data:extend({item})