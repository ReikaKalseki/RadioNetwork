local function playAlert(entry, alert, data)
	if entry.printedWarnings[alert] then return end
	entry.printedWarnings[alert] = true
	entry.entity.force.print({{"warning-messages." .. entry}, {"entity-name." .. entry.entity.name}, serpent.block(entry.entity.position), data})
end

function mergeSignals(state, signals)
    for _,signal in pairs(signals) do
        local key = signal.signal.type .. ":" .. signal.signal.name
        --debugPrint("Found a signal: " .. key)
        local previous = state[key]
        if not previous then
            state[key] = {signal = signal.signal, count = signal.count}
        else
            state[key] = {signal = signal.signal, count = signal.count+previous.count}
        end
    end
end

function mergeState(state, a)
    for key,signal in pairs(a) do
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
            --debugPrint("Formatting: " .. signal.signal.name)
            table.insert(signals, signal)
        else
            playAlert(entry, "maxsignals", maxcount)
        end
        index = index+1
    end
    return signals
end
