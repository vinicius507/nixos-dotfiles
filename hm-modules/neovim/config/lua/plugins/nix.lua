return {
	{
		"conform.nvim",
		opts = {
			formatters_by_ft = {
				nix = { "alejandra" },
			},
		},
	},
	{
		"nvim-lspconfig",
		opts = {
			servers = {
				nil_ls = {},
			},
		},
	},
}
