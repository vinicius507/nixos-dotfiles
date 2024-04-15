return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin",
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		build = ":CatppuccinCompile",
		opts = {
			flavour = "mocha",
			term_colors = vim.g.neovide,
		},
	},
}
