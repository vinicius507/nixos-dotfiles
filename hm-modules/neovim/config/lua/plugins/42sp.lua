---@type LazySpec
return {
	{
		"vinicius507/ft_nvim",
		ft = { "c", "cpp", "make" },
		cmd = { "FtHeader", "Norme" },
		keys = {
			{
				"<F2>",
				"<cmd>FtHeader<CR>",
				mode = "n",
				desc = "Inserts/updates 42 header",
				silent = true,
			},
		},
		opts = {
			header = {
				username = "vgoncalv",
				email = "vgoncalv@student.42sp.org.br",
			},
			norminette = {
				enabled = true,
			},
		},
	},
}
