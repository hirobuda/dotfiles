local use = require('packer').use

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end
-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

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
	use 'Julian/lean.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'simrat39/rust-tools.nvim'
	use 'eandrju/cellular-automaton.nvim'
	use {
		'VonHeikemen/lsp-zero.nvim',
	  	requires = {
	    	-- LSP Support
		    {'neovim/nvim-lspconfig'},
		    {'williamboman/mason.nvim'},
		    {'williamboman/mason-lspconfig.nvim'},

		    -- Autocompletion
		    {'hrsh7th/nvim-cmp'},
		    {'hrsh7th/cmp-buffer'},
		    {'hrsh7th/cmp-path'},
		    {'saadparwaiz1/cmp_luasnip'},
		    {'hrsh7th/cmp-nvim-lsp'},
		    {'hrsh7th/cmp-nvim-lua'},

		    -- Snippets
		    {'L3MON4D3/LuaSnip'},
		    {'rafamadriz/friendly-snippets'},
		  }
	}
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
require("mason").setup()
require'lspconfig'.rust_analyzer.setup{}
