---@type LazySpec
return {
	{
		"akinsho/bufferline.nvim",
		keys = function()
			return {
				{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
			}
		end,
		opts = {
			options = {
				mode = "tabs",
			},
		},
	},
	{
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
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			return vim.tbl_deep_extend("force", opts, {
				options = { section_separators = "", component_separators = "" },
				sections = {
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
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
