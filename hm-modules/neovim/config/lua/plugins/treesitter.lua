return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = { "windwp/nvim-ts-autotag" },
	opts = {
		autotag = {
			enable = true,
		},
		highlight = {
			enable = true,
		},
		ensure_installed = {
			"doxygen",
			"nix",
		},
	},
}
