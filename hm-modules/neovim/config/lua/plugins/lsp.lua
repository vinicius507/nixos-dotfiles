return {
	"antosha417/nvim-lsp-file-operations",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function(_, opts)
		require("lsp-file-operations").setup(opts)
	end,
}
