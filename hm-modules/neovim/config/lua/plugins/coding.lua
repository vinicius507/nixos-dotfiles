---@type LazySpec
return {
	{
		"zbirenbaum/copilot.lua",
		lazy = false,
		build = ":Copilot auth",
		enabled = vim.env.DOTFILES_DEV and false,
		dependencies = {
			{ import = "lazyvim.plugins.extras.coding.copilot" },
		},
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
			},
			filetypes = {
				sh = function()
					local is_env_file = string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*")
					if is_env_file then
						return false
					end
					return true
				end,
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"f3fora/cmp-spell",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-emoji",
			"onsails/lspkind.nvim",
		},
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			local cmp = require("cmp")

			opts.sources = vim.list_extend(opts.sources, {
				{ name = "calc" },
				{ name = "emoji" },
				{
					name = "spell",
					option = {
						keep_all_entries = false,
						enable_in_context = function()
							return require("cmp.config.context").in_treesitter_capture("spell")
						end,
					},
				},
			})
			opts.formatting.fields = { cmp.ItemField.Kind, cmp.ItemField.Abbr, cmp.ItemField.Menu }
			opts.formatting.format = require("lspkind").cmp_format({
				mode = "symbol",
				maxwidth = 50,
				symbol_map = {
					Calc = "󰃬",
				},
				---@param entry cmp.Entry
				---@param vim_item vim.CompletedItem
				before = function(entry, vim_item)
					if entry.source.name == "calc" then
						vim_item.kind = "Calc"
					end
					return vim_item
				end,
			})
			opts.view = {
				entries = {
					name = "custom",
					selection_order = "near_cursor",
				},
			}
			opts.window = {
				completion = cmp.config.window.bordered({ border = "single" }),
				documentation = cmp.config.window.bordered({ border = "single" }),
			}
			opts.experimental.ghost_text = false
			opts.mapping = cmp.mapping.preset.insert({
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<S-CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				["<C-CR>"] = function(fallback)
					cmp.abort()
					fallback()
				end,
			})
		end,
	},
	{
		"echasnovski/mini.surround",
		opts = {
			mappings = {
				add = "gsa",
				delete = "gsd",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				replace = "gsr",
				update_n_lines = "gsn",
			},
		},
	},
}
