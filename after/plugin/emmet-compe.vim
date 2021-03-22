if exists('g:loaded_compe') && exists('g:loaded_emmet_vim')
  if g:loaded_emmet_vim > 0
    lua require'compe'.register_source('emmet', require'emmet-compe')
  endif
endif
