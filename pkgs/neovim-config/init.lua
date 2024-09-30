if vim.env.DOTFILES_DEV then
	local stdpath = "/tmp/nvim-dev"

	for _, name in ipairs({ "config", "data", "state", "cache" }) do
		vim.env[("XDG_%s_HOME"):format(name:upper())] = stdpath .. "/" .. name
	end
end

vim.env.GIT_EDITOR = "nvr --remote-wait-silent"

require("config.lazy")
