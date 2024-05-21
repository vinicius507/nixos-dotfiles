---@type LazySpec
return {
	{ import = "lazyvim.plugins.extras.editor.trouble-v3" },
	{
		"folke/trouble.nvim",
		---@type trouble.Config
		opts = {
			focus = true,
		},
	},
}
