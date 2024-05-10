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
		local Terminal = require("toggleterm.terminal").Terminal

		args = args or {}
		local cmd = { "lazygit", unpack(args) }

		Terminal:new({ cmd = vim.fn.join(cmd), direction = "float", hidden = true }):toggle()
	end,
}
