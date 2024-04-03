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
			transparent_background = true,
		},
	},
}