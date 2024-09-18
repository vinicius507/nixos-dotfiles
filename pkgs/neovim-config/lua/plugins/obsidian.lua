---@type fun(length: number): string
local function random_chars(length)
	local result = ""
	for _ = 1, length do
		result = result .. string.char(math.random(65, 90))
	end
	return result
end

---@type fun(title: string): string
local function zettelkasten_id(title)
	local prefix = tostring(os.time()) .. "-"

	if title == nil then
		return prefix .. random_chars(4)
	end
	return prefix .. title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
end

return {
	"epwalsh/obsidian.nvim",
	cmd = {
		"ObsidianNew",
		"ObsidianOpen",
		"ObsidianQuickSwitch",
		"ObsidianSearch",
	},
	event = {
		"BufReadPre ~/Documents/vaults/**/*.md",
		"BufNewFile ~/Documents/vaults/**/*.md",
	},
	keys = {
		{ "<leader>fo", "<cmd>ObsidianQuickSwitch<CR>", desc = "Find Obsidian Note" },
		{ "<leader>oN", "<cmd>ObsidianNewFromTemplate<CR>", desc = "New Note From Template" },
		{ "<leader>oT", "<cmd>ObsidianTags<CR>", desc = "Tags" },
		{ "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New Note" },
		{ "<leader>op", "<cmd>ObsidianOpen<CR>", desc = "Preview" },
		{ "<leader>or", "<cmd>ObsidianRename<CR>", desc = "Rename Note" },
		{ "<leader>so", "<cmd>ObsidianSearch<CR>", desc = "Search in Obsidian Notes" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		ui = { enable = false },
		templates = { folder = "templates" },
		note_id_func = zettelkasten_id,
		notes_subdir = "notes",
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/vaults/personal",
			},
		},
	},
}
