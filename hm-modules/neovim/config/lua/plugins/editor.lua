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
			{
				"<Leader><Leader>",
				function()
					require("flash").jump()
				end,
				mode = { "n", "x", "o" },
				desc = "Flash",
			},
		},
		opts = {
			modes = {
				search = {
					enabled = true,
				},
			},
		},
	},
}
