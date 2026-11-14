
local parsers = {
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
}

require("nvim-treesitter").install(parsers)

-- Enable native Tree-sitter highlighting
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "lua",
        "vim",
        "vimdoc",
        "sh",
        "c",
        "cs",
        "cpp",
        "ps1",
        "python",
        "html",
        "toml",
        "javascript",
        "typescript",
        "typescriptreact",
        "json",
        "yaml",
        "xml",
        "markdown",
        "vimwiki",
    },
    callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
    end,
})
