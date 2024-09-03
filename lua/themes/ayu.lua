-- Ayu Color Scheme
-- See https://github.com/Shatur/neovim-ayu for more information.
return {
	"Shatur/neovim-ayu",
	priority = 1000,
	config = function()
		local ayu = require("ayu")
		ayu.setup({ mirage = true })
		ayu.colorscheme()
	end
}
