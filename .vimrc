" Jacob Straszynski's .zshrc
"
" Note: sure where a setting is being configured? `verbose set modeline?` for
" example. `verbose map ,e' also works.
"
" Note: when committing this repo, sometimes the various git-managed submodules
" turn out to have local changes that cause persistent untracked content
" warnings in git (you keep seeing an uncomitted file that stubbornly refuses
" to commit)
"
" See:
" http://stackoverflow.com/questions/7993413/git-submodules-with-modified-and-untracked-content-why-and-how-to-remove-it
"
" Related:
" http://stackoverflow.com/questions/5127178/gitignore-files-added-inside-git-submodules
"
" Installing vimballs
" open it in vim and type :source %

" Enable filetype specific configuration by placing files into
" .vim/ftplugin/{js,py,rb,etc}.vim
filetype off
syntax off

colorscheme molokai
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
filetype on
syntax enable

" For powerline see: https://github.com/Lokaltog/vim-powerline
set encoding=utf-8
let g:Powerline_symbols = 'unicode'

" Make vim-go not so slow
let g:go_fmt_autosave = 0
nnoremap <leader>gf :GoFmt<cr>

" Makes the mapleader not so crappy.
let mapleader = ","

" Note: for making terminal colors work in OSX:
" http://stackoverflow.com/questions/3761770/iterm-vim-colorscheme-not-working

" Large file protection - anything over 10 mb disables vim features.
" let g:LargeFile=10
" Protect large files from sourcing and other overhead.
" Files become read only
" if !exists("my_auto_commands_loaded")
"   let my_auto_commands_loaded = 1
"   " Large files are > 10M
"   " Set options:
"   " eventignore+=FileType (no syntax highlighting etc
"   " assumes FileType always on)
"   " noswapfile (save copy of file)
"   " bufhidden=unload (save memory when other file is viewed)
"   " buftype=nowritefile (is read-only)
"   " undolevels=-1 (no undo possible)
"   let g:LargeFile = 1024 * 1024 * 10
"   augroup LargeFile
"     autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
"     augroup END
"   endif

" INDENTATION and syntax
set ai
set ts=2
set sts=2
set sw=2
set mouse=a
set number
set hidden
set expandtab
" Allows selection of splits via mouse.
set ttymouse=xterm2

" Fixes double build issues when working with gulp watchers.
set nowritebackup

" Using cake dev command from express-coffescript project instead.
" au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
" I have an aliases file with some login aliases.
au BufNewFile,BufRead .*aliases set filetype=sh

"http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
set wildmode=longest,list,full
set wildmenu

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %
set backspace=indent,eol,start

" CtrlP Settings
" Instructions on ctrlp site, not sure what it's for:
" http://kien.github.com/ctrlp.vim/
set runtimepath^=~/.vim/bundle/ctrlp.vim
" Clear highlights from incsearch. using ,<space>
nnoremap <leader><space> :noh<cr>
" Ignore hidden directories because they usually slow things down.
" Unless I'm in dotfiles
" Was using this formerly:
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|.Trash|tmp|venv|projectenv|static|build\/)'
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_depth = 5
nnoremap <leader>F :CtrlP<CR>
nnoremap <leader>f :CtrlPCurWD<CR>


" Toggle NERDTree with ,t
nmap <silent> <leader>t :NERDTreeToggle<CR>
nmap <silent> <leader>r :NERDTreeFind<CR>

" Get rid of stuff that makes VIM vi compatible that is apparrently crappy?
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim/#using-the-leader
set nocompatible
" Security fix - remove modeline support.
set modelines=1

" Various display options.
set ruler
set showmode
set showcmd
set visualbell
set nocursorline
set ttyfast
set laststatus=2
" Relative numbering instead of line numbering, use the ruler instead for
" absolute.
silent! set norelativenumber
" Creates an undofile that lets you conduct undoes after close and reopen.
silent! set undofile
" I don't like these.
silent! set noswapfile
set directory=$HOME/.vimtmp
set undodir=$HOME/.vimtmp

" Makes searching better
set ignorecase
" Overrides ignorecase if uppercase characters are used in a search.
set smartcase
" Global substitution on by default. g now reverts to single sub.
set gdefault
" Starts to highlight partial search results.
set incsearch
" Briefy jump to matching closing brackets.
" set showmatch super annoying
set nohlsearch
" Use perl style regex instead of vims goofiness
" These are annoying because they make me unable to refer to the search
" http://stackoverflow.com/questions/1497958/how-to-use-vim-registers
" register.
nnoremap / /\v
vnoremap / /\v


" Column wrapping
set wrap
set textwidth=81
" See :help fo-table
set formatoptions=qrn1
silent! set colorcolumn=80

" Automatically save current editor after tabbing away.
" au FocusLost * :wa
"
"
" Toggle syntax numbering
function! ToggleNumber()
    if(&relativenumber)
        set number
    else
        set relativenumber
    endif
endfunction
nmap <silent><leader>L :call ToggleNumber()<CR>

" Toggle paste mode
function! TogglePaste()
    if(&paste)
        set nopaste
    else
        set paste
    endif
endfunction
nmap <silent><leader>p :call TogglePaste()<CR>

" Shift tab dedent
nnoremap <s-tab> <<

" Map omnicompletion to jk
" inoremap jk <c-x><c-o>

" Markdown heading generation
nnoremap <leader>H yyp :s/./#/<cr> :noh<cr>
" Subheading
nnoremap <leader>sH yyp :s/./-/<cr> :noh<cr>

" Banner Heading Generation
" Submatches are used because I couldn't find a way to replace every occurence
" of .*|. (and variation thereof) following the // comment prefix.
" This was old but intersting.
" nnoremap <leader>h yyp :s/\(\s*\/\/\s*\)\(.*\)/\=submatch(1).repeat("#",strlen(submatch(2)))/<cr> :noh<cr>
" nnoremap <leader>hh yyp :s/\(\s*\/\*\s*\)\(.*\)/\=submatch(1).repeat("#",strlen(submatch(2)))/<cr> :noh<cr>
nnoremap <leader>h ^yypwVv$r#
nnoremap <leader>hh ^yypwVv$r-


" Execute line under cursor - useful when editing these damn things.
" nnoremap <leader>e yy :<c-r>"<cr>k
" This is better, just source the file.
nnoremap <leader>e :so $MYVIMRC<cr>

" ctrl-ww is awkward
nnoremap <leader>w <C-w>w
nnoremap <leader>W <C-w>p

" Change paste "_ sets buffer to blackhole buffer, <C-R> loads register contents.
" We assume the default register.
nmap <silent> cp "_ciw<C-R>"<Esc>

" Add php highlighting to Phakefiles
au BufNewFile,BufRead Phakefile set filetype=php
" ReGenerate Tags
map <Leader>rgt :!ctags --extra=+f --exclude=.git --exclude=log -R * <CR><CR>

" Disable numbering for easier copy and paste
" mnemonic: mouse disable
nnoremap <leader>md :set mouse=r<cr> :set nonumber<cr> :set norelativenumber<cr> 
" mnemonic: mouse visual
nnoremap <leader>mv :set mouse=a<cr> :set relativenumber<cr>

" mouse all
nnoremap <leader>ma :set mouse=a<cr>
" mouse none
nnoremap <leader>mn :set mouse=r<cr>

" Rainbow paren
nnoremap <leader>R :RainbowParenthesesToggle<cr>

" Change variable to object notation for php
nnoremap <leader>vo mZ viW :s/\v\$(.*)\[\'(.*)\'\]/$\1->\2/ <cr><esc>`Z:noh<cr>
" Change variable to array notation for php
nnoremap <leader>va mZ viW :s/\v\$([^\ \=]*)-\>([^\ \=]*)/$\1['\2']/ <cr><esc>`Z:noh<cr>
" ca is used in nerdcommenter for changing comment types.
" This breaks vim-jsx.
" let g:xml_syntax_folding=1
au FileType glade setlocal foldmethod=syntax

au BufRead,BufNewFile *.aliases set filetype=zsh

" Show what you've changed in this buffer.
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" bufferdiff
nnoremap <leader>bd :DiffSaved<cr>
" close the diff buffer, the last <C-O> closes the other windows. 
nnoremap <leader>bo :diffoff<cr><C-W><C-O>

" edit the .vimrc file rapidly
nnoremap <leader>vr :e ~/.vimrc<cr>

set clipboard=unnamed

" Create a scrolling boundary of 5 lines from the top of the screen.
set so=5

" Don't add eol.
set noeol

" Open tagbar.
nnoremap <leader>T :TagbarToggle<CR>

" Search Dash for word under cursor
function! SearchDash()
  let s:browser = "/usr/bin/open"
  let s:wordUnderCursor = expand("<cword>")
  let s:url = "dash://".s:wordUnderCursor
  let s:cmd ="silent ! " . s:browser . " " . s:url
  execute s:cmd
  redraw!
endfunction
map <leader>d :call SearchDash()<CR>

" Clipboard

vmap <leader>m :w !pbcopy<CR><CR>
vmap <leader>M :!pbaste<CR>
nnoremap <leader>m :w !pbcopy<CR><CR>

" Replace trailing whitespace empty lines
nnoremap <leader>re /\v^([ ]{1,})([^ \t]{1,})@!$<cr>d$

let @q = '/MEDIA_URLda}da}i{% sttai€kb€kb€kbatic "f"i" %}'

let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_default_mapping = 1
hi IndentGuidesOdd  ctermbg=234
hi IndentGuidesEven ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=235

let NERDSpaceDelims=1

" Formatoptions e.g when using gq. The one thing that really annoys me
" is trailing whitespace to indicate continued paragraphs (option w) - get
" rid of that.
au BufNewFile,BufRead * set fo-=w

" Highlight trailing whitespace
let c_space_errors=1
highlight ExtraWhitespace ctermbg=53 guibg=234
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
match ExtraWhitespace /\s\+$/

" Do not like this feature
let g:vim_json_syntax_conceal = 0

" Reload snippets
nnoremap <leader>S :call ReloadAllSnippets()<cr>

" LustyJuggler
" Make it quick to jump between last/next buffers
nnoremap <leader>j :LustyJuggler<cr>
nnoremap <leader>a :LustyJugglePrevious<cr>
noremap <silent><M-s> :LustyJuggler<CR>
nnoremap <leader>s <A-s><A-s><Enter>


" http://vim.wikia.com/wiki/Add_a_newline_after_given_patterns
" Insert a newline after each specified string (or before if use '!').
" If no arguments, use previous search.
command! -bang -nargs=* -range LineBreakAt <line1>,<line2>call LineBreakAt('<bang>', <f-args>)
function! LineBreakAt(bang, ...) range
  let save_search = @/
  if empty(a:bang)
    let before = ''
    let after = '\ze.'
    let repl = '&\r'
  else
    let before = '.\zs'
    let after = ''
    let repl = '\r&'
  endif
  let pat_list = map(deepcopy(a:000), "escape(v:val, '/\\.*$^~[')")
  let find = empty(pat_list) ? @/ : join(pat_list, '\|')
  let find = before . '\%(' . find . '\)' . after
  " Example: 10,20s/\%(arg1\|arg2\|arg3\)\ze./&\r/ge
  execute a:firstline . ',' . a:lastline . 's/'. find . '/' . repl . '/ge'
  let @/ = save_search
endfunction

" Resize panes evenly, horizontally
nnoremap <leader>z <c-w>=
" Maximize height
nnoremap <leader>Z <c-w>_

" Saner defaults when splitting windows
" horizontal splits - position the new buffer on the right
" verticla splits - position the new buffer below
set splitright
set splitbelow

" put deletes in black hole register.
nnoremap x "0x
nnoremap X "0X
nnoremap d "0d
"nnoremap D "0D

" Tabularize
nnoremap <leader>b :Tabularize /
vnoremap <leader>b :Tabularize /
" Along commas
nnoremap <leader>b, :Tabularize /,
vnoremap <leader>b, :Tabularize /,
" Along colons
nnoremap <leader>b: :Tabularize /:
" E.g.
"/*      1 */ E_ERROR             => 'Error',
"/*   4096 */ E_RECOVERABLE_ERROR => 'Error',
"/* 163841 */ E_USER_DEPRECATED   => 'Error'
" :AddTabularPattern php_array_assign /=>\|\(\d+\)\|\*\/\|\/\*/l1c1r1l1l1l1

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:vim_markdown_folding_disabled=1


" Syntastic
let g:syntastic_php_checkers = ['php','phpcs']

" psr syntax enable
nnoremap <leader>pse: :let g:syntastic_php_checkers = ['php','phpcs']
" psr syntax disable
nnoremap <leader>psd: :let g:syntastic_php_checkers = ['php','phpcs']

" Not quite accurate, but in my case, if I'm running php cs it's checking agains PSR-2.
let g:phpcs_enabled=0
let g:syntastic_php_checkers = ['php']

function! PHPCSToggle()
  if g:phpcs_enabled == 0
    let g:phpcs_enabled = 1
    let g:syntastic_php_checkers = ['php','phpcs']
    echo "Enabled phpcs"
  else
    let g:phpcs_enabled = 0
    let g:syntastic_php_checkers = ['php']
    echo "Disabled phpcs"
  endif
endfunction
nnoremap <leader>sr :call PHPCSToggle()<cr>

nnoremap <leader>ss :SpacingSwitch<cr>
let g:user_vim_spacing=2
function! SpacingSwitch()
  if g:user_vim_spacing == 2
    let g:user_vim_spacing = 4
  else
    let g:user_vim_spacing = 2
  endif
  " Must use let instead of set and prefix with ampersand because
  " of the g:user_* variable we're referring to.
  let &ts=g:user_vim_spacing
  let &sw=g:user_vim_spacing
  echo "Using spacing of " . g:user_vim_spacing
endfunction
command! SpacingSwitch call SpacingSwitch()
nnoremap <leader>ss :SpacingSwitch<cr>

" Copy the relative path of current file to clipboard
noremap <silent> <leader>l :let @+ = expand("%:p")<cr>
" Copy the absolute path of current file to clipboard
noremap <silent> <leader>L :let @+ = expand("%")<cr>

function! GitURL()
  return system("git config --get remote.origin.url | sed -E 's/git@github\\.com:(.*)\\.git/https:\\/\\/github\\.com\\/\\1/g'")[:-2]
endfunction

function! GitLink()
  let @+ = GitURL().'/blob/'.system("git rev-parse --abbrev-ref HEAD")[:-2]."/".expand("%")."#L".line(".")
  echom @+
  return @+
endfunction

function! GitGist()
    let content = shellescape(join(getline(a:firstline, a:lastline), "\n"))
    let json = '{
            \ "description": "the description for this gist",
                \ "public": true,
            \ "files": {
                \"file1.txt": {
                \"content":
                \' . '
                \}
            \}
        \}'
    echom json
endfunction

noremap <silent> <leader>g :call GitLink()<cr>
noremap <silent> <leader>G :!open <C-R>=GitLink()<cr><cr><cr>
noremap <silent> <leader>S :call GitGist()<cr>

nnoremap <leader>S :exe "curl -X POST -d " . shellescape(expand("<cWORD>")) . " ."<cr>
nnoremap <leader>D "_d
nnoremap <leader>rd :redraw!<cr>
nnoremap <leader>Q @q

" React JSX
" Make vim-jsx recognize js files.
let g:jsx_ext_required = 0
let g:syntastic_javascript_checkers = ['jsxhint']
nnoremap <leader>ts :%s/  /\t<cr>

au BufNewFile,BufRead *.es6 set filetype=javascript

" Comment heading, requires vim-textobj-comment
" Copy the line, create a newline gap (so we don't select both our new and
" previous line), paste our copy, move the cursor onto it, use vim textobject
" comment to select within it, replace the contents with # signs.
" This could've just used a replacement. Fuck you!
map <leader>c# yy]<space>jp]<space> vicr# jdd kkkdd
map <leader>c* yy]<space>jp]<space> vicr* jdd kkkdd
map <leader>c- yy]<space>jp]<space> vicr- jdd kkkdd
map <leader>c= yy]<space>jp]<space> vicr= jdd kkkdd

" Syntax highlight debugging - what group are we in?
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Vim-jsx
let g:jsx_ext_required = 0

" Decompact json
" nnoremap <leader>js va{
nnoremap <leader>js va{:s/\([,\{]\)/\1/

" Format with a smaller textwidth
" Well this was dumb. Use execute mode to stash and change tw, run gq in normal mode,
" then restore tw.
map gb <esc>(:execute 'let last_tw=&tw \| set tw=65' <cr>) (gvgq) (:execute "set tw=".last_tw <cr>)
