local transparent_background = true

if vim.g.neovide then
	transparent_background = false
end

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
			transparent_background = transparent_background,
		},
	},
}
