local map = LazyVim.safe_keymap_set

-- Removes default terminal bindings
vim.keymap.del("n", "<C-_>")
vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")
vim.keymap.del("n", "<leader>gG")

-- Thanks to the primeagen for these gems
-- Better Cursor positioning in search
map("n", "n", "nzzzv", { silent = true })
map("n", "N", "Nzzzv", { silent = true })

-- Better cursor positioning while joining lines
map("n", "J", "mzJ`z", { silent = true })

-- Extra undo breakpoints
map("i", "!", "!<C-g>u", { silent = true })
map("i", "?", "?<C-g>u", { silent = true })
