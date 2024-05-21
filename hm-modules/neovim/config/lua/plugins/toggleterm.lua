return {
	"akinsho/toggleterm.nvim",
	version = "*",
	dependencies = {
		{ "nvim-lualine/lualine.nvim", opts = { extensions = { "toggleterm" } } },
		{ "folke/which-key.nvim", opts = { defaults = { ["<leader>t"] = "+terminal" } } },
	},
	cmd = { "ToggleTerm", "ToggleTermToggleAll", "TermExec", "TermSelect" },
	keys = {
		{
			"<C-/>",
			[[<cmd>execute v:count . "ToggleTerm dir=git_dir name=workspace"<cr>]],
			desc = "Toggle Terminal",
		},
		{ "<C-/>", [[<esc><cmd>ToggleTerm dir=git_dir name=workspace<cr>]], mode = "i", desc = "Toggle Terminal" },
		{ "<leader>ft", "<cmd>TermSelect<cr>", desc = "Find Terminal" },
		{ "<leader>gg", require("lib.terminal").lazygit, desc = "Lazygit" },
		{
			"<leader>gf",
			function()
				local git_path = vim.api.nvim_buf_get_name(0)
				require("lib.terminal").lazygit({ "-f", vim.trim(git_path) })
			end,
			desc = "Lazygit Current File History",
		},
		{ "<leader>tr", "<cmd>ToggleTermSetName<cr>", desc = "Rename Terminal" },
		{ "<leader>tn", require("lib.terminal").new, desc = "New Terminal" },
	},
	opts = {
		open_mapping = false,
		float_opts = {
			border = "single",
		},
	},
}
