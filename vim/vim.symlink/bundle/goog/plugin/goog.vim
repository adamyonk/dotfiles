" Vim script that makes Vim a search results browser
" http://github.com/danchoi/goog
" Maintainer:	Daniel Choi <dhchoi@gmail.com>
" License: MIT License (c) 2012 Daniel Choi

if exists('g:GoogLoaded')
  finish
endif
let g:GoogLoaded = 1

let s:http_link_pattern = '^https\?:[^ >)\]]\+'

let g:gui_web_browser = system("echo -n $(which gnome-open || which open)")
if ! exists("g:text_web_browser")
  if executable("elinks") 
    let  g:text_web_browser = 'elinks -dump -no-numbering'
  elseif executable("lynx")
    let  g:text_web_browser = 'lynx -dump -nonumbers'
  elseif executable("links") 
    let  g:text_web_browser = 'links -dump'
  endif
end



func! s:open_href_under_cursor(text_browser)
  let res = search(s:http_link_pattern, 'cw')
  if res != 0
    let href = matchstr(expand("<cWORD>") , s:http_link_pattern)
    if a:text_browser == 0
      let command = g:gui_web_browser . " " . shellescape(href) . " "
      call system(command)
    else
      let command = g:text_web_browser . ' ' .  shellescape(href) . " "
      " echom command
      let result = system(command)
      exec "split ".tempname()
      silent! put! =result
      silent! 1put! ='URL: '.href 
      silent! 2put! =''
      setlocal buftype=nofile 
      normal 1G
    endif
  end
endfunc

func! s:find_next_link(backward)
  let n = 0
  " don't wrap
  if a:backward == 1 
    normal lb
    let result = search(s:http_link_pattern, 'Wb') 
  else
    let result = search(s:http_link_pattern, 'W')
  endif
  if (result == 0) 
    return ""
  end
  return 
endfunc


func! g:Goog_set_up_search_results_buffer()
  syntax region h1  start="^\d\+\."       end="\($\)" 
  syntax region href  start="^https\?:"     end="\($\)" 
  highlight link h1     Identifier
  highlight link href   Constant
  hi Identifier	term=NONE cterm=NONE gui=NONE ctermfg=LightCyan
  hi Constant  term=NONE cterm=NONE  gui=NONE ctermfg=Magenta
  nnoremap <buffer> <leader>o :call <SID>open_href_under_cursor(0)<CR>
  nnoremap <buffer> <leader>O :call <SID>open_href_under_cursor(1)<CR>
  noremap <buffer> <c-j> :call <SID>find_next_link(0)<CR>
  noremap <buffer> <c-k> :call <SID>find_next_link(1)<CR>
endfunc 

func! s:run_Goog_search(query)
  let g:Goog_running_in_vim = 1
  if !executable("goog") 
    echom "You don't have goog installed. Please gem install goog and try again."
    finish
  endif
  let res=system("goog ".shellescape(a:query))
  exec "split GoogSearchResults"
  silent! put! =res
  silent! 1put! ='query: 'query
  silent! 2put! =''
  setlocal buftype=nofile 
  normal 1G
  call g:Goog_set_up_search_results_buffer()
endfunc

command! -nargs=* Goog call <SID>run_Goog_search(<q-args>)

