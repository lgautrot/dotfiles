set number
set ruler
set showtabline=2
set tabline='%F'
set statusline='%F'
set title
set foldexpr=getline(v:lnum)[0]==\"\\#\"
set foldmethod=expr
syntax on
filetype plugin indent off
set noautoindent
set autowrite
