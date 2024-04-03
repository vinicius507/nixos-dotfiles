---@type LazySpec[]
return {
	{
		"L3MON4D3/LuaSnip",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-emoji",
			"onsails/lspkind.nvim",
		},
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			local cmp = require("cmp")

			opts.sources = cmp.config.sources(vim.list_extend(
				vim.tbl_filter(function(v)
					return not vim.tbl_contains({ "copilot" }, v.name)
				end, opts.sources),
				{ { name = "emoji" } },
				0,
				#opts.sources - 1
			))
			opts.formatting.fields = {
				cmp.ItemField.Kind,
				cmp.ItemField.Abbr,
				cmp.ItemField.Menu,
			}
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
			opts.formatting.format = require("lspkind").cmp_format({
				mode = "symbol",
				maxwidth = 50,
			})
			opts.view = {
				entries = {
					name = "custom",
					selection_order = "near_cursor",
				},
			}
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
	{
		"copilot.lua",
		lazy = false,
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
}
