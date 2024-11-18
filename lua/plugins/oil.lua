-- Edit filesystem as a buffer.
-- See https://github.com/stevearc/oil.nvim for more information.
return {
	"stevearc/oil.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		experimental_watch_for_changes = true,
		view_options = {
			show_hidden = true,
			-- sort = function(source, target)
			-- 	-- If the source is mod.rs then return true as it should go first.
			-- 	if vim.fs.basename(source) == "mod.rs" then return true end
			-- 	-- If the target is mod.rs then return false as nothing should go before it.
			-- 	if vim.fs.basename(target) == "mod.rs" then return false end
			--
			-- 	-- Implementation of default sorting for all other files.
			-- 	local source_is_dir = vim.fn.isdirectory(source) == 1
			-- 	local target_is_dir = vim.fn.isdirectory(target) == 1
			--
			-- 	if source_is_dir ~= target_is_dir then
			-- 		return source_is_dir
			-- 	end
			--
			-- 	return source < target
			-- end
		},
		float = { padding = 8 },
	},
	keys = {
		{
			"-",
			function()
				local oil = require("oil")
				oil.open()
			end,
			{ desc = "Opens the file browser for the parent directory." }
		}
	}
}
