set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
"
" My Bundles here:
"
"" original repos on github
Bundle 'gmarik/vundle'
Bundle 'vim-scripts/Decho'
Bundle 'kien/ctrlp.vim'
Bundle 'romanvbabenko/rails.vim'
Bundle 'tComment'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rvm'
Bundle "scrooloose/syntastic"
Bundle "tpope/vim-surround"

" non github repos
Bundle "timcharper/textile.vim.git"
Bundle "tpope/vim-markdown.git"
Bundle "jinfield/vim-nginx.git"
Bundle "tpope/vim-haml.git"
Bundle "leshill/vim-json.git"
Bundle "tmatilai/vim-monit.git"
Bundle "t9md/vim-chef.git"
Bundle "romanvbabenko/vim-asciidoc"

Bundle "scrooloose/nerdtree.git"
Bundle "slim-template/vim-slim.git"
Bundle "thoughtbot/vim-rspec"
Bundle "kchmck/vim-coffee-script.git"

" Snippets support
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'

Bundle 'bkad/CamelCaseMotion'
Bundle 'majutsushi/tagbar'

Bundle 'Townk/vim-autoclose'
Bundle 'terryma/vim-multiple-cursors'

" Coloschemes
Bundle 'chriskempson/base16-vim'
Bundle "wgibbs/vim-irblack"
Bundle "altercation/vim-colors-solarized"

Bundle 'rking/ag.vim'

filetype plugin indent on     " required!
syntax enable

" http://serverfault.com/questions/130632/problems-with-vim-locale-as-non-root-user-on-solaris
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=utf-8
endif

set tabstop=2
set expandtab
set shiftwidth=2

set list "display unprintable characters
set backspace=indent,eol,start
set listchars=tab:»·,nbsp:·,trail:·,extends:>,precedes:<

set number
set numberwidth=7

set ruler
set showcmd

set laststatus=2

set hlsearch
set incsearch
set ignorecase
set smartcase

"Autocomplete mode
set wildmenu
" bash style
"set wildmode=longest,list
" zsh style
set wildmode=list:longest,full

" Copy indent from current line when starting a new line
"set autoindent

" Automatically removing all trailing whitespace
autocmd BufWritePre *.rb :%s/\s\+$//e

" File types autodetection
autocmd BufNewFile,BufRead *.txt setfiletype text
autocmd BufNewFile,BufRead Gemfile,Guardfile,Vagrantfile,Procfile,Rakefile setfiletype ruby
autocmd FileType text,markdown,html,xhtml,eruby,asc,slim setlocal wrap linebreak nolist

" Statusline
if has("statusline") && !&cp
  set laststatus=2  " always show the status bar

  " Start the status line

  set statusline=%{hostname()}:
  set statusline+=%f\ %m\ %r

  " Add rvm
  if exists('$rvm_path')
    set statusline+=%{rvm#statusline()}
  endif
  " Add fugitive
  set statusline+=%{fugitive#statusline()}

  " display a warning if &paste is set
  set statusline+=%#error#
  set statusline+=%{&paste?'[paste]':''}
  set statusline+=%*

  " Finish the statusline
  set statusline+=Line:%l/%L[%p%%]
  set statusline+=Col:%v
  set statusline+=Buf:#%n
  set statusline+=[%b][0x%B]
endif

" Show syntax highlighting groups for word under cursor
" nmap <C-S-P> :call <SID>SynStack()<CR>
nmap <C-S-H> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nnoremap <c-l> :bp <cr>
let mapleader = "\\"
map <leader>l :bp<esc>

" Local config
if exists('$HOME/.vimrc.local')
  source ~/.vimrc.local
endif

" Rails shortcuts
command! Rapplication :e config/application.rb
command! Rroutes :e config/routes.rb
command! Rschema :e db/schema.rb
command! Rgemfile :e Gemfile
command! RTapplication :tabnew config/application.rb
command! RTroutes :tabnew config/routes.rb
command! RTschema :tabnew db/schema.rb
command! RTgemfile :tabnew Gemfile

" Automatically load .vimrc source when saved
autocmd BufWritePost .vimrc source $MYVIMRC

nnoremap <silent> <F12> :TagbarToggle<CR>
nnoremap <silent> <F2> :NERDTreeToggle<CR>
nnoremap <silent> <F3> :noh<CR>
nnoremap <silent> <F4> :Ztest<CR>
nnoremap <silent> <F6> :! bundle exec ripper-tags -R .<CR>

set colorcolumn=120
let g:NERDTreeWinSize = 40

command! Ztest :call RunCurrentSpecFile()

let g:tagbar_left = 1
let g:tagbar_width = 40
let g:tagbar_autofocus = 1

map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

set ttimeoutlen=100 " decrease timeout for faster insert with 'O' "
set scrolloff=2
set shell=/bin/sh
set term=screen-256color
set wildignore+=*/tmp/*,*/coverage/*,*/log/*,*/bin/*,tags,*/spec/reports/*

" set cursorline
" set cursorcolumn
noremap <Leader>cl :set cursorline!<CR>
noremap <Leader>cc :set cursorcolumn!<CR>
