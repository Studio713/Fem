local Ribbon = require(script.Core.Ribbon)
local Widget = require(script.Core.Widget)
local Signal = require(script.Packages.Signal)
local Internals = require(script.Utility.Internals)
local Logger = require(script.Utility.Logger)
local Tracker = require(script.Utility.Tracker)

local plugin = script:FindFirstAncestorOfClass("Plugin") :: Plugin

local Framework = {}

-- Signals
Framework.Unloading = Signal.new()

-- Exported Internals
Framework.Logger = Logger
Framework.Tracker = Tracker
Framework.Ribbon = Ribbon
Framework.Widget = Widget

Internals._tracker:TrackCustomObject(Framework.Unloading, "Destroy")

plugin.Unloading:Once(function()
	Logger.Internal("Unloading plugin")
	Framework.Unloading:Fire()
	Internals._tracker:Clean()
end)

return Framework
