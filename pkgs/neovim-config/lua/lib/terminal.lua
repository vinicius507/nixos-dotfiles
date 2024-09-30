return {
	new = function()
		local Terminal = require("toggleterm.terminal").Terminal

		vim.ui.input({ prompt = "New terminal" }, function(name)
			if name == nil then
				return
			end
			Terminal:new({ display_name = name }):toggle()
		end)
	end,
	lazygit = function(args)
		local cmd = string.format("fish -ic 'lazygit %s'; exit", vim.fn.join(args or {}))
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = cmd,
			direction = "float",
			hidden = true,
		})

		lazygit:toggle()
	end,
}
