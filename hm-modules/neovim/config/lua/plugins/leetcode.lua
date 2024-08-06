local arg = "leet"

return {
	"kawre/leetcode.nvim",
	cmd = { "Leet" },
	lazy = arg ~= vim.fn.argv(1),
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-treesitter/nvim-treesitter",
	},
	---@type lc.UserConfig
	opts = {
		arg = arg,
		lang = "python3",
		injector = {
			python3 = {
				before = true,
				after = [[
					if __name__ == "__main__":
						pass
				]],
			},
		},
	},
}
