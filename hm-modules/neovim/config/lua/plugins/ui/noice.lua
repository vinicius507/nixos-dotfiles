---@type LazySpec
return {
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			opts.presets.long_message_to_split = true
			opts.routes = vim.list_extend(opts.routes, {
				{
					filter = {
						cmdline = true,
						event = "msg_show",
						["not"] = {
							kind = "emsg",
						},
					},
					view = "cmdline_output",
				},
				{
					filter = {
						find = "Mason",
						warning = true,
					},
					opts = { skip = true },
				},
			})
			opts.views = { cmdline_output = { enter = true } }
			opts.commands = {
				all = {
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}
			return opts
		end,
	},
}
