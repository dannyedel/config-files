colorscheme koehler
syntax on
set smartindent
set tabstop=4
set shiftwidth=4
set nu!
set modeline

" This gives fancy tab/newline highlighting
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

let g:ycm_global_ycm_extra_conf = '~/.vim/ycm/.ycm_extra_conf.py'
let g:ycm_always_populate_location_list = 1
let g:ycm_complete_in_strings = 0
let g:ycm_filetype_whitelist = { 'cpp': 1 }

syntax on
filetype on
au BufNewFile,BufRead *.nxc set filetype=c

au BufNewFile,BufRead *.nxc command Run :!nbc -r %

au BufRead,BufNewFile *.twig set filetype=htmljinja

au BufRead,BufNewFile *.md set filetype=markdown

" disable signature quoting

" au BufRead /tmp/mutt* normal :g/^> -- $/,/^$/-1d^M/^$^M^L
"
"

" automatically go right before the own signature
" and start Insert mode when editing mutt emails
"
" Step 1: goto end
" au BufRead /tmp/mutt* normal G
" Step 2: search backwards for signature
au BufRead /tmp/mutt* :$?\n-- $
au BufRead /tmp/mutt* :startinsert




" map ,rq /^> *-- ?mt/^[^>]*$kmb``d'b
"

" remove quoted signature and goto end of file
map ,remquote <ESC>:%s/\(> *\n\)*> *-- *\n\(>[^>]*\n\)*//g<CR>
" goto end of file
map ,endgo <ESC>G
" goto end of file and edit
map ,endedit <ESC>Gi

"do both
map ,email <ESC>,remquote,endgo


nmap <F5> :lopen<CR>
nmap <F6> :lclose<CR>
inoremap <F5> <C-O>:lopen<CR>
inoremap <F6> <C-O>:lclose<CR>

map <C-Space> <C-X><C-O>
filetype plugin on

map <F8> <ESC>:!ctags -R .<CR>

set tags+=~/ctags/stl
set tags+=~/ctags/qt

set gfn=Terminus\ 13

" vim-latexsuite
set grepprg=grep\ -nH\ $*

filetype indent on

let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_SmartKeyQuote=0
