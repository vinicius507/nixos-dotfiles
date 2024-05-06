return {
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
}
