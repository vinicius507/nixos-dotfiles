---@type LazySpec
return {
	{
		"vinicius507/header42.nvim",
		cmd = { "Stdheader" },
		opts = {
			login = "vgoncalv",
			email = "vgoncalv@student.42sp.org.br",
		},
	},
	{
		"mateusbraga/vim-spell-pt-br",
		config = function()
			vim.opt.spelllang:append("pt_br")
		end,
	},
	{
		"folke/flash.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, false },
		},
	},
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			{ import = "lazyvim.plugins.extras.editor.harpoon2" },
		},
		keys = {
			{ "<Leader>h", false },
			{ "<Leader>H", false },
			{
				"<Leader>a",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Harpoon file",
			},
			{
				"<C-e>",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Harpoon Quick Menu",
			},
		},
		---@type HarpoonPartialConfig
		opts = {
			default = {
				display = function(list_item)
					local filename = vim.fn.fnamemodify(list_item.value, ":t")
					local extension = vim.fn.fnamemodify(list_item.value, ":e")
					local icon = require("nvim-web-devicons").get_icon(filename, extension, {
						default = true,
					})
					return string.format("%s %s", icon, list_item.value)
				end,
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		---@diagnostic disable-next-line: assign-type-mismatch
		init = false,
		opts = {
			hijack_netrw_behavior = false,
		},
	},
	{
		"stevearc/oil.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Oil",
		keys = {
			{ "-", vim.cmd.Oil, desc = "Oil.nvim" },
		},
		opts = {
			keymaps = {
				q = "actions.close",
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzy-native.nvim",
				config = function()
					LazyVim.on_load("telescope.nvim", function()
						require("telescope").load_extension("fzy_native")
					end)
				end,
			},
		},
		keys = {
			{
				"<Leader>fp",
				function()
					vim.ui.input(
						{
							prompt = "Path: ",
							completion = "dir",
						},
						---@param path string?
						function(path)
							if path == nil then
								return
							end

							LazyVim.telescope("files", { cwd = path })()
						end
					)
				end,
				desc = "Find in path",
			},
		},
		opts = function(_, opts)
			local dropdown = function()
				return require("telescope.themes").get_dropdown({
					borderchars = {
						{ "─", "│", "─", "│", "┌", "┐", "┘", "└" },
						prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
						results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
						preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					},
					width = 0.8,
					previewer = false,
					prompt_title = false,
				})
			end
			return vim.tbl_deep_extend("force", opts, {
				defaults = {
					prompt_prefix = "   ",
				},
				pickers = {
					buffers = dropdown(),
					find_files = dropdown(),
					git_files = dropdown(),
					oldfiles = dropdown(),
				},
				extensions = {
					fzy_native = {
						override_generic_sorter = false,
						override_file_sorter = true,
					},
				},
			})
		end,
	},
}
