local HttpService = game:GetService("HttpService")

local Internals = require(script.Parent.Parent.Utility.Internals)

local plugin = script:FindFirstAncestorOfClass("Plugin") :: Plugin

local Button = {}
Button.__index = Button

function Button.new(props: {
	toolbar: Toolbar,
	button: PluginToolbarButton,
})
	local self = setmetatable({
		_toolbar = props.toolbar,
		_button = props.button,
		_callback = function()
			-- NOOP
		end,
	}, Button)

	Internals._tracker:Track(self._button.Click:Connect(function()
		self._callback()
	end))

	return self
end

function Button.SetCallback(self: Button, callback: () -> ())
	self._callback = callback
end

local Toolbar = {}
Toolbar.__index = Toolbar

function Toolbar.new(name: string)
	return setmetatable({
		_toolbar = plugin:CreateToolbar(name),
		_name = name,
	}, Toolbar)
end

function Toolbar.CreateButton(
	self: Toolbar,
	props: {
		tooltip: string,
		icon: string,
		text: string,
	}
)
	return Button.new({
		toolbar = self,
		button = self._toolbar:CreateButton(HttpService:GenerateGUID(false), props.tooltip, props.icon, props.text),
	})
end

local Core = {}

Core.NewToolbar = Toolbar.new

export type Toolbar = typeof(Toolbar.new(""))

export type Button = typeof(Button.new({
	toolbar = Toolbar.new(""),
	button = plugin:CreateToolbar(""):CreateButton("", "", ""),
}))

return Core
