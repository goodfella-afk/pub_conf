return {
	{
		"vimwiki/vimwiki",
		init = function()
			vim.g.vimwiki_listsyms = "✗○◐●✓"

			vim.g.vimwiki_list = {
				{
					path = vim.fn.expand("~/Documents/notes"),
					syntax = "markdown",
					ext = ".md",
				},
			}
		end,
	},
}
