if data.raw.item["advanced-processing-unit"] then
	table.insert(data.raw.recipe["radio-transmitter-3"].ingredients, {"advanced-processing-unit", 9})
	table.insert(data.raw.recipe["comms-satellite"].ingredients, {"advanced-processing-unit", 20})
	table.insert(data.raw.technology["circuit-transmitters-3"].prerequisites, "advanced-electronics-3")
else
	table.insert(data.raw.recipe["radio-transmitter-3"].ingredients, {"processing-unit", 18})
	table.insert(data.raw.recipe["comms-satellite"].ingredients, {"processing-unit", 50})
end

if data.raw.item["aluminium-plate"] then
	table.insert(data.raw.recipe["radio-transmitter-2"].ingredients, {"aluminium-plate", 15})
	table.insert(data.raw.technology["circuit-transmitters-2"].prerequisites, "aluminium-processing")
else
	table.insert(data.raw.recipe["radio-transmitter-2"].ingredients, {"steel-plate", 24})
end

if data.raw.item["titanium-plate"] then
	table.insert(data.raw.recipe["radio-transmitter-3"].ingredients, {"titanium-plate", 12})
	table.insert(data.raw.technology["circuit-transmitters-3"].prerequisites, "titanium-processing")
else
	table.insert(data.raw.recipe["radio-transmitter-3"].ingredients, {"steel-plate", 30})
end

if data.raw.item["nickel-plate"] then
	table.insert(data.raw.recipe["radio-receiver-2"].ingredients, {"nickel-plate", 8})
	table.insert(data.raw.technology["circuit-receivers-2"].prerequisites, "nickel-processing")
else
	table.insert(data.raw.recipe["radio-receiver-2"].ingredients, {"steel-plate", 12})
end

if data.raw.item["cobalt-steel-alloy"] then
	table.insert(data.raw.recipe["radio-receiver-3"].ingredients, {"cobalt-steel-alloy", 6})
	table.insert(data.raw.technology["circuit-receivers-3"].prerequisites, "cobalt-processing")
else
	table.insert(data.raw.recipe["radio-receiver-3"].ingredients, {"steel-plate", 15})
end

if data.raw.item["gilded-copper-cable"] then
	table.insert(data.raw.recipe["radio-transmitter-2"].ingredients, {"insulated-cable", 45})
	table.insert(data.raw.recipe["radio-transmitter-3"].ingredients, {"gilded-copper-cable", 30})
	table.insert(data.raw.recipe["radio-repeater"].ingredients, {"tinned-copper-cable", 30})
	--table.insert(data.raw.technology["circuit-transmitters-3"].prerequisites, "advanced-electronics-3")
else
	table.insert(data.raw.recipe["radio-transmitter-2"].ingredients, {"copper-cable", 90})
	table.insert(data.raw.recipe["radio-transmitter-3"].ingredients, {"copper-cable", 120})
	table.insert(data.raw.recipe["radio-repeater"].ingredients, {"copper-cable", 30})
end

if data.raw.item["lithium-ion-battery"] then
	table.insert(data.raw.recipe["radio-receiver-3"].ingredients, {"lithium-ion-battery", 10})
	table.insert(data.raw.technology["circuit-receivers-3"].prerequisites, "battery-2")
	table.insert(data.raw.recipe["comms-satellite"].ingredients, {"silver-zinc-battery", 20})
else
	table.insert(data.raw.recipe["radio-receiver-3"].ingredients, {"battery", 25})
	table.insert(data.raw.recipe["comms-satellite"].ingredients, {"battery", 100})
end

if data.raw.tool["logistic-science-pack"] then
	for _,pack in pairs(data.raw.technology["circuit-receivers-3"].unit.ingredients) do
		if pack[1] == "production-science-pack" then
			pack[1] = "logistic-science-pack"
		end
	end
	table.insert(data.raw.technology["circuit-transmitters-3"].unit.ingredients, {"logistic-science-pack", 1})
end