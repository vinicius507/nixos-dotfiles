return {
	"nvim-lualine/lualine.nvim",
	opts = function(_, opts)
		return vim.tbl_deep_extend("force", opts, {
			options = { section_separators = "", component_separators = "" },
			sections = {
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
