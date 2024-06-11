---@type fun(extra: string): LazySpec
local lazyextra = function(extra)
	return { import = "lazyvim.plugins.extras." .. extra }
end

local extra_modules = {
	"coding.copilot",
	"coding.mini-surround",
	"dap.core",
	"editor.harpoon2",
	"editor.refactoring",
	"formatting.prettier",
	"lang.clangd",
	"lang.docker",
	"lang.go",
	"lang.json",
	"lang.markdown",
	"lang.rust",
	"lang.tailwind",
	"lang.typescript",
	"lang.yaml",
	"linting.eslint",
	"ui.treesitter-context",
	"vscode",
}

return vim.tbl_map(lazyextra, extra_modules)
