local function gitdev_open()
	local repo = vim.fn.input("Repository")

	if repo ~= "" then
		require("git-dev").open(repo)
	end
end

return {
	{
		"tpope/vim-fugitive",
		cmd = { "Git" },
		ft = { "gitcommit", "gitrebase", "gitconfig" },
		config = function()
			vim.api.nvim_create_autocmd({ "FileType" }, {
				group = vim.api.nvim_create_augroup("fugitive_close_with_q", { clear = true }),
				pattern = { "fugitive" },
				callback = function(ev)
					vim.bo[ev.buf].buflisted = false
					vim.keymap.set("n", "q", "<cmd>close<CR>", {
						buffer = ev.buf,
						silent = true,
						desc = "Quit buffer",
					})
				end,
			})
		end,
	},
	{
		"moyiz/git-dev.nvim",
		cmd = { "GitDevOpen", "GitDevToggleUI", "GitDevRecents", "GitDevCleanAll" },
		keys = {
			{ "<leader>go", gitdev_open, desc = "Open a remote git repository" },
		},
		opts = {
			cd_type = "tab",
			opener = function(dir, _, selected_path)
				vim.cmd.tabnew()
				vim.cmd.Oil(dir)
				if selected_path then
					vim.cmd("edit " .. selected_path)
				end
			end,
		},
	},
}
