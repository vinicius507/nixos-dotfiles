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
			rules = {
				{ pattern = "block", icon = "", color = "blue" },
				{ pattern = "function", icon = "󰊕", color = "blue" },
				{ pattern = "hunks", cat = "filetype", name = "git" },
				{ pattern = "keywordprg", cat = "filetype", name = "man" },
				{ pattern = "refactor", icon = " ", color = "orange" },
				{ pattern = "surround", icon = "󰅪", color = "orange" },
				{ pattern = "variable", icon = "", color = "green" },
				{ plugin = "flash.nvim", icon = "", color = "yellow" },
				{ plugin = "mini.surround", icon = "󰅪", color = "orange" },
				{ plugin = "neogen", icon = "󰈔", color = "cyan" },
				{ plugin = "nvim-dap", icon = "󰃤 ", color = "red" },
				{ plugin = "nvim-dap-ui", icon = "󰃤 ", color = "red" },
			},
		},
	},
}
