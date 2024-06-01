return {
	"ThePrimeagen/harpoon",
	keys = {
		{ "<Leader>h", false },
		{ "<Leader>H", false },
		{
			"<Leader>a",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Harpoon file",
		},
		{
			"<C-e>",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "Harpoon Quick Menu",
		},
	},
	---@type HarpoonPartialConfig
	opts = {
		default = {
			display = function(list_item)
				local filename = vim.fn.fnamemodify(list_item.value, ":t")
				local extension = vim.fn.fnamemodify(list_item.value, ":e")
				local icon = require("nvim-web-devicons").get_icon(filename, extension, {
					default = true,
				})
				return string.format("%s %s", icon, list_item.value)
			end,
		},
	},
}
