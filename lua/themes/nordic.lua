-- Nord inspired color scheme
-- See https://github.com/AlexvZyl/nordic.nvim for more information.
return {
	"AlexvZyl/nordic.nvim",
	priority = 1000,
	enabled = false,
	config = function()
		local nordic = require("nordic")
		nordic.load()
	end
}
