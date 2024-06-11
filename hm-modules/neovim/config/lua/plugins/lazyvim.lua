---@type fun(extra: string): LazySpec
local lazyextra = function(extra)
	return { import = "lazyvim.plugins.extras." .. extra }
end

local extra_modules = {
	"coding.copilot",
	"coding.mini-surround",
	"coding.neogen",
	"dap.core",
	"editor.harpoon2",
	"editor.refactoring",
	"formatting.prettier",
	"lang.astro",
	"lang.clangd",
	"lang.docker",
	"lang.git",
	"lang.gleam",
	"lang.go",
	"lang.json",
	"lang.markdown",
	"lang.rust",
	"lang.sql",
	"lang.svelte",
	"lang.tailwind",
	"lang.toml",
	"lang.typescript",
	"lang.yaml",
	"linting.eslint",
	"ui.treesitter-context",
	"vscode",
}

return vim.tbl_map(lazyextra, extra_modules)
