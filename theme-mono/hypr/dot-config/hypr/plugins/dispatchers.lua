--- dispatchers.lua
--- Imperative implementations of each split-monitor-workspaces action.

local globals = require("globals")
local helpers = require("helpers")

local dispatchers = {}

--- ============================================================
--- split-workspace
--- ============================================================

---@param workspace_str string
function dispatchers.do_workspace(workspace_str)
	---@type HL.Monitor|nil
	local current_monitor = helpers.get_current_monitor()
	if not current_monitor then
		error("[split-monitor-workspaces] No current monitor? Cannot switch workspace.")
		return
	end

	if globals.cfg.link_monitors then
		for _, monitor in ipairs(hl.get_monitors()) do
			---@type string
			local target_workspace = helpers.get_workspace_from_monitor(monitor, workspace_str)
			if hl.get_workspace(target_workspace) == nil then
				hl.dispatch(hl.dsp.focus({ workspace = target_workspace }))
			end
			hl.dispatch(hl.dsp.workspace.move({ workspace = target_workspace, monitor = monitor.name, follow = true }))
			hl.dispatch(hl.dsp.focus({ workspace = target_workspace }))
		end
		hl.dispatch(hl.dsp.focus({ workspace = helpers.get_workspace_from_monitor(current_monitor, workspace_str) }))
	else
		---@type string
		local resolved = helpers.get_workspace_from_monitor(current_monitor, workspace_str)
		hl.dispatch(hl.dsp.focus({ workspace = resolved }))
	end
end

--- ============================================================
--- split-cycleworkspaces
--- ============================================================

---@param value string "next", "prev", "+N", "-N"
---@param no_wrap boolean
function dispatchers.do_cycle_workspaces(value, no_wrap)
	---@type integer
	local delta = helpers.direction_to_delta(value)
	if delta == 0 then
		error("[split-monitor-workspaces] Invalid value for cycle_workspaces: " .. tostring(value))
		return
	end

	---@type HL.Monitor[]
	local monitors_to_cycle

	if globals.cfg.link_monitors then
		monitors_to_cycle = hl.get_monitors()
	else
		local m = helpers.get_current_monitor()
		monitors_to_cycle = m and { m } or {}
	end

	---@type HL.Monitor|nil
	local current_monitor = helpers.get_current_monitor()

	for _, monitor in ipairs(monitors_to_cycle) do
		---@type string[]|nil
		local ws_list = globals.monitor_workspace_map[monitor.id]
		if not ws_list then goto continue end

		---@type string|nil
		local active_name = monitor.active_workspace and monitor.active_workspace.name
		---@type integer|nil
		local idx = nil
		for i, name in ipairs(ws_list) do
			if name == active_name then
				idx = i; break
			end
		end
		if not idx then goto continue end

		idx = idx + delta
		if idx < 1 then
			if no_wrap then goto continue end
			idx = #ws_list
		elseif idx > #ws_list then
			if no_wrap then goto continue end
			idx = 1
		end

		---@type string
		local target = ws_list[idx]
		hl.dispatch(hl.dsp.focus({ workspace = target }))

		::continue::
	end

	if globals.cfg.link_monitors then
		if not current_monitor then
			error("[split-monitor-workspaces] No current monitor? Cannot switch workspace.")
			return
		end
		hl.dispatch(hl.dsp.focus({ workspace = helpers.get_workspace_from_monitor(current_monitor, value) }))
	end
end

--- ============================================================
--- split-movetoworkspace / split-movetoworkspacesilent
--- ============================================================

---@param workspace_str string
---@param silent boolean
function dispatchers.do_move_to_workspace(workspace_str, silent)
	---@type HL.Monitor|nil
	local monitor = helpers.get_current_monitor()
	if not monitor then
		error("[split-monitor-workspaces] No current monitor? Cannot move window to workspace.")
		return
	end

	---@type string
	local resolved = helpers.get_workspace_from_monitor(monitor, workspace_str)

	if hl.plugin.hy3 then
		if silent then
			hl.dispatch(hl.plugin.hy3.move_to_workspace(resolved))
		else
			hl.dispatch(hl.plugin.hy3.move_to_workspace(resolved, { follow = true }))
		end
	else
		if silent then
			hl.dispatch(hl.dsp.window.move({ workspace = resolved, follow = false }))
		else
			hl.dispatch(hl.dsp.window.move({ workspace = resolved }))
		end
	end

	if globals.cfg.link_monitors and not silent then
		dispatchers.do_workspace(workspace_str)
	end
end

--- ============================================================
--- split-grabroguewindows
--- ============================================================

function dispatchers.do_grab_rogue_windows()
	---@type HL.Monitor|nil
	local current_monitor = helpers.get_current_monitor()
	if not current_monitor then return end
	---@type HL.Workspace|nil
	local current_ws = current_monitor.active_workspace
	if not current_ws then return end

	---@type table<string, boolean>
	local mapped = {}
	for _, ws_list in pairs(globals.monitor_workspace_map) do
		for _, name in ipairs(ws_list) do
			mapped[name] = true
		end
	end

	---@type HL.Window[]
	local windows = hl.get_windows()
	for _, window in ipairs(windows) do
		if not window.mapped then goto continue end
		if not window.workspace then goto continue end
		if window.workspace.special then goto continue end

		if not mapped[window.workspace.name] then
			print(string.format(
				"[split-monitor-workspaces] Moving rogue window '%s' from workspace %s to %s",
				window.title, window.workspace.name, current_ws.name))
			hl.dispatch(hl.dsp.window.move({ workspace = current_ws.name, window = window, follow = false }))
		end

		::continue::
	end
end

return dispatchers
