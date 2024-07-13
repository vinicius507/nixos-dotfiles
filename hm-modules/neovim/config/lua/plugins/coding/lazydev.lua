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
			{ path = "LazyVim", words = { "LazyVim" } },
			{ path = "lazy.nvim", words = { "LazySpec" } },
			{ path = "lazydev.nvim", words = { "lazydev%.Config" } },
			{ path = "luvit-meta/library", words = { "vim%.uv" } },
			{ path = "trouble.nvim", words = { "trouble%.Config" } },
			{ path = "which-key.nvim", words = { "wk%.Config" } },
		},
	},
}
