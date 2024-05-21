return {
	"nvimdev/dashboard-nvim",
	opts = {
		config = {
			center = {
				{
					action = LazyVim.telescope("files"),
					desc = " Find File",
					icon = " ",
					key = "f",
				},
				{
					action = "ene | startinsert",
					desc = " New File",
					icon = " ",
					key = "n",
				},
				{
					action = 'lua require("persistence").load()',
					desc = " Restore Session",
					icon = " ",
					key = "s",
				},
			},
			footer = {},
		},
	},
}
