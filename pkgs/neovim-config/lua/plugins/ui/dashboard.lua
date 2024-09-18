return {
	"nvimdev/dashboard-nvim",
	opts = {
		config = {
			center = {
				{
					action = LazyVim.pick("files"),
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
					action = function()
						vim.ui.input({
							prompt = "Open Folder",
							completion = "dir",
						}, function(path)
							if path == nil then
								return
							end
							vim.cmd.cd(path)
							vim.cmd.Oil({ args = { path } })
						end)
					end,
					desc = " Open folder",
					icon = "󰉋 ",
					key = "o",
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
