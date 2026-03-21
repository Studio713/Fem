local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

local Internals = require(script.Parent.Parent.Utility.Internals)

local plugin = script:FindFirstAncestorOfClass("Plugin") :: Plugin

local Base = {}
Base.__index = Base

function Base.new<T>(root: T)
	return setmetatable({
		_root = root,
	}, Base)
end

function Base.Toggle(self: Widget)
	self._root.Enabled = not self._root.Enabled
end

function Base.Show(self: Widget)
	self._root.Enabled = true
end

function Base.Hide(self: Widget)
	self._root.Enabled = false
end

function Base.SetEnabled(self: Widget, enabled: boolean)
	self._root.Enabled = enabled
end

local Core = {}

function Core.NewDockWidget(name: string, info: DockWidgetPluginGuiInfo)
	local root = plugin:CreateDockWidgetPluginGuiAsync(HttpService:GenerateGUID(false), info)
	local base = Base.new(root)

	root.Name = name
	root.Title = name

	Internals._tracker:Track(root)

	return base
end

function Core.NewOverlay(name: string)
	local root = Instance.new("ScreenGui")
	local base = Base.new(root)

	root.Name = name
	root.Parent = CoreGui

	Internals._tracker:Track(root)

	return base
end

export type Widget = typeof(Base.new(plugin:CreateDockWidgetPluginGuiAsync("", DockWidgetPluginGuiInfo.new())))

export type Overlay = typeof(Base.new(Instance.new("ScreenGui")))

return Core
