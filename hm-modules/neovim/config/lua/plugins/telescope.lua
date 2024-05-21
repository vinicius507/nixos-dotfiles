return {
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
		local actions = require("telescope.actions")
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
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
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
}
