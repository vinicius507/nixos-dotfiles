return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = { "windwp/nvim-ts-autotag" },
	---@type TSConfig
	opts = {
		autotag = {
			enable = true,
		},
		highlight = {
			enable = true,
		},
		ensure_installed = { "nix" },
	},
}
