Config = {}

Config.tickRate = settings.startup["tick-rate"].value--[[@as integer]]

Config.repeaterRange = settings.startup["repeater-range"].value--[[@as number]]

Config.satelliteChannels = settings.startup["satellite-channels"].value--[[@as integer]]

Config.satellitePacks = settings.startup["satellite-scipacks"].value--[[@as integer]]

Config.maxSignals = {}

Config.maxRange = {}

for i = 1,3 do
	Config.maxSignals[i] = settings.startup["t" .. i .. "-max-signals"].value--[[@as integer]]
end

for i = 1,2 do
	Config.maxRange[i] = settings.startup["t" .. i .. "-range"].value--[[@as number]]
end

Config.maxRange[3] = -1 --infinity