-- Load our custom globals and options.
require("options")
require("keymaps")

-- Install and initialize lazy.nvim package manager.
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazy_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazy_path,
	})
end

-- Add lazy.nvim to the runtime path.
vim.opt.rtp:prepend(lazy_path)

-- Initialize lazy and load plugins according to their configuration defined
-- in the `plugins` folder.
local lazy = require("lazy")
lazy.setup("plugins", {
	change_detection = { notify = false },
	checker = {
		enabled = true,
		notify = false,
	},
})
