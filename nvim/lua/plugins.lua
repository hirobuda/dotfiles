local use = require('packer').use
require('packer').startup(function()
        use 'wbthomason/packer.nvim' -- Package manager
        use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
        use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", 
		setup = function() vim.g.mkdp_filetypes = { "markdown" } end, 
		ft = { "markdown" }, })
	use 'elzr/vim-json'
        use {'ms-jpq/coq_nvim', branch = 'coq'}
        use {'ms-jpq/coq.artifacts', branch = 'artifacts'}
        use '907th/vim-auto-save'
        use 'nvim-lualine/lualine.nvim'
        use 'ap/vim-css-color'
        use 'lervag/vimtex'
	use {'kyazdani42/nvim-tree.lua',requires = {
		'kyazdani42/nvim-web-devicons', -- optional, for file icons}
	}}
      	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
        use {'rrethy/vim-hexokinase', run = 'make hexokinase'}
        use 'ixru/nvim-markdown'
	use 'pappasam/coc-jedi'
	use 'folke/tokyonight.nvim'
	use 'JuliaEditorSupport/julia-vim'
	use 'Julian/lean.nvim'
	use 'nvim-lua/plenary.nvim'
end)

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

require('plugins/markdown-preview')
require('plugins/nvim-markdown')
require('plugins/lualine')
require('plugins/vimtex')
