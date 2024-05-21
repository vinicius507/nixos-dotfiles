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
		---@type CatppuccinOptions
		opts = {
			background = {
				dark = "mocha",
				light = "macchiato",
			},
			term_colors = vim.g.neovide,
			transparent_background = not vim.g.neovide,
		},
	},
}
