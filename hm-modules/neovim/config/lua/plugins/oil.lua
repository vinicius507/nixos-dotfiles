return {
	"stevearc/oil.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Oil",
	keys = {
		{ "-", vim.cmd.Oil, desc = "Oil.nvim" },
		{
			"<Leader>-",
			function()
				vim.cmd.Oil(vim.fn.getcwd())
			end,
			desc = "Oil.nvim (cwd)",
		},
	},
	opts = {
		keymaps = {
			q = "actions.close",
			["<C-l>"] = false,
			["<C-s>"] = "actions.select_split",
			["<C-v>"] = "actions.select_vsplit",
		},
	},
}
