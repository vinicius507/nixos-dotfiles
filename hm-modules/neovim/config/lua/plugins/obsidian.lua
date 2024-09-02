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
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/vaults/personal",
			},
		},
	},
}
