return {
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
}
