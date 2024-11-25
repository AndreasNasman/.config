local M = {}

---@param lhs string
---@param rhs string|function
---@param mode? string|string[]|nil
---@param buffer? integer|boolean
function M.map(lhs, rhs, mode, buffer)
    vim.keymap.set(mode or 'n', lhs, rhs, buffer and { buffer = buffer } or {})
end

---@param property string
---@param state boolean
function M.notify_toggle(property, state)
    vim.notify(string.format('Toggling %s %s', property, state and 'on' or 'off'), vim.log.levels.INFO)
end

return M
