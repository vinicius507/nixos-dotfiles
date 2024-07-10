local function augroup(name)
	return vim.api.nvim_create_augroup("dotfiles_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	group = augroup("no_autoformat"),
	callback = function()
		vim.b.autoformat = false
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"gitcommit",
		"gitrebase",
		"gitconfig",
	},
	group = augroup("git_editor"),
	command = "set bufhidden=delete",
})
