" perform concealment
set conceallevel=2
" don't ever show concealed characters
set concealcursor=niv

" show word wraps as underscore, this should be replaced by *
" when the markdown ftplugin loads
set showbreak=_


" this function opens the file sample.md into a popup window
" it is opened via the "e/edit" command
function! NoBug()
lua << EOF
  vim.cmd("e sample.md")
EOF
endfunction
nnoremap n :call NoBug()<CR>

" this function opens the file sample.md into a popup window,
" it is opend via bufadd and bufload
function! Bug()
lua << EOF
  local buf = vim.fn.bufadd("sample.md")
  vim.fn.bufload(buf)
  vim.api.nvim_win_set_buf(win, buf)
EOF
endfunction
nnoremap b :call Bug()<CR>
