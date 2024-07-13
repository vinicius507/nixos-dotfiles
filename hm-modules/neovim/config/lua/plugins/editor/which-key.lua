---@type wk.IconRule[]
local icon_rules = {
	{ pattern = "block", icon = "", color = "blue" },
	{ pattern = "breakpoint condition", icon = "", color = "red" },
	{ pattern = "command", icon = "", color = "green" },
	{ pattern = "continue", icon = "", color = "yellow" },
	{ pattern = "down", icon = "", color = "red" },
	{ pattern = "eval", icon = "", "green" },
	{ pattern = "function", icon = "󰊕", color = "blue" },
	{ pattern = "grep", icon = "", color = "green" },
	{ pattern = "inspect", icon = "", color = "cyan" },
	{ pattern = "jumplist", icon = "", color = "cyan" },
	{ pattern = "key maps", icon = "", color = "orange" },
	{ pattern = "keywordprg", icon = "󰈔", color = "cyan" },
	{ pattern = "left", icon = "", color = "red" },
	{ pattern = "line", icon = "", color = "green" },
	{ pattern = "location list", icon = "", color = "cyan" },
	{ pattern = "option", icon = "", color = "yellow" },
	{ pattern = "pause", icon = "", color = "blue" },
	{ pattern = "recent", icon = "", color = "yellow" },
	{ pattern = "refactor", icon = " ", color = "orange" },
	{ pattern = "register", icon = "", color = "green" },
	{ pattern = "resume", icon = "", color = "yellow" },
	{ pattern = "right", icon = "", color = "red" },
	{ pattern = "run", icon = "", color = "green" },
	{ pattern = "step into", icon = "", color = "red" },
	{ pattern = "step out", icon = "", color = "red" },
	{ pattern = "step over", icon = "", color = "red" },
	{ pattern = "symbol", icon = "", color = "green" },
	{ pattern = "terminate", icon = "󰈆", color = "red" },
	{ pattern = "up", icon = "", color = "red" },
	{ pattern = "variable", icon = "", color = "green" },
	{ pattern = "widget", icon = "󰜬", color = "red" },
	{ pattern = "word", icon = "", color = "green" },
	{ plugin = "flash.nvim", pattern = "flash", icon = "", color = "yellow" },
	{ plugin = "gitsigns.nvim", pattern = "hunk", cat = "filetype", name = "git" },
	{ plugin = "gitsigns.nvim", pattern = "status", cat = "filetype", name = "git" },
	{ plugin = "neogen", pattern = "neogen", icon = "󰈔", color = "cyan" },
	{ plugin = "oil.nvim", pattern = "oil", icon = "", color = "blue" },
	{ plugin = "telescope.nvim", pattern = "commits", cat = "filetype", name = "git" },
	{ plugin = "trouble.nvim", pattern = "trouble", cat = "filetype", name = "trouble" },
}

---@type LazySpec
return {
	"which-key.nvim",
	---@type wk.Config
	opts = {
		preset = "modern",
		spec = {
			mode = { "n" },
			{ "<Leader>t", group = "terminal" },
		},
		icons = {
			rules = icon_rules,
		},
	},
}
