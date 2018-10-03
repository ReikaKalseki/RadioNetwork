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
end

script.on_init(function()
	initGlobal(false)
end)

script.on_configuration_changed(function()
	initGlobal(false)
end)

local function isInRange(transmitter, receiver)
	return transmitter.range >= math.sqrt((receiver.entity.position.x-transmitter.entity.position.x)^2+(receiver.entity.position.y-transmitter.entity.position.y)^2)
end

-- returns a list of transmitters that the receiver is in range of
local function getTransmittersInRange(receiver)
	local ret = {}
	for _,transmitter in pairs(global.radio.transmitters) do
		if transmitter.entity.valid and isInRange(transmitter, receiver) then
			table.insert(ret, transmitter)
		end
	end
	return ret
end

local function onEntityCreated(event)
	local entity = event.created_entity
	local idx = string.find(entity.name, "%-[^-]+$")
	local n = string.sub(entity.name, idx)
	game.print(n)
	local tier = tonumber(n)
	if string.find(entity.name, "radio-transmitter", 1, true) then
		entity.operable = false
		entity.get_or_create_control_behavior().connect_to_logistic_network = false
		entity.get_control_behavior().circuit_condition = cachedSignal
		global.radio.transmitters[entity.unit_number] = {entity = entity, tier = tier, range = Config.maxRange[tier], signals = {parameters = {}}, printedWarnings = {}}
	elseif string.find(entity.name, "radio-receiver", 1, true) then
		global.radio.receivers[entity.unit_number] = {entity = entity, tier = tier, printedWarnings = {}}
	end
end

local function onEntityRemoved(event)
	local entity = event.entity
	if string.find(entity.name, "radio-transmitter", 1, true) then
		global.radio.transmitters[entity.unit_number] = nil
	elseif string.find(entity.name, "radio-receiver", 1, true) then
		global.radio.receivers[entity.unit_number] = nil
	end
end

local function onTick(event)
	if event.tick%Config.tickRate > 0 then return end
	
	local radio = global.radio

	for id,transmitter in pairs(radio.transmitters) do
		if transmitter.entity.valid then
			if transmitter.entity.energy > 0 then
				local data = {}
				for i = 1, #wires do
					local net = transmitter.entity.get_circuit_network(wires[i])
					if net and net.signals then
						mergeSignals(data, net.signals)
					end
				end
				transmitter.signals.parameters = data
			end
		else
			radio.transmitters[id] = nil
		end
	 end
	 
	 for id,receiver in pairs(radio.receivers) do
		if receiver.entity.valid then
			local li0 = {}
			local li = getTransmittersInRange(receiver)
			for _,transmitter in pairs(li) do
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
