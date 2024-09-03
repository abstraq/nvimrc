-- Boostrap lazy.nvim plugin manager.
-- See https://github.com/folke/lazy.nvim for more information.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

-- Load keymaps and options.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("options")

-- Load and initialize plugins.
local lazy = require("lazy")
lazy.setup({
	spec = {
		{ import = "plugins" },
		{ import = "themes" }
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	}
})