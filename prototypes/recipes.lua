data:extend(
{
	{
		type = "recipe",
		name = "radio-transmitter-1",
		enabled = false,
		energy_required = 2.5,
		ingredients = 
		{
			{"steel-plate", 18},
			{"iron-stick", 24},
			{"advanced-circuit", 15},
			{"copper-cable", 60},
		},
		result = "radio-transmitter-1"
	},
	{
		type = "recipe",
		name = "radio-transmitter-2",
		enabled = false,
		energy_required = 8,
		ingredients = 
		{
			{"radio-transmitter-1", 1},
			{"processing-unit", 12},
			{"speed-module", 2},
		},
		result = "radio-transmitter-2"
	},
	{
		type = "recipe",
		name = "radio-transmitter-3",
		enabled = false,
		energy_required = 20,
		ingredients = 
		{
			{"radio-transmitter-2", 1},
			{"effectivity-module-3", 1},
		},
		result = "radio-transmitter-3"
	},
	{
		type = "recipe",
		name = "radio-receiver-1",
		enabled = false,
		energy_required = 1,
		ingredients = 
		{
			{"steel-plate", 9},
			{"iron-stick", 6},
			{"electronic-circuit", 9},
			{"battery", 6},
		},
		result = "radio-receiver-1"
	},
	{
		type = "recipe",
		name = "radio-receiver-2",
		enabled = false,
		energy_required = 3,
		ingredients = 
		{
			{"radio-receiver-1", 1},
			{"advanced-circuit", 9},
			{"battery", 12},
		},
		result = "radio-receiver-2"
	},
	{
		type = "recipe",
		name = "radio-receiver-3",
		enabled = false,
		energy_required = 9,
		ingredients = 
		{
			{"radio-receiver-2", 1},
			{"processing-unit", 15},
		},
		result = "radio-receiver-3"
	},
	{
		type = "recipe",
		name = "radio-repeater",
		enabled = false,
		energy_required = 4,
		ingredients = 
		{
			{"steel-plate", 15},
			{"iron-stick", 20},
			{"processing-unit", 5},
			{"battery", 20},
		},
		result = "radio-repeater"
	},
	{
		type = "recipe",
		name = "comms-satellite",
		enabled = false,
		energy_required = 60,
		ingredients = 
		{
			{"satellite", 1},
			{"radio-repeater", 8},
		},
		result = "comms-satellite"
	}
}
)