local function gitdev_open()
	local repo = vim.fn.input("Repository")

	if repo ~= "" then
		require("git-dev").open(repo)
	end
end

return {
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
