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

local augroup_code_action_on_save = augroup("code_action_on_save")
local code_actions_by_ft = {
	python = { "source.organizeImports" },
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = vim.tbl_keys(code_actions_by_ft),
	group = augroup_code_action_on_save,
	callback = function(ev)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = ev.buf,
			callback = function()
				local filetype = vim.api.nvim_get_option_value("filetype", { buf = ev.buf })

				vim.lsp.buf.code_action({
					apply = true,
					---@diagnostic disable-next-line: missing-fields
					context = { only = code_actions_by_ft[filetype] },
				})
			end,
		})
	end,
})
