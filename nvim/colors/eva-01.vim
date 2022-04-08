set background=dark
hi clear
if exists("syntax_on")
	syntax reset
endif
set t_Co=256
let colors_name = "eva-01"

hi Normal	    guifg=#bbc2cf        guibg=none          gui=none     
hi NonText	    guibg=none           guifg=#2e2733       gui=none     
hi Comment	    guifg=#615882                            gui=none
hi Constant	    guifg=#ab2315                            gui=none
hi Cursor	    guibg=#f6c026        guifg=bg            gui=none
hi CursorLine	    guibg=none        gui=none	     
hi CursorColumn	    guibg=none        gui=none
hi ColorColumn	    guibg=#262626        gui=none     
hi Directory	    guifg=#adf182        gui=none     
hi Folded	    guibg=#262626        guifg=#a9a1c7       gui=none     
hi Function	    guifg=#adf182        gui=none     
hi Identifier	    guifg=#adf182        gui=none     
hi LineNr	    guifg=#615882        guibg=#262626       gui=none     
hi MatchParen	    guifg=bg             guibg=#6f4fa2       gui=none     
hi Number	    guifg=#ab2315        gui=none     
hi PreProc	    guifg=#f6c026        gui=none     
hi Statement	    guifg=#916cad        gui=none     
hi Special	    guifg=#ff8c28        gui=none     
hi SpecialKey	    guifg=#6f4fa2        gui=none     
hi StatusLine	    guibg=#2e254f        guifg=#a9a1c7       gui=none     
hi StatusLineNC	    guifg=#615882        guibg=#2e2733       gui=none     
hi String	    guifg=#d05310        gui=none     
hi StorageClass	    guifg=#adf182        gui=none     
hi Todo		    guifg=#f5e4e6        guibg=bg            gui=none     
hi Type		    guifg=#adf182        gui=none     
hi Title	    guifg=#837ff9        gui=none     
hi Underlined	    guifg=#837ff9        gui=underline     
hi VertSplit	    guibg=#2e2733        guifg=#2e2733       gui=none     
hi Visual	    guibg=#400000        gui=none     
hi IncSearch        guifg=bg             guibg=#f6c026       gui=none
hi Search           guifg=bg             guibg=#ff8c28       gui=none
hi Error            guifg=#f5e4e6        guibg=#ab2315
hi ErrorMsg         guifg=#000000        guibg=#ab2315
hi WarningMsg       guifg=#000000        guibg=#ff8c28
hi Boolean          guifg=#d65c30

hi Pmenu            guifg=#ff8c28        guibg=#2e2733
hi PmenuSel         guibg=#adf182        guifg=#000000
hi PmenuSbar        guibg=#2e2733        guifg=#2e2733
hi PmenuThumb       guibg=#916cad        guifg=#916cad

if has('spell')
        hi SpellBad guisp=#ab2315 gui=undercurl
        hi SpellRare guisp=#ff8c28 gui=undercurl
        hi SpellCap guisp=#916cad gui=undercurl
        hi SpellLocal guisp=#adf182 gui=undercurl
endif
