return {
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        opts = {
            transparent_background = true,
            custom_highlights = function(colors)
                return {
                    Comment = { fg = "#a3a3a3" },
                }
            end,
        },
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin-frappe",
            -- colorscheme = "catppuccin-latte",
        },
    },
}
-- hello
