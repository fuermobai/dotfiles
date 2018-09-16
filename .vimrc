" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
let skip_defaults_vim = 1
set softtabstop=4
set mouse=a
set t_Co=256
set nocompatible
set completeopt=longest,menu  " 让Vim的补全菜单行为与一般的IDE一致
set fileencodings=utf8,cp936,gb18030,big5
set number
filetype off
syntax on











" Position of cursor
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".",getpos("'\""))
augroup END









" YouCompleteMe
let g:ycm_global_ycm_extra_conf = '/home/libre/.vim/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_key_invoke_completion = '<c-a>'

autocmd InsertLeave * if pumvisible() == 0 | pclose | endif " 离开插入模式后自动关闭预览窗口
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"  
" 映射按键，没有这个会导致其他插件的Tab不能用
let g:ycm_key_list_select_completion=['TAB']
let g:ycm_key_list_previous_completion=['<S-TAB>']
let g:ycm_key_list_stop_completion=['<C-y>']
let g:ycm_collect_identifiers_from_tags_files=1  " 开启YouCompleteMe基于标签引
let g:ycm_min_num_of_chars_for_completion=2  " 从第2各键入字符就开始罗列匹配项
let g:ycm_use_ultisnips_completer=1 " Default 1，just ensure
let g:ycm_cache_omnifunc=0 " 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1 " 语法关键字补全
let g:ycm_complete_in_comments =1 " 在注释中使用补全
let g:ycm_max_num_candidates = 50 " 候选补全框内显示的补全条目的最大数量，仅限于基于语义的自动补全，不可为0或者大于100，无意义
let g:ycm_filetype_whitelist = {'*':1}
let g:ycm_filetype_blacklsit = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1
      \}     
let g:ycm_filetype_specific_completion_to_disable = {
      \ 'gitcommit' : 1
      \}

let g:ycm_complete_in_strings = 1
" UltiSnips

function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif
if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif


au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
