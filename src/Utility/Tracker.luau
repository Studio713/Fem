local ConnectionHandlers = {
	Instance = function(conn: Instance)
		conn:Destroy()
	end,
	RBXScriptConnection = function(conn: RBXScriptConnection)
		conn:Disconnect()
	end,
	thread = function(conn: thread)
		task.cancel(conn)
	end,
	table = function<T>(conn: { conn: T, method: string })
		local connection = conn.conn :: { [string]: (T) -> () }
		if connection[conn.method] then
			connection[conn.method](connection)
		end
	end,
}

local Utility = {}
Utility.__index = Utility

function Utility.new()
	return setmetatable({
		_connections = {} :: { any },
	}, Utility)
end

function Utility.Track(self: Tracker, conn: TrackableObject)
	table.insert(self._connections, conn)
	return conn
end

function Utility.TrackCustomObject<T>(self: Tracker, conn: T, method: string)
	table.insert(self._connections, { conn = conn, method = method })
	return conn
end

function Utility.Clean(self: Tracker)
	for _, connection in self._connections do
		local type = typeof(connection)
		if ConnectionHandlers[type] then
			ConnectionHandlers[type](connection)
		else
			error(`[Tracker] Unhandled trackable type: {type}`)
		end
	end
	table.clear(self._connections)
end

type TrackableObject = Instance | RBXScriptConnection | thread

export type Tracker = typeof(Utility.new())

return Utility
