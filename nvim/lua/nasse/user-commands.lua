vim.api.nvim_create_user_command("ReloadConfig", function()
	return require("nasse.custom.reload-config").reloadConfig()
end, {})

-- Case-insensitive versions of common commands.
vim.api.nvim_create_user_command("Q", "quit", {})
vim.api.nvim_create_user_command("QA", "qall", {})
vim.api.nvim_create_user_command("Qa", "qall", {})
vim.api.nvim_create_user_command("W", "write", {})
vim.api.nvim_create_user_command("WA", "wall", {})
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wa", "wall", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
