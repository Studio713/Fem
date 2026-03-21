local Config: Config = {
	Level = "Info",
	Name = "Framework",
}
local Levels = {
	Internal = 1,
	Info = 2,
	Warn = 3,
	Error = 4,
	Fatal = 5,
}

-- :: {
-- [string]: number,
-- Internal: number,
-- Info: number,
-- Warn: number,
-- Error: number,
-- Fatal: number,
-- }
local Utility = {}

local function shouldLog(level: keyof<typeof(Levels)>)
	return (Levels[level] :: number) >= (Levels[Config.Level] :: number)
end

function Utility.SetConfig(opts: Config)
	Config.Name = opts.Name or Config.Name
	Config.Level = opts.Level or Config.Level
end

--[=[
@internal
]=]
function Utility.Internal(...)
	if not shouldLog("Internal") then
		return
	end
	print(`[{Config.Name}][INTERNAL]: {...}`)
end

function Utility.Info(...: any)
	if not shouldLog("Info") then
		return
	end
	print(`[{Config.Name}][INFO]: {...}`)
end

function Utility.Warn(...: any)
	if not shouldLog("Warn") then
		return
	end
	warn(`[{Config.Name}][WARN]: {...}`)
end

function Utility.Error(...: any)
	if not shouldLog("Error") then
		return
	end
	error(`[{Config.Name}][ERROR]: {...}`)
end

function Utility.Fatal(...: any)
	error(`[{Config.Name}][FATAL]: {...}`)
end

type Config = {
	Name: string?,
	Level: keyof<typeof(Levels)>?,
}
return Utility
