local opt = vim.opt

opt.hidden = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false

opt.undodir:append(vim.fn.stdpath("cache") .. "undo")

opt.scrolloff = 8

opt.list = true
opt.listchars = {
	eol = " ",
	tab = " ",
	space = " ",
	nbsp = " ",
	trail = "~",
}
opt.shortmess:append({ s = true })

vim.g.lazyvim_python_ruff = "ruff"

-- Neovide Options
vim.g.neovide_transparency = 0.8
