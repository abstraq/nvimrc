-- Enables current and relative line numbers.
vim.opt.number = true
vim.opt.relativenumber = true

-- Enables mouse support in all modes.
-- See `:h mouse` for more information.
vim.opt.mouse = "a"

-- Disables showing the current mode as we already have a display for it in
-- the status line.
vim.opt.showmode = false

-- Disable line wrapping.
vim.opt.wrap = false

-- Persists undo history to a file.
vim.opt.undofile = true

-- Disable swap file.
vim.opt.swapfile = false

-- Makes searching case-insensitive unless the query contains mixed casing.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enables the sign column for displaying additional per-line information.
vim.opt.signcolumn = "yes"

-- Specifies the amount of time in milliseconds the cursor can be inactive
-- before CursorHold is triggered and the swap is saved.
vim.opt.updatetime = 250

-- Specifies the amount of time in milliseconds before a keymap sequence
-- times out waiting for the next character.
vim.opt.timeoutlen = 300

-- Makes window splitting feel more natural by opening it to the right or below
-- by default.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Specifies how to display whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "│ ", trail = "·", nbsp = "␣" }

-- Enables substitution previews.
vim.opt.inccommand = "split"

-- Specifies the lower limit of lines to pad the cursor.
vim.opt.scrolloff = 15

-- Enable 24-bit color support.
vim.opt.termguicolors = true

-- Make tabs 4 spaces.
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
