--- globals.lua
--- Shared configuration and runtime state for split-monitor-workspaces.
--
--- All other modules require() this file and mutate the tables directly.
--- Because require() caches its result, every module receives the same
--- table references, so mutations are visible everywhere.


---@class SMW.Config
---@field workspace_count integer?
---@field keep_focused boolean?
---@field enable_notifications boolean?
---@field enable_persistent_workspaces boolean?
---@field enable_wrapping boolean?
---@field link_monitors boolean?
---@field monitor_priority string[]?
---@field max_workspaces table<string, integer>?


---@class SMW.PriorityEntry
---@field value integer
---@field from_config boolean

local globals = {}

--- ============================================================
--- Configuration defaults
--- ============================================================

---@type SMW.Config
globals.cfg = {
	workspace_count = 10,
	keep_focused = true,
	enable_notifications = false,
	enable_persistent_workspaces = true,
	enable_wrapping = true,
	link_monitors = false,
	monitor_priority = {},
	max_workspaces = {},
}

--- ============================================================
--- Runtime state
--- ============================================================

---@type table<integer, string[]>
globals.monitor_workspace_map = {}

---@type table<string, SMW.PriorityEntry>
globals.monitor_priorities = {}

---@type table<string, SMW.PriorityEntry>
globals.monitor_max_ws_override = {}

return globals
