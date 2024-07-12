---@type LazySpec
return {
	{
		"vinicius507/ft_nvim",
		ft = { "c", "cpp" },
		opts = {
			norminette = {
				enabled = true,
			},
		},
	},
	{
		"vinicius507/header42.nvim",
		cmd = { "Stdheader" },
		ft = { "c", "cpp", "make" },
		opts = {
			login = "vgoncalv",
			email = "vgoncalv@student.42sp.org.br",
		},
	},
}
