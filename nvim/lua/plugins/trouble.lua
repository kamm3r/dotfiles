return {
    'folke/trouble.nvim',
    opts = {
        icons = false,
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
    end
}
