-- nvim-tree [File Explorer]
--
-- See https://github.com/nvim-tree/nvim-tree.lua for more information.
return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"<leader>te",
			"<cmd>NvimTreeToggle<CR>",
		},
	},
	opts = {
		-- Keep the cursor on the first letter of the file name.
		hijack_cursor = true,

		-- Makes the cwd of nvim-tree the cwd of the buffer.
		respect_buf_cwd = true,

		-- Use dressing.nvim prompts.
		select_prompts = true,

		sort = {
			-- Place folders above files when sorting.
			folders_first = true,
		},
	},
}
