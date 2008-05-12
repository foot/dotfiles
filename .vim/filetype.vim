" my filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.tem          setfiletype cpp
  au! BufRead,BufNewFile *.as           setfiletype actionscript
augroup END

runtime! ftdetect/*.vim
