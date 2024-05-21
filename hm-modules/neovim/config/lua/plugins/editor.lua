---@type LazySpec
return {
	"direnv/direnv.vim",
	{
		"mateusbraga/vim-spell-pt-br",
		config = function()
			vim.opt.spelllang:append("pt_br")
		end,
	},
	{
		"folke/flash.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, false },
		},
		opts = {
			modes = {
				search = {
					enabled = true,
				},
			},
		},
	},
	{
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
			},
		},
	},
}
