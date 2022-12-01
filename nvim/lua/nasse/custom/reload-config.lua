-- https://neovim.discourse.group/t/reload-init-lua-and-all-require-d-scripts/971/11
local function reloadConfig()
	for name, _ in pairs(package.loaded) do
		if name:match("^nasse") then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
end

return {
	reloadConfig = reloadConfig,
}
