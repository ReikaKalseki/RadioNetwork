require "config"

require "util"
require "signal-processing"

local wires = {defines.wire_type.red, defines.wire_type.green}

local cachedSignal = {
	condition = {
		comparator = ">",
		first_signal = {type = "virtual", name = "signal-everything"},
		constant = 0
	}
}

local function initGlobal(force)
	if force or global.radio == nil then
		global.radio = {}
	end
	if force or global.radio.transmitters == nil then
		global.radio.transmitters = {}
	end
	if force or global.radio.receivers == nil then
		global.radio.receivers = {}
	end
	if force or global.radio.repeaters == nil then
		global.radio.repeaters = {}
	end
end

script.on_init(function()
	initGlobal(false)
end)

script.on_configuration_changed(function()
	initGlobal(false)
end)

function playAlert(entry, alert, data1, data2, data3)
	if entry.printedWarnings[alert] then return end
	entry.printedWarnings[alert] = true
	entry.entity.force.print({"warning-messages." .. alert, entry.entity.prototype.localised_name, serpent.block(entry.entity.position), data1, data2, data3})
end

local function isInRange(entry, receiver)
	return entry.range <= 0 or entry.range*entry.range >= (receiver.entity.position.x-entry.entity.position.x)^2+(receiver.entity.position.y-entry.entity.position.y)^2
end

-- returns a list of transmitters that the receiver is in range of
local function getTransmittersInRange(receiver)
	local ret = {}
	for _,transmitter in pairs(global.radio.transmitters) do
		if transmitter.entity.valid and isInRange(transmitter, receiver) then
			ret[transmitter.id] = transmitter
		end
	end
	for _,repeater in pairs(global.radio.repeaters) do
		if repeater.entity.valid and isInRange(repeater, receiver) then
			for id,transmitter in pairs(repeater.transmitters) do
				ret[transmitter.id] = transmitter
			end
		end
	end
	return ret
end

local function onEntityCreated(event)
	local entity = event.created_entity
	if string.find(entity.name, "radio-transmitter", 1, true) then
		local idx = string.find(entity.name, "%-[^-]+$")
		local n = string.sub(entity.name, idx+1)
		local tier = tonumber(n)
		entity.operable = false
		entity.get_or_create_control_behavior().connect_to_logistic_network = false
		entity.get_control_behavior().circuit_condition = cachedSignal
		global.radio.transmitters[entity.unit_number] = {entity = entity, type = tier == 3 and "satellite" or "radio", id = entity.unit_number, tier = tier, range = Config.maxRange[tier], signals = {parameters = {}}, printedWarnings = {}}
	elseif string.find(entity.name, "radio-receiver", 1, true) then
		local idx = string.find(entity.name, "%-[^-]+$")
		local n = string.sub(entity.name, idx+1)
		local tier = tonumber(n)
		global.radio.receivers[entity.unit_number] = {entity = entity, id = entity.unit_number, tier = tier, printedWarnings = {}}
	elseif string.find(entity.name, "radio-repeater", 1, true) then
		global.radio.repeaters[entity.unit_number] = {entity = entity, id = entity.unit_number, transmitters = {}, range = Config.repeaterRange, printedWarnings = {}}
	end
end

local function onEntityRemoved(event)
	local entity = event.entity
	if string.find(entity.name, "radio-transmitter", 1, true) then
		global.radio.transmitters[entity.unit_number] = nil
	elseif string.find(entity.name, "radio-receiver", 1, true) then
		global.radio.receivers[entity.unit_number] = nil
	elseif string.find(entity.name, "radio-repeater", 1, true) then
		global.radio.repeaters[entity.unit_number] = nil
	end
end

local function onTick(event)
	if event.tick%Config.tickRate > 0 then return end
	
	local radio = global.radio

	for id,transmitter in pairs(radio.transmitters) do
		if transmitter.entity.valid then
			if transmitter.entity.energy > 0 and (transmitter.type ~= "satellite" or transmitter.entity.force.get_item_launched("comms-satellite") > 0) then
				local data = {}
				for i = 1, #wires do
					local net = transmitter.entity.get_circuit_network(wires[i])
					if net and net.signals then
						mergeSignals(transmitter, data, net.signals)
					end
				end
				transmitter.signals.parameters = data
			else
				transmitter.signals.parameters = {}
			end
		else
			radio.transmitters[id] = nil
		end
	 end
	 
	 for id,repeater in pairs(radio.repeaters) do
		if repeater.entity.valid and repeater.entity.energy > 0 then
			repeater.transmitters = {}
			local li = getTransmittersInRange(repeater)
			for id,transmitter in pairs(li) do
				repeater.transmitters[id] = transmitter
			end
		else
			radio.repeaters[id] = nil
		end
	end
	 
	 for id,receiver in pairs(radio.receivers) do
		if receiver.entity.valid then
			local li0 = {}
			local li = getTransmittersInRange(receiver)
			for id,transmitter in pairs(li) do
				mergeState(li0, transmitter.signals.parameters)
			end
			local data = formatSignals(receiver, li0, receiver.entity.get_control_behavior().signals_count)
			if data and #data > 0 then
				receiver.entity.get_control_behavior().parameters = {parameters = data}
			else
				receiver.entity.get_control_behavior().parameters = nil
			end
		else
			radio.receivers[id] = nil
		end
	end
end

script.on_event(defines.events.on_built_entity, onEntityCreated)
script.on_event(defines.events.on_robot_built_entity, onEntityCreated)

script.on_event(defines.events.on_pre_player_mined_item, onEntityRemoved)
script.on_event(defines.events.on_robot_pre_mined, onEntityRemoved)
script.on_event(defines.events.on_entity_died, onEntityRemoved)

script.on_event(defines.events.on_tick, onTick)
