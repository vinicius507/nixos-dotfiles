return {
	{
		"conform.nvim",
		opts = {
			formatters = {
				injected = {
					options = {
						lang_to_formatters = {
							python = { "black" },
						},
					},
				},
			},
		},
	},
	{
		"markdown.nvim",
		opts = {
			code = {
				min_width = 40,
			},
			heading = {
				sign = true,
				width = "block",
				icons = { "󰉫", "󰉬", "󰉭", "󰉮", "󰉯", "󰉰" },
				right_pad = 1,
				position = "inline",
			},
		},
	},
}
