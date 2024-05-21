return {
	{
		"zbirenbaum/copilot.lua",
		lazy = false,
		build = ":Copilot auth",
		enabled = vim.env.DOTFILES_DEV and false,
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
			},
			filetypes = {
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
