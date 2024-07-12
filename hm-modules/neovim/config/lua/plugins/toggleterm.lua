local term = require("lib.terminal")

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	dependencies = {
		{ "nvim-lualine/lualine.nvim", opts = { extensions = { "toggleterm" } } },
		{ "folke/which-key.nvim", opts = { spec = { ["<Leader>t"] = "+terminal" } } },
	},
	cmd = { "ToggleTerm", "ToggleTermToggleAll", "TermExec", "TermSelect" },
	keys = {
		{
			"<C-/>",
			[[<cmd>execute v:count . "ToggleTerm dir=git_dir name=workspace"<cr>]],
			desc = "Toggle Terminal",
		},
		{ "<C-/>", [[<esc><cmd>ToggleTerm dir=git_dir name=workspace<cr>]], mode = "i", desc = "Toggle Terminal" },
		{ "<Leader>ft", "<cmd>TermSelect<cr>", desc = "Find Terminal" },
		{ "<Leader>gg", term.lazygit, desc = "Lazygit" },
		{
			"<Leader>gf",
			function()
				local git_path = vim.api.nvim_buf_get_name(0)
				term.lazygit({ "-f", vim.trim(git_path) })
			end,
			desc = "Lazygit Current File History",
		},
		{ "<Leader>tr", "<cmd>ToggleTermSetName<cr>", desc = "Rename Terminal" },
		{ "<Leader>tn", term.new, desc = "New Terminal" },
	},
	opts = {
		open_mapping = false,
		float_opts = {
			border = "single",
		},
	},
}
