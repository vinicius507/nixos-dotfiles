return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = { "windwp/nvim-ts-autotag" },
		opts = {
			auto_install = true,
			autotag = {
				enable = true,
			},
			ensure_installed = {
				"doxygen",
				"nix",
			},
		},
	},
	{ import = "lazyvim.plugins.extras.ui.treesitter-context" },
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			max_lines = 5,
		},
	},
}
