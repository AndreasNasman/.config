-- https://github.com/nvim-treesitter/nvim-treesitter#modules
local disable = function(_, buf)
  local max_filesize = 100 * 1024 -- 100 KB
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stats and stats.size > max_filesize then
    return true
  end
end

return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    highlight = {
      disable = disable,
    },
    indent = {
      disable = disable,
    },
  },
}
