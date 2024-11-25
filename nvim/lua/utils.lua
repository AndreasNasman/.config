local M = {}

---@param lhs string
---@param rhs string|function
---@param mode string|string[]|nil
---@param buffer integer|boolean
function M.map(lhs, rhs, mode, buffer)
    mode = mode or 'n'
    vim.keymap.set(mode, lhs, rhs, { buffer = buffer })
end

---@param property string
---@param state boolean
function M.notify_toggle(property, state)
    vim.notify(string.format('Toggling %s %s', property, state and 'on' or 'off'), vim.log.levels.INFO)
end

return M
