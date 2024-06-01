---@type LazySpec
return {
	"direnv/direnv.vim",
	{
		"mateusbraga/vim-spell-pt-br",
		config = function()
			vim.opt.spelllang:append("pt_br")
		end,
	},
}
