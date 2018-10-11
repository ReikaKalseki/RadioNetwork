function mergeSignals(transmitter, state, signals)
	local size = 0
    for _,signal in pairs(signals) do
        local key = signal.signal.type .. ":" .. signal.signal.name
        local previous = state[key]
        if not previous then
            state[key] = {signal = signal.signal, count = signal.count}
        else
            state[key] = {signal = signal.signal, count = signal.count+previous.count}
			size = size+1
        end
		
		if transmitter.type == "satellite" then
			local maxChannels = Config.satelliteChannels*transmitter.entity.force.get_item_launched("comms-satellite")-1 -- -1 to compensate for the fact that this applies one iteration "too late"
			if size > maxChannels then
				playAlert(transmitter, "satelliteoverload", size, maxChannels+1)
				break
			end
		end
    end
end

function mergeState(state, signals)
    for key,signal in pairs(signals) do
        local previous = state[key]
        if not previous then
            state[key] = signal
        else
            state[key] = {signal = signal.signal, count = signal.count+previous.count}
        end
    end
end

function formatSignals(entry, state, maxcount)
    local signals = {}
    local index = 1
    for _,signal in pairs(state) do
        signal.index = index
        if index <= maxcount then
            table.insert(signals, signal)
        end
        index = index+1
    end
	if index > maxcount then
		playAlert(entry, "maxsignals", index, maxcount)
	end
    return signals
end
