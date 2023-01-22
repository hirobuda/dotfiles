local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed {
	'sumneko_lua',
	'rust_analyzer',
	'pyright'
}

lsp.configure('ltex', {
	language = "pt-BR"
})

lsp.setup()
