local map = LazyVim.safe_keymap_set

local terminal = function()
	LazyVim.terminal()
end

map("n", "<C-/>", terminal, { desc = "Terminal" })

-- Thanks to the primeagen for these gems
-- Better Cursor positioning in search
map("n", "n", "nzzzv", { silent = true })
map("n", "N", "Nzzzv", { silent = true })

-- Better cursor positioning while joining lines
map("n", "J", "mzJ`z", { silent = true })

-- Extra undo breakpoints
map("i", "!", "!<C-g>u", { silent = true })
map("i", "?", "?<C-g>u", { silent = true })
