local arg = "leetcode"

return {
	"kawre/leetcode.nvim",
	cmd = { "Leet" },
	lazy = arg ~= vim.fn.argv(1),
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "html" } },
		},
	},
	opts = {
		arg = arg,
		lang = "python3",
	},
}
