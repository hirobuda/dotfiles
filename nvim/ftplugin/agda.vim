command! -buffer -nargs=0 AgdaLoad call AgdaLoad(v:false)
command! -buffer -nargs=0 AgdaVersion call AgdaVersion(v:false)
command! -buffer -nargs=0 AgdaReload silent! make!|redraw!
command! -buffer -nargs=0 AgdaRestartAgda exec s:python_cmd 'AgdaRestart()'
command! -buffer -nargs=0 AgdaShowImplicitArguments exec s:python_cmd "sendCommand('ShowImplicitArgs True')"
command! -buffer -nargs=0 AgdaHideImplicitArguments exec s:python_cmd "sendCommand('ShowImplicitArgs False')"
command! -buffer -nargs=0 AgdaToggleImplicitArguments exec s:python_cmd "sendCommand('ToggleImplicitArgs')"
command! -buffer -nargs=0 AgdaConstraints exec s:python_cmd "sendCommand('Cmd_constraints')"
command! -buffer -nargs=0 AgdaMetas exec s:python_cmd "sendCommand('Cmd_metas')"
command! -buffer -nargs=0 AgdaSolveAll exec s:python_cmd "sendCommand('Cmd_solveAll')"
command! -buffer -nargs=1 AgdaShowModule call AgdaShowModule(<args>)
command! -buffer -nargs=1 AgdaWhyInScope call AgdaWhyInScope(<args>)
command! -buffer -nargs=1 AgdaSetRewriteMode exec s:python_cmd "setRewriteMode('<args>')"
command! -buffer -nargs=0 AgdaSetRewriteModeAsIs exec s:python_cmd "setRewriteMode('AsIs')"
command! -buffer -nargs=0 AgdaSetRewriteModeNormalised exec s:python_cmd "setRewriteMode('Normalised')"
command! -buffer -nargs=0 AgdaSetRewriteModeSimplified exec s:python_cmd "setRewriteMode('Simplified')"
command! -buffer -nargs=0 AgdaSetRewriteModeHeadNormal exec s:python_cmd "setRewriteMode('HeadNormal')"
command! -buffer -nargs=0 AgdaSetRewriteModeInstantiated exec s:python_cmd "setRewriteMode('Instantiated')"

" C-c C-l -> \l
nnoremap <buffer> <LocalLeader>l :AgdaReload<CR>

" C-c C-d -> \t
nnoremap <buffer> <LocalLeader>t :call AgdaInfer()<CR>

" C-c C-r -> \r
nnoremap <buffer> <LocalLeader>r :call AgdaRefine("False")<CR>
nnoremap <buffer> <LocalLeader>R :call AgdaRefine("True")<CR>

" C-c C-space -> \g
nnoremap <buffer> <LocalLeader>g :call AgdaGive()<CR>

" C-c C-g -> \c
nnoremap <buffer> <LocalLeader>c :call AgdaMakeCase()<CR>

" C-c C-a -> \a
nnoremap <buffer> <LocalLeader>a :call AgdaAuto()<CR>

" C-c C-, -> \e
nnoremap <buffer> <LocalLeader>e :call AgdaContext()<CR>

" C-u C-c C-n -> \n
nnoremap <buffer> <LocalLeader>n :call AgdaNormalize("IgnoreAbstract")<CR>

" C-c C-n -> \N
nnoremap <buffer> <LocalLeader>N :call AgdaNormalize("DefaultCompute")<CR>
nnoremap <buffer> <LocalLeader>M :call AgdaShowModule('')<CR>

" C-c C-w -> \y
nnoremap <buffer> <LocalLeader>y :call AgdaWhyInScope('')<CR>
nnoremap <buffer> <LocalLeader>h :call AgdaHelperFunction()<CR>

" M-. -> \d
nnoremap <buffer> <LocalLeader>d :call AgdaGotoAnnotation()<CR>

" C-c C-? -> \m
nnoremap <buffer> <LocalLeader>m :AgdaMetas<CR>

" Show/reload metas
" C-c C-? -> C-e
nnoremap <buffer> <C-e> :AgdaMetas<CR>
inoremap <buffer> <C-e> <C-o>:AgdaMetas<CR>

" Go to next/previous meta
" C-c C-f -> C-g
nnoremap <buffer> <silent> <C-g>  :let _s=@/<CR>/ {!\\| ?<CR>:let @/=_s<CR>2l
inoremap <buffer> <silent> <C-g>  <C-o>:let _s=@/<CR><C-o>/ {!\\| ?<CR><C-o>:let @/=_s<CR><C-o>2l

" C-c C-b -> C-y
nnoremap <buffer> <silent> <C-y>  2h:let _s=@/<CR>? {!\\| \?<CR>:let @/=_s<CR>2l
inoremap <buffer> <silent> <C-y>  <C-o>2h<C-o>:let _s=@/<CR><C-o>? {!\\| \?<CR><C-o>:let @/=_s<CR><C-o>2l
