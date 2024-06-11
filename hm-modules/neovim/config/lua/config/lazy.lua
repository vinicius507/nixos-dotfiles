if vim.env.DOTFILES_DEV then
	local stdpath = "/tmp/nvim-dev"

	for _, name in ipairs({ "config", "data", "state", "cache" }) do
		vim.env[("XDG_%s_HOME"):format(name:upper())] = stdpath .. "/" .. name
	end
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
	spec = {
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
		{ import = "plugins" },
	},
	lazy_nvim = {
		performance = {
			rtp = {
				reset = false,
				disabled_plugins = {
					"gzip",
					"matchit",
					"matchparen",
					"netrwPlugin",
					"tarPlugin",
					"tohtml",
					"tutor",
					"zipPlugin",
				},
			},
			reset_packpath = false,
		},
	},
})
