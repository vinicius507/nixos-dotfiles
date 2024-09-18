return {
	"akinsho/bufferline.nvim",
	keys = function()
		return {
			{ "<Leader><Tab>o", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Tabs" },
		}
	end,
	opts = {
		options = {
			mode = "tabs",
		},
	},
}
