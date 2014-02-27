colorscheme koehler
syntax on
set smartindent
set tabstop=4
set shiftwidth=4
set nu!

" This gives fancy tab/newline highlighting
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list


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

map <C-Space> <C-X><C-O>
" installation of omnicppcomplete
set nocp
filetype plugin on

map <F8> <ESC>:!ctags -R .<CR>

let OmniCpp_MayCompleteScope = 1
let OmniCpp_ShowPrototypeInAbbr = 1

set tags+=~/ctags/stl
set tags+=~/ctags/qt

set gfn=Terminus\ 13
