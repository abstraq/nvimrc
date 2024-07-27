-- nvim-treesitter
-- Handles syntax highlighting for Neovim.
--
-- See https://github.com/nvim-treesitter/nvim-treesitter for more
-- information.
local function config_treesitter()
	local treesitter = require("nvim-treesitter.configs")
	local languages = {
		"vim",
		"vimdoc",
		"lua",
		"rust",
		"c",
		"toml",
		"json",
		"markdown",
		"wgsl",
	}

	treesitter.setup({
		ensure_installed = languages,
		highlight = { enable = true },
		indent = { enable = true },
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = config_treesitter,
}
