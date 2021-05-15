"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
"                                                                              "
"                       __   _ _ _ __ ___  _ __ ___                            "
"                       \ \ / / | '_ ` _ \| '__/ __|                           "
"                        \ V /| | | | | | | | | (__                            "
"                         \_/ |_|_| |_| |_|_|  \___|                           "
"                                                                              "
"                                                                              "
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

"=====================================================
"" Plugin settings
"=====================================================
" automatic installation of plugin manager
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/bundle')

    "-------------------=== Code/Project navigation ===-------------
    Plug 'preservim/nerdtree'                " Project and file navigation
    Plug 'majutsushi/tagbar'                  " Class/module browser
    Plug 'kien/ctrlp.vim'                     " Fuzzy search, fast transitions on project files
    Plug 'tpope/vim-fugitive'                 " Git integration
    Plug 'dense-analysis/ale'                 " ALE lint, autocomplete
    Plug 'Yggdroot/indentLine'                " Vertical guide lines
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }   " auto-complete
    Plug 'deoplete-plugins/deoplete-jedi'     " Deoplete source for python
    Plug 'tpope/vim-surround'                 " Parentheses, brackets, quotes, XML tags, and more

    "-------------------=== Appearance ===-------------------------------
    Plug 'vim-airline/vim-airline'                  " Lean & mean status/tabline for vim
    Plug 'vim-airline/vim-airline-themes'     " Themes for airline
    Plug 'Lokaltog/powerline'                 " Powerline fonts plugin
    Plug 'flazz/vim-colorschemes'             " Colorschemes

    "-------------------=== Snippets support ===--------------------
    Plug 'garbas/vim-snipmate'                " Snippets manager
    Plug 'MarcWeber/vim-addon-mw-utils'       " dependencies #1
    Plug 'tomtom/tlib_vim'                    " dependencies #2
    Plug 'honza/vim-snippets'                 " snippets repo

    "-------------------=== Languages support ===-------------------
call plug#end()

"=====================================================
"" General settings
"=====================================================
set t_co=256
colorscheme wombat256mod
set list listchars=tab:\|\ ,trail:⋅,nbsp:⋅

set number
set relativenumber

set splitright
set splitbelow

" set cursorline
set tabstop=4
set shiftwidth=4
set expandtab
filetype plugin indent on

"=====================================================
"" CtrlP setttings
"=====================================================
let g:ctrlp_match_window = 'bottom,order:btt'

"=====================================================
"" Indentline settings
"=====================================================
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

"=====================================================
"" SnipMate settings
"=====================================================
let g:snippets_dir='~/.config/nvim/vim-snippets/snippets'

"=====================================================
"" Deolete settings
"=====================================================
let g:deoplete#enable_at_startup = 1
"call deoplete#custom#option('sources', {
"\ '_': ['ale'],
"\})
" automatically close preview window
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"=====================================================
"" ALE setttings
"=====================================================
let g:ale_lint_on_enter = 0
" set omnifunc=ale#completion#OmniFunc
"let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
  \'python': ['pycodestyle', 'pydocstyle', 'pyflakes', 'pylint', 'pyls'],
  \}
" fix files when you save them.
let g:ale_fix_on_save = 0
let g:ale_fixers = {
   \'*': ['remove_trailing_lines', 'trim_whitespace'],
   \'python': ['black', 'isort'],
   \}
" map go to definition
nmap <silent> gd :ALEGoToDefinition<cr>
" map go to next/previous ale error line
nmap <silent> <leader>an :ALENext<cr>
nmap <silent> <leader>aN :ALEPrevious<cr>

"=====================================================
"" AirLine settings
"=====================================================
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1

"=====================================================
"" TagBar settings
"=====================================================
let g:tagbar_autofocus=0
let g:tagbar_width=42
let g:tagbar_sort=0
nmap <leader>t :TagbarToggle<cr>

"=====================================================
"" NERDTree settings
"=====================================================
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']     " Ignore files in NERDTree
let NERDTreeWinSize=40
autocmd VimEnter * if !argc() | NERDTree | endif  " Load NERDTree only if vim is run without arguments
nmap <leader>n :NERDTreeToggle<cr>

"=====================================================
" highlight 'long' lines (>= 80 symbols) in python files
"=====================================================
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python,rst,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python,rst,c,cpp match Excess /\%81v.*/
    autocmd FileType python,rst,c,cpp set nowrap
    autocmd FileType python,rst,c,cpp set colorcolumn=80
augroup END

"=====================================================
" use vim virtualenv
"=====================================================
"let g:python_host_prog = '~/.venvs/vim/bin/python'
let g:python3_host_prog = expand('~/.venvs/vim/bin/python')
let $PATH .= ':/home/yueting/.venvs/vim/bin'

"=====================================================
" set background transparency
" change the line order to toggle between transparent and opaque
"=====================================================
"hi Normal guibg=#111111 ctermbg=black
hi NonText ctermbg=None
hi Normal guibg=None ctermbg=None
