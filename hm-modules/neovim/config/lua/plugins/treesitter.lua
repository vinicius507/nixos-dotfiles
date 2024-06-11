---@type LazySpec
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
		{
			"nvim-treesitter/nvim-treesitter-context",
			opts = {
				max_lines = 5,
			},
		},
	},
	opts = {
		auto_install = true,
		autotag = {
			enable = true,
		},
		ensure_installed = {
			"doxygen",
		},
	},
}
