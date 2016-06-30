set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
"
" My Bundles here:
"
"" original repos on github
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'romanvbabenko/rails.vim'
Bundle 'tComment'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rvm'
" Bundle "scrooloose/syntastic"
Bundle "tpope/vim-surround"

" non github repos
Bundle "tpope/vim-markdown.git"
Bundle "leshill/vim-json.git"

Bundle "slim-template/vim-slim.git"
Bundle "thoughtbot/vim-rspec"
Bundle "kchmck/vim-coffee-script.git"
Bundle "ngmy/vim-rubocop"

" Snippets support
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'

Bundle 'bkad/CamelCaseMotion'
Bundle 'majutsushi/tagbar'

Bundle 'Townk/vim-autoclose'

" Coloschemes
Bundle 'chriskempson/base16-vim'

Bundle 'rking/ag.vim'

Bundle 'tmhedberg/matchit'
Bundle "ConradIrwin/vim-bracketed-paste"
Bundle 'elixir-lang/vim-elixir'

Bundle 'tpope/vim-dispatch'
Bundle 'neomake/neomake'

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
set rnu
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

set splitbelow
set splitright
  

" Copy indent from current line when starting a new line
"set autoindent

" Automatically removing all trailing whitespace
autocmd BufWritePre *.rb,*.erb :%s/\s\+$//e

" File types autodetection
autocmd BufNewFile,BufRead *.txt setfiletype text
autocmd BufNewFile,BufRead Gemfile,Guardfile,Vagrantfile,Procfile,Rakefile setfiletype ruby
autocmd FileType text,markdown,html,xhtml,eruby,asc,slim setlocal wrap linebreak nolist

autocmd! BufWritePost * Neomake

" Statusline
if has("statusline") && !&cp
  set laststatus=2  " always show the status bar

  " Start the status line

  " set statusline=%{hostname()}:
  set statusline+=%f\ %m\ %r

  " Add rvm
  " if exists('$rvm_path')
  "   set statusline+=%{rvm#statusline()}
  " endif
  " Add fugitive
  set statusline+=%{fugitive#statusline()}

  " display a warning if &paste is set
  " set statusline+=%#error#
  set statusline+=%{&paste?'[paste]':''}
  set statusline+=%*

  " Finish the statusline
  set statusline+=Line:%l/%L[%p%%]
  set statusline+=Col:%v
  set statusline+=Buf:#%n
  set statusline+=[%b][0x%B]
endif

nnoremap <c-l> :bp <cr>
let mapleader = "\\"
map <leader>l :bp<esc>

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
" autocmd BufWritePost .vimrc source $MYVIMRC

nnoremap <silent> <F12> :TagbarToggle<CR>
nnoremap <silent> <F3> :noh<CR>
nnoremap <silent> <Leader>t :w\|:Ztest<CR>
nnoremap <silent> <Leader>r :w\|:call RunNearestSpec()<CR>
nnoremap <silent> <F6> :! bundle exec ripper-tags -R .<CR>

command! Ztest :call RunCurrentSpecFile()

let g:tagbar_left = 1
let g:tagbar_width = 40
let g:tagbar_autofocus = 1

set ttimeoutlen=100 " decrease timeout for faster insert with 'O' "
set scrolloff=2
set shell=/bin/sh
set wildignore+=*/tmp/*,*/coverage/*,*/log/*,*/bin/*,tags,*/spec/reports/*,*/.git/*,*/app/assets/images/*,*/public/system/*,*/public/assets/*,bin/*

noremap <Leader>cl :set cursorline!<CR>
noremap <Leader>cc :set cursorcolumn!<CR>

noremap <s-h> gT
noremap <s-l> gt

xnoremap <Tab> >gv
xnoremap <S-Tab> <gv

call camelcasemotion#CreateMotionMappings('<leader>')

let g:rspec_command = "Dispatch rspec --format d {spec}"

let g:vimrubocop_config = './.rubocop.yml'
let g:vimrubocop_extra_args = '--rails'

set mouse=""
let g:netrw_liststyle=3

colorscheme default
set background=dark
set re=1

let g:markdown_fenced_languages = ['html', 'javascript', 'ruby', 'bash=sh']
