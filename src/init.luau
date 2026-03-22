local Ribbon = require("@self/Core/Ribbon")
local Widget = require("@self/Core/Widget")
local History = require("@self/Helpers/History")
local Selection = require("@self/Helpers/Selection")
local Internals = require("@self/Utility/Internals")
local Logger = require("@self/Utility/Logger")
local Tracker = require("@self/Utility/Tracker")

local plugin = script:FindFirstAncestorOfClass("Plugin") :: Plugin

local Framework = {}

-- Exported Internals
Framework.Logger = Logger
Framework.Tracker = Tracker
Framework.Ribbon = Ribbon
Framework.Widget = Widget
-- Exported Helpers
Framework.History = History
Framework.Selection = Selection
-- Exported Types
export type Toolbar = Ribbon.Toolbar
export type Button = Ribbon.Button

plugin.Unloading:Once(function()
	Logger.Internal("Unloading plugin")
	Internals._tracker:Clean()
end)

return Framework
