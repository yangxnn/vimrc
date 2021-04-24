"设置编码"
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
colorscheme desert

set nu
set cursorline  " 突出显示当前行
set cursorcolumn  " 突出显示当前列
set showmatch   " 括号匹配
"设置Tab长度为4空格"
set tabstop=4
"设置自动缩进长度为4空格"
set shiftwidth=4
"继承前一行的缩进方式，适用于多行注释"
set autoindent

set paste  " 粘贴模式

colorscheme desert

"总是显示状态栏"
set laststatus=2
"显示光标当前位置"
set ruler

"自动开启语法高亮"
"syntax enable

" no clear screen when exit vim
" set t_ti= t_te=

" move cursor in insert mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" tags 配置 
set tags=./.tags;,.tags

" 插件管理
" 安装vim-plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')

Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'ludovicchabant/vim-gutentags'   " 异步自动生成tags 要求vim8.1
if has('nvim') || has('patch-8.0.902')  " The master branch is async-only and thus requires at least Vim 8.0.902. Use the legacy branch for older Vim versions.
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
" fzf#install() 确保你安装了最新的 fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'skywind3000/vim-auto-popmenu'  " 轻量级的补全提示
Plug 'skywind3000/vim-dict'

call plug#end()

" ludovicchabant/vim-gutentags配置
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" ------------------------ 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

if isdirectory("kernel/") && isdirectory("mm/")
    let g:gutentags_file_list_command = 'find arch/arm* arch/riscv block crypto drivers fs include init ipc kernel lib mm net security sound virt'
endif

" for rt-thread project
if isdirectory("libcpu/") && isdirectory("bsp/")
    let g:gutentags_file_list_command = 'find include libcpu src components examples bsp/rockchip* '
endif

" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数 "
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" -------------------------------------------

" ----------------------- 补全 参数
" Plug 'skywind3000/vim-auto-popmenu'
" 设定需要生效的文件类型，如果是 "*" 的话，代表所有类型
" let g:apc_enable_ft = {'text':1, 'markdown':1, 'php':1}
let g:apc_enable_ft = {'*':1}

" 设定从字典文件以及当前打开的文件里收集补全单词，详情看 ':help cpt'
set cpt=.,k,w,b

" 不要自动选中第一个选项。
set completeopt=menu,menuone,noselect

" 禁止在下方显示一些啰嗦的提示
set shortmess+=c
" 常用命令
" ApcEnable：为当前文档开启补全（比如你没有设置上面的 g:apc_enable_ft 时）。
" ApcDisable：为当前文档禁用补全



" --------------------------------------
