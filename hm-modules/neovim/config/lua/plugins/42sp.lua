---@type LazySpec
return {
	{
		"vinicius507/header42.nvim",
		cmd = { "Stdheader" },
		ft = { "c", "cpp", "make" },
		opts = {
			login = "vgoncalv",
			email = "vgoncalv@student.42sp.org.br",
		},
	},
	{
		"nvim-lint",
		opts = function(_, opts)
			local bufname = function()
				return vim.api.nvim_buf_get_name(0)
			end
			local bufcontent = function()
				local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
				lines[#lines + 1] = "" -- Add a newline at the end
				return table.concat(lines, "\n")
			end
			local filetype = function()
				local ext = vim.fn.expand("%:e")
				return ext == "h" and "--hfile" or "--cfile"
			end

			---@type lint.Linter
			opts.linters.norminette = {
				cmd = "norminette",
				args = {
					"--filename",
					bufname,
					filetype,
					bufcontent,
				},
				append_fname = false,
				ignore_exitcode = true,
				name = "Norminette",
				stream = "stdout",
				parser = require("lint.parser").from_pattern(
					"(%w+): (.+) +%(line: +(%d+), col: +(%d+)%):\t(.*)",
					{ "severity", "code", "lnum", "col", "message" },
					{
						Notice = vim.diagnostic.severity.WARN,
						Error = vim.diagnostic.severity.ERROR,
					}
				),
			}

			opts.linters_by_ft = {
				c = { "norminette" },
				cpp = { "norminette" },
			}

			return opts
		end,
	},
}
