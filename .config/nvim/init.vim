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
    Plug 'preservim/nerdtree'                          " Project and file navigation
    Plug 'majutsushi/tagbar'                           " Class/module browser
    Plug 'kien/ctrlp.vim'                              " Fuzzy search, fast transitions on project files
    Plug 'tpope/vim-fugitive'                          " Git integration
    Plug 'Yggdroot/indentLine'                         " Vertical guide lines
    Plug 'tpope/vim-surround'                          " Parentheses, brackets, quotes, XML tags, and more
    Plug 'neoclide/coc.nvim', {'branch': 'release'}    " coc for full LSP
"    Plug 'dense-analysis/ale'                         " ALE lint, autocomplete
"    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }   " auto-complete
"    Plug 'deoplete-plugins/deoplete-jedi'     " Deoplete source for python

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
"" coc settings
"=====================================================
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


"=====================================================
"" Deolete settings
"=====================================================
"let g:deoplete#enable_at_startup = 1
"call deoplete#custom#option('sources', {
"\ '_': ['ale'],
"\})
" automatically close preview window
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"   "=====================================================
"   " ALE setttings
"   "=====================================================
"   let g:ale_lint_on_enter = 0
"   " set omnifunc=ale#completion#OmniFunc
"   "let g:ale_lint_on_text_changed = 'never'
"   let g:ale_echo_msg_error_str = 'E'
"   let g:ale_echo_msg_warning_str = 'W'
"   let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"   let g:ale_linters = {
"     \'python': ['pycodestyle', 'pydocstyle', 'pyflakes', 'pylint', 'pyls'],
"     \}
"   " fix files when you save them.
"   let g:ale_fix_on_save = 0
"   let g:ale_fixers = {
"      \'*': ['remove_trailing_lines', 'trim_whitespace'],
"      \'python': ['black', 'isort'],
"      \}
"   " map go to definition
"   nmap <silent> gd :ALEGoToDefinition<cr>
"   nmap <silent> gr :ALEFindReferences<cr>
"   " map go to next/previous ale error line
"   nmap <silent> <leader>an :ALENext<cr>
"   nmap <silent> <leader>aN :ALEPrevious<cr>

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
