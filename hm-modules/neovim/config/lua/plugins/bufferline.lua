return {
	"akinsho/bufferline.nvim",
	keys = function()
		return {
			{ "<leader><Tab>o", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Tabs" },
		}
	end,
	opts = {
		options = {
			mode = "tabs",
		},
	},
}
