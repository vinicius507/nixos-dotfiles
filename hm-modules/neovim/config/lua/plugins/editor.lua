---@type LazySpec[]
return {
	{
		"stevearc/oil.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Oil",
		keys = {
			{ "<Leader>e", vim.cmd.Oil, desc = "Oil.nvim" },
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
