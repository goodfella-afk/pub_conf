return {
    cmd = { "roslyn-language-server", "--stdio" },
    filetypes = { "cs" },
    root_markers = {
        "*.sln",
        "*.csproj",
        ".git",
    },
}
