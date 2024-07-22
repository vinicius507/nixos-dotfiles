return {
	"catppuccin/nvim",
	name = "catppuccin",
	build = ":CatppuccinCompile",
	---@type CatppuccinOptions
	opts = {
		flavour = "mocha",
		term_colors = vim.g.neovide,
		transparent_background = not vim.g.neovide,
		color_overrides = {
			mocha = {
				base = "#161617",
				mantle = "#131314",
				crust = "#0f0f0f",
				surface0 = "#27272a",
				surface1 = "#353539",
				surface2 = "#3e3e43",
				text = "#ffffff",
			},
		},
	},
}
