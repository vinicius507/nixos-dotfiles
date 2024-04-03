return {
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			opts.presets.lsp_doc_border = true
			opts.routes = vim.list_extend(opts.routes, {
				{
					filter = {
						cmdline = true,
						event = "msg_show",
						cleared = true,
						["not"] = {
							kind = "",
						},
					},
					view = "cmdline_output",
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
		end,
	},
}
