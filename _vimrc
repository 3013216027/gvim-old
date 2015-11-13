" It's a vimrc file from gvim in Windows.
" Also suitable for Linux
" Besides, all the files(include the *.vim files have been pushed into
" 链接: http://pan.baidu.com/s/1ntmkhSl 密码: 175c)
" Last Edited by JBer
" 2015/03/16 4:15 p.m.
"
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

"set diffexpr=MyDiff()
"function MyDiff()
"  let opt = '-a --binary '
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"  let arg1 = v:fname_in
"  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"  let arg2 = v:fname_new
"  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"  let arg3 = v:fname_out
"  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"  let eq = ''
"  if $VIMRUNTIME =~ ' '
"    if &sh =~ '\<cmd'
"      let cmd = '""' . $VIMRUNTIME . '\diff"'
"      let eq = '"'
"    else
"      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"    endif
"  else
"    let cmd = $VIMRUNTIME . '\diff'
"  endif
"  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
"endfunction

"Added by JBer --- 2015/03/10 8:01 p.m.
" 定义快捷键的前缀，即<Leader>
let mapleader=";"
"文件类型侦测。允许基于不同语言加载不同插件（如，C++ 的语法高亮插件与 python 的不同）：
" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on
" 快捷键。把 vim（非插件）常用操作设定成快捷键，提升效率：
" 定义快捷键在结对符之间跳转，助记pair
nmap <Leader>pa %
" 其他。搜索、vim 命令补全等设置：
" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" 关闭兼容模式
set nocompatible
" vim 自身命令行模式智能补全
set wildmenu
" 禁用自动备份
set nobackup

" 设置配色方案-molokai.vim
syntax enable
colorscheme Monokai

" 禁止光标闪烁
set gcr=a:block-blinkon0

" 背景:暗色
"set bg=dark

"个人设置
execute pathogen#infect()

filetype on
set smartindent   "设置智能缩进
"set shortmess=atI "去掉欢迎界面
colorscheme monokai          "sublime的配色方案
set guifont=Consolas:h12      "字体与字号
set autoindent               " 自动对齐
set smartindent              " 智能自动缩进
set ai!                      " 设置自动缩进
set nu!                      " 显示行号
set mouse=a                  " 启用鼠标
set ruler                    " 右下角显示光标位置的状态行
set incsearch                " 查找book时，当输入/b时会自动找到
set hlsearch                 " 开启高亮显示结果
set incsearch                " 开启实时搜索功能
" set nowrapscan               " 搜索到文件两端时不重新搜索
set nocompatible             " 关闭兼容模式
set vb t_vb=                 " 关闭提示音
au GuiEnter * set t_vb=     " 禁用屏幕闪烁（多余命令屏幕均会闪烁）
" set hidden                   " 允许在有未保存的修改时切换缓冲区
" set list                     " 显示Tab符，使用一高亮竖线代替
" set listchars=tab:\|\ ,
syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype plugin indent on    " 启用自动补全

"gvim 版本为7.4.*
set encoding=utf-8
set fileencodings=utf-8,gbk,gb18030,gb2312
"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"解决consle输出乱码
language messages zh_CN.utf-8
"设置<F5>为快速编译运行C艹文件
"Linux下请修改相关命令
"定义CompileRun函数，用来调用进行编译和运行
func CompileRun()
exec "w"
"C程序
if &filetype == 'c'
exec "!gcc -Wl,-enable-auto-import % -g -o %<.exe"
"c++程序
elseif &filetype == 'cpp'
exec "!g++ -Wl,-enable-auto-import % -g -o %<.exe"
"Java程序
elseif &filetype == 'java'
exec "!javac %"
endif
call Run()
endfunc
"结束定义CompileRun
"定义Run函数
func Run()
if &filetype == 'c' || &filetype == 'cpp'
exec "!%<.exe"
elseif &filetype == 'java'
exec "!java %<"
endif
endfunc
"定义Debug函数，用来调试程序
func Debug()
exec "w"
"C程序
if &filetype == 'c'
exec "!gcc % -g -o %<.exe"
exec "!gdb %<.exe"
elseif &filetype == 'cpp'
exec "!g++ % -g -o %<.exe"
exec "!gdb %<.exe"
"Java程序
elseif &filetype == 'java'
exec "!javac %"
exec "!jdb %<"
endif
endfunc
"结束定义Debug
"设置程序的运行和调试的快捷键F5和Ctrl-F5
map <F5> :call CompileRun()<CR>
map <F6> :call Run()<CR>
map <C-F5> :call Debug()<CR>
"endfunc
"根据文件类型缩进,添加了:
"javascript[for node.js], python
if has("autocmd")
	autocmd FileType javascript,html,xhtml,css,xml,vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType python,py setlocal ts=2 sts=2 sw=2 expandtab
endif

"设置tab字符和回车字符
"set list
"set listchars=tab:>\ ,eol:+

map <F2> :call SetTitle()<CR>
map <C-F2> :call SetTitle2()<CR>
func SetTitle()
	let l = 0
	let l = l + 1 | call setline(l,'/* **********************************************')
	let l = l + 1 | call setline(l,'')
	let l = l + 1 | call setline(l,'    File Name: '.expand(bufname('%')))
	"let l = l + 1 | call setline(l,'    File Name: '.expand('%'))
	let l = l + 1 | call setline(l,'')
	let l = l + 1 | call setline(l,'    Author: zhengdongjian@tju.edu.cn')
	let l = l + 1 | call setline(l,'')
	let l = l + 1 | call setline(l,'    Created Time: '.strftime('%c'))
	let l = l + 1 | call setline(l,'')
	let l = l + 1 | call setline(l,'*********************************************** */')
	let l = l + 1 | call setline(l, '#include <bits/stdc++.h>')
	let l = l + 1 | call setline(l, 'using namespace std;')
	let l = l + 1 | call setline(l, '')
	let l = l + 1 | call setline(l, 'typedef long long ll;')
	let l = l + 1 | call setline(l, 'typedef pair<int, int> P;')
endfunc
func SetTitle2()
	let l = 0
	let l = l + 1 | call setline(l,'/* **********************************************')
	let l = l + 1 | call setline(l,'')
	let l = l + 1 | call setline(l,'    File Name: '.expand(bufname('%')))
	"let l = l + 1 | call setline(l,'    File Name: '.expand('%'))
	let l = l + 1 | call setline(l,'')
	let l = l + 1 | call setline(l,'    Author: zhengdongjian@tju.edu.cn')
	let l = l + 1 | call setline(l,'')
	let l = l + 1 | call setline(l,'    Created Time: '.strftime('%c'))
	let l = l + 1 | call setline(l,'')
	let l = l + 1 | call setline(l,'*********************************************** */')
	let l = l + 1 | call setline(l, '#include <map>')
	let l = l + 1 | call setline(l, '#include <set>')
	let l = l + 1 | call setline(l, '#include <list>')
	let l = l + 1 | call setline(l, '#include <cmath>')
	let l = l + 1 | call setline(l, '#include <ctime>')
	let l = l + 1 | call setline(l, '#include <deque>')
	let l = l + 1 | call setline(l, '#include <queue>')
	let l = l + 1 | call setline(l, '#include <stack>')
	let l = l + 1 | call setline(l, '#include <bitset>')
	let l = l + 1 | call setline(l, '#include <cstdio>')
	let l = l + 1 | call setline(l, '#include <string>')
	let l = l + 1 | call setline(l, '#include <vector>')
	let l = l + 1 | call setline(l, '#include <climits>')
	let l = l + 1 | call setline(l, '#include <complex>')
	let l = l + 1 | call setline(l, '#include <cstdlib>')
	let l = l + 1 | call setline(l, '#include <cstring>')
	let l = l + 1 | call setline(l, '#include <fstream>')
	let l = l + 1 | call setline(l, '#include <sstream>')
	let l = l + 1 | call setline(l, '#include <utility>')
	let l = l + 1 | call setline(l, '#include <iostream>')
	let l = l + 1 | call setline(l, '#include <algorithm>')
	let l = l + 1 | call setline(l, '#include <functional>')
	let l = l + 1 | call setline(l, 'using namespace std;')
	let l = l + 1 | call setline(l, '')
	let l = l + 1 | call setline(l, 'typedef long long ll;')
	let l = l + 1 | call setline(l, 'typedef pair<int, int> P;')
endfunc

