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
			local norme_toggle = function()
				local enabled = true
				vim.w.norme_enabled = true

				vim.api.nvim_create_user_command("NormeToggle", function()
					enabled = not enabled
					vim.diagnostic.reset()
					vim.notify(string.format("%s Norme Diagnostics", enabled and "Enabled" or "Disabled"))
				end, { desc = "Toggle Norme Diagnostics" })

				---@type fun(ctx: {filename: string, dirname: string}): boolean
				return function(ctx)
					return enabled and vim.w.norme_enabled and ctx.dirname:find("42sp") ~= nil
				end
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
					"(%w+): ([^%s]+) +%(line: +(%d+), col: +(%d+)%):\t(.*)",
					{ "severity", "code", "lnum", "col", "message" },
					{
						Notice = vim.diagnostic.severity.WARN,
						Error = vim.diagnostic.severity.ERROR,
					}
				),
				condition = norme_toggle(),
			}

			opts.linters_by_ft = {
				c = { "norminette" },
				cpp = { "norminette" },
			}

			return opts
		end,
	},
}
