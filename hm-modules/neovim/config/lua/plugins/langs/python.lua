return {
	{
		"nvim-dap-python",
		config = function()
			require("dap-python").setup("python")
		end,
	},
}
