local Selection = game:GetService("Selection")

local Internals = require("../Utility/Internals")

local plugin = script:FindFirstAncestorOfClass("Plugin") :: Plugin

local Helper = {}

function Helper.Get()
	return Selection:Get()
end

function Helper.Select(instances: { Instance })
	Selection:Set(instances)
end

function Helper.SaveSelection(saveOnFileSystem: boolean?, suggestedFileName: string?)
	if #Selection:Get() < 1 then
		return false
	end

	if saveOnFileSystem then
		return plugin:PromptSaveSelectionAsync(suggestedFileName)
	end

	plugin:SaveSelectedToRoblox()
	return true
end

function Helper.OnSelectionChanged(callback: (instances: { Instance }) -> ())
	Internals._tracker:Track(Selection.SelectionChanged:Connect(function()
		callback(Helper.Get())
	end))
end

return Helper
