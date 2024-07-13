return {
	{
		"zbirenbaum/copilot.lua",
		lazy = false,
		cmd = "Copilot",
		build = ":Copilot auth",
		enabled = vim.env.DOTFILES_DEV and false,
		opts = {
			panel = { enabled = false },
			suggestion = {
				enabled = true,
				auto_trigger = true,
			},
			filetypes = {
				help = true,
				markdown = true,
				sh = function()
					local is_env_file = string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*")
					if is_env_file then
						return false
					end
					return true
				end,
			},
		},
	},
}
