Config = {}

Config.tickRate = settings.startup["tick-rate"].value

Config.repeaterRange = settings.startup["repeater-range"].value

Config.satelliteChannels = settings.startup["satellite-channels"].value

Config.maxSignals = {}

Config.maxRange = {}

for i = 1,3 do
	Config.maxSignals[i] = settings.startup["t" .. i .. "-max-signals"].value
end

for i = 1,2 do
	Config.maxRange[i] = settings.startup["t" .. i .. "-range"].value
end

Config.maxRange[3] = -1 --infinity