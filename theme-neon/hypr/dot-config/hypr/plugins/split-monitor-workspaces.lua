--- split-monitor-workspaces.lua
--- Entry point and public API for the split-monitor-workspaces Lua library.
--- Source: https://github.com/zjeffer/split-monitor-workspaces

local globals     = require("globals")
local helpers     = require("helpers")
local monitors    = require("monitors")
local dispatchers = require("dispatchers")

local api         = {}

--- Switch to workspace N (1-indexed within the current monitor's range).
--- Also supports "+N", "-N", "next", "prev", and "empty".
---@param workspace_str string
---@return fun(): nil
function api.workspace(workspace_str)
	return function() dispatchers.do_workspace(workspace_str) end
end

--- Cycle workspaces on the current monitor.
---@param value string "next", "prev", "+N", or "-N"
---@return fun(): nil
function api.cycle_workspaces(value)
	return function() dispatchers.do_cycle_workspaces(value, not globals.cfg.enable_wrapping) end
end

--- Move the active window to workspace N and follow it.
---@param workspace_str string
---@return fun(): nil
function api.move_to_workspace(workspace_str)
	return function() dispatchers.do_move_to_workspace(workspace_str, false) end
end

--- Move the active window to workspace N silently (no focus change).
---@param workspace_str string
---@return fun(): nil
function api.move_to_workspace_silent(workspace_str)
	return function() dispatchers.do_move_to_workspace(workspace_str, true) end
end

--- Move all windows not assigned to any mapped workspace to the current workspace.
---@return fun(): nil
function api.grab_rogue_windows()
	return function() dispatchers.do_grab_rogue_windows() end
end

---@param user_config SMW.Config?
function api.setup(user_config)
	print("[split-monitor-workspaces] Initializing split-monitor-workspaces...")

	if user_config then
		for k, v in pairs(user_config) do
			globals.cfg[k] = v
		end
	end

	for i, name in ipairs(globals.cfg.monitor_priority) do
		globals.monitor_priorities[name] = { value = i - 1, from_config = true }
	end

	for name, count in pairs(globals.cfg.max_workspaces) do
		globals.monitor_max_ws_override[name] = { value = count, from_config = true }
	end

	hl.on("monitor.added", function(monitor)
		monitors.map_monitor(monitor)
	end)
	hl.on("monitor.removed", function(monitor)
		monitors.unmap_monitor(monitor)
	end)
	hl.on("config.reloaded", function()
		for name, p in pairs(globals.monitor_priorities) do
			if not p.from_config then globals.monitor_priorities[name] = nil end
		end
		for name, p in pairs(globals.monitor_max_ws_override) do
			if not p.from_config then globals.monitor_max_ws_override[name] = nil end
		end
		monitors.remap_all_monitors()
		helpers.notify("Initialized successfully!")
	end)
end

---@return integer
function api.get_amount_of_workspaces()
	return globals.cfg.workspace_count
end

return api
