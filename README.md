# Fem

A framework for building Roblox Studio plugins. Handles the boilerplate so you can focus on what your plugin actually does.

## Installation

Add Fem to your `pesde.toml`:

```toml
[dependencies]
fem = { name = "studio713/plugin_framework", version = "^0.1.0" }
```

Then run:

```
pesde install
```

## Quick Start

```lua
local Fem = require(...)

-- Configure logging
Fem.Logger.Configure({
    Name = "MyPlugin",
    Level = "Info"
})

-- Listen for unload
Fem.Unloading:Connect(function()
    Fem.Logger.Info("Plugin unloading")
end)

-- Create a toolbar with a button
local toolbar = Fem.Ribbon.NewToolbar("My Plugin")
local button = toolbar:CreateButton({
    text = "Open Panel",
    tooltip = "Opens the main panel",
    icon = "rbxassetid://0",
})

-- Create a dock widget
local widget = Fem.Widget.NewDockWidget("MyPanel", DockWidgetPluginGuiInfo.new(
    Enum.InitialDockState.Right,
    true, false,
    300, 400,
    200, 100
))

-- Wire up the button to toggle the widget
button:SetCallback(function()
    widget:Toggle()
end)
```

## API

### Logger

Configure logging behaviour for your plugin.

```lua
Fem.Logger.Configure({
    Name = "MyPlugin",   -- prefix shown in all log messages
    Level = "Info",      -- minimum level to show: "Internal" | "Info" | "Warn" | "Error" | "Fatal"
})

Fem.Logger.Info("hello")
Fem.Logger.Warn("something looks off")
Fem.Logger.Error("something went wrong")
Fem.Logger.Fatal("unrecoverable error")
```

---

### Tracker

Manages cleanup of connections, instances, threads, and custom objects. Useful for making sure everything gets cleaned up when your plugin unloads.

```lua
local tracker = Fem.Tracker.new()

-- Track a signal connection
tracker:Track(workspace.ChildAdded:Connect(function() end))

-- Track an instance
tracker:Track(someInstance)

-- Track a thread
tracker:Track(task.delay(5, function() end))

-- Track a custom object with a cleanup function
tracker:TrackCustomObject(myObject, cleanupMethod)

-- Clean everything up
tracker:Clean()
```

---

### Ribbon

Creates toolbars and buttons in the Studio ribbon.

```lua
local toolbar = Fem.Ribbon.NewToolbar("My Plugin")

local button = toolbar:CreateButton({
    text    = "Open Panel",
    tooltip = "Opens the main panel",
    icon    = "rbxassetid://0",
})

button:SetCallback(function()
    -- handle click
end)
```

---

### Widget

Creates UI containers. Both types share the same interface.

#### DockWidget

A panel docked inside Studio.

```lua
local widget = Fem.Widget.NewDockWidget("MyPanel", DockWidgetPluginGuiInfo.new(
    Enum.InitialDockState.Right,
    true, false,
    300, 400,
    200, 100
))
```

#### Overlay

A `ScreenGui` parented to `CoreGui`, sits on top of the viewport.

```lua
local overlay = Fem.Widget.NewOverlay("MyOverlay")
```

#### Shared methods

```lua
widget:Show()
widget:Hide()
widget:Toggle()
widget:SetEnabled(true)
```

---

### Unloading

A signal fired just before the plugin unloads. Use this to do any final cleanup.

```lua
Fem.Unloading:Connect(function()
    -- cleanup
end)
```
