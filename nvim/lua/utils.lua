local M = {}

---@param property string
---@param state boolean
function M.notify_toggle(property, state)
    vim.notify(string.format('Toggling %s %s', property, state and 'on' or 'off'), vim.log.levels.INFO)
end

return M
