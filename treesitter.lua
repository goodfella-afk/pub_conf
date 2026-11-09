return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",

		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"bash",
					"c",
					"c_sharp",
					"cpp",
					"powershell",
					"python",
					"html",
					"toml",
					"javascript",
					"typescript",
					"tsx",
					"json",
					"yaml",
					"xml",
					"markdown",
					"markdown_inline",
				},

				highlight = {
					enable = true,
				},

				indent = {
					enable = true,
				},
			})
			-- Treat Vimwiki buffers as Markdown
			vim.treesitter.language.register("markdown", "vimwiki")
		end,
	},
}

