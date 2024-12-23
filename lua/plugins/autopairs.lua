-- Automatically add the closing character for a pair.
-- See https://github.com/windwp/nvim-autopairs for more information.
return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true
		}
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
	}
}
