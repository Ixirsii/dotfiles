return {
    'kdheepak/lazygit.nvim',

    cmd = {
        'LazyGit',
        'LazyGitConfig',
        'LazyGitCurrentFile',
        'LazyGitFilter',
        'LazyGitFilterCurrrentFile',
    },

    dependencies = {
        'nvim-lua/plenary.nvim',
    },

    keys = {
        { '<leader>lg', '<cmd>LazyGit<CR>', desc = 'Lazy git' },
    },
}
