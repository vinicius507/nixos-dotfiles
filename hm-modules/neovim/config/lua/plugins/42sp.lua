---@type LazySpec
return {
	{
		"vinicius507/ft_nvim",
		cmd = { "FtHeader", "Norme" },
		ft = { "c", "cpp" },
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
