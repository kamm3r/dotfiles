return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    keys = {
        {
            '<leader>pf',
            function()
                require('telescope.builtin').find_files()
            end,
            mode = "n",
            desc = 'Search Files'
        },
        {
            '<C-p>',
            function()
                require('telescope.builtin').git_files()
            end,
            mode = "n",
            desc = 'Search Git Files'
        },
        {
            '<leader>pws',
            function()
                local word = vim.fn.expand("<cword>")
                require('telescope.builtin').grep_string({ search = word })
            end,
            mode = "n",
            desc = 'Search Word'
        },
        {
            '<leader>pWs',
            function()
                local word = vim.fn.expand("<cWORD>")
                require('telescope.builtin').grep_string({ search = word })
            end,
            mode = "n",
            desc = 'Search WORD'
        },
        {
            '<leader>ps',
            function()
                require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
            end,
            mode = "n",
            desc = 'Search current Word'
        },
        {
            '<leader>vh',
            function()
                require('telescope.builtin').help_tags()
            end,
            mode = "n",
            desc = 'Search Help Tags'
        }
    },

    opts = {
        pickers = {
            find_files = {
                theme = "ivy",
            },
            git_files = {
                theme = "ivy",
            },
            grep_string = {
                theme = "ivy",
            },
            help_tags = {
                theme = "ivy",
            }
        },
    },
}
