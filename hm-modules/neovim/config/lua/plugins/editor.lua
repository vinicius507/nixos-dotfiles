---@type LazySpec
return {
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
		import = "lazyvim.plugins.extras.editor.harpoon2",
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

							require("telescope.builtin").find_files({
								cwd = path,
							})
						end
					)
				end,
				desc = "Find in path",
			},
		},
		opts = {
			extensions = {
				fzy_native = {
					override_generic_sorter = false,
					override_file_sorter = true,
				},
			},
		},
	},
}
