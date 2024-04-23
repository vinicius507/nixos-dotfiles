-- Thanks to the primeagen for these gems
-- Better Cursor positioning in search
vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })

-- Better cursor positioning while joining lines
vim.keymap.set("n", "J", "mzJ`z", { silent = true })

-- Extra undo breakpoints
vim.keymap.set("i", "!", "!<C-g>u", { silent = true })
vim.keymap.set("i", "?", "?<C-g>u", { silent = true })
