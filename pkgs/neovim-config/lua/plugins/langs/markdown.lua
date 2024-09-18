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
				width = "full",
			},
			heading = {
				sign = true,
				width = "block",
				icons = { "󰉫", "󰉬", "󰉭", "󰉮", "󰉯", "󰉰" },
				position = "inline",
			},
		},
	},
}
