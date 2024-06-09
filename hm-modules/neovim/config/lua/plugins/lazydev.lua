return {
	"folke/lazydev.nvim",
	---@type lazydev.Config
	opts = {
		library = {
			{
				path = "catppuccin",
				mods = { "catppuccin" },
				words = { "CatppuccinOptions" },
			},
			{ path = "lazy.nvim", words = { "LazySpec" } },
			{ path = "lazydev.nvim", words = { "lazydev%.Config" } },
			{ path = "trouble.nvim", words = { "trouble%.Config" } },
		},
	},
}
