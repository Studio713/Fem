local ChangeHistoryService = game:GetService("ChangeHistoryService")

local Logger = require(script.Parent.Parent.Utility.Logger)

local Recording = {}
Recording.__index = Recording

local lastRecording

function Recording.new(id: string)
	return setmetatable({
		_id = id,
		_finished = false,
	}, Recording)
end

function Recording.Commit(self: Recording, options: { [string]: any }?)
	if self._finished then
		Logger.Warn(`Recording {self._id} is already finished.`)
		return
	end
	self._finished = true
	lastRecording = nil
	ChangeHistoryService:FinishRecording(self._id, Enum.FinishRecordingOperation.Commit, options)
end

function Recording.Cancel(self: Recording, options: { [string]: any }?)
	if self._finished then
		Logger.Warn("Recording already finished")
		return
	end
	self._finished = true
	lastRecording = nil
	ChangeHistoryService:FinishRecording(self._id, Enum.FinishRecordingOperation.Cancel, options)
end

function Recording.Append(self: Recording, options: { [string]: any }?)
	if self._finished then
		Logger.Warn("Recording already finished")
		return
	end
	self._finished = true
	lastRecording = nil
	ChangeHistoryService:FinishRecording(self._id, Enum.FinishRecordingOperation.Append, options)
end

local Helper = {}

--[=[
	Records a change in the history.

	@param name The name of the change used for logging and coding purposes.
	@param displayName Name that is displayed to the user.
]=]
function Helper.Record(name: string, displayName: string?)
	local recording = ChangeHistoryService:TryBeginRecording(name, displayName)
	if not recording then
		Logger.Warn(`Recording "{lastRecording}" was cancelled due to another recording starting.`)
		ChangeHistoryService:FinishRecording("", Enum.FinishRecordingOperation.Cancel)
		lastRecording = nil
		recording = ChangeHistoryService:TryBeginRecording(name, displayName)
	end

	lastRecording = recording

	return Recording.new(recording :: string)
end

function Helper.SetWaypoint(name: string)
	ChangeHistoryService:SetWaypoint(name)
end

function Helper.ResetWaypoints()
	ChangeHistoryService:ResetWaypoints()
end

function Helper.Undo()
	ChangeHistoryService:Undo()
end

function Helper.Redo()
	ChangeHistoryService:Redo()
end

export type Recording = typeof(Recording.new(""))

return Helper
