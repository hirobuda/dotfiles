function IsMath()
    let hg = join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'))
    return hg =~? 'Math' ? 1 : 0
endfunction

" insert mode maps
:inoremap <buffer> <expr> ( IsMath() ? '\left(' : '('
:inoremap <buffer> <expr> ) IsMath() ? '\right)' : ')'
:inoremap <buffer> <expr> [ IsMath() ? '\left[' : '['
:inoremap <buffer> <expr> ] IsMath() ? '\right]' : ']'
:inoremap <buffer> <expr> \part IsMath() ? '\partial' : '\p'
:inoremap <buffer> <expr> \the IsMath() ? '\theta' : '\t'
:inoremap <buffer> <expr> \alp IsMath() ? '\alpha' : '\a'
:inoremap <buffer> <expr> \bet IsMath() ? '\beta' : '\b'
:inoremap <buffer> <expr> \fr IsMath() ? '\frac{}{}' : '\f'
:inoremap <buffer> <expr> \sum IsMath() ? '\sum_{}^{}' : '\s'
:inoremap <buffer> <expr> ^ IsMath() ? '^{}' : '^'
:inoremap <buffer> <expr> \lim IsMath() ? '\lim_{\to}' : '\lim'
" normal mode maps
:noremap <buffer> <F2> i$$<Enter>\begin{aligned}<Enter><Enter>\end{aligned}<Enter>$$
