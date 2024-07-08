---@param config table?
local function dropdown_picker(config)
	local dropdown = require("telescope.themes").get_dropdown({
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
	return vim.tbl_deep_extend("force", dropdown, config or {})
end

local function pick_path()
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

			LazyVim.pick("files", { cwd = path, hidden = true })()
		end
	)
end

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
		{ "<Leader>fb", false },
		{ "<Leader><Space>", false },
		{ "<Leader>bb", LazyVim.pick("buffers"), desc = "Find buffer" },
		{ "<Leader>fp", pick_path, desc = "Find in path" },
	},
	opts = function(_, opts)
		local actions = require("telescope.actions")

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
				buffers = dropdown_picker(),
				find_files = dropdown_picker(),
				git_files = dropdown_picker({ show_untracked = true }),
				oldfiles = dropdown_picker(),
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
