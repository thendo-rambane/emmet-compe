if exists('g:loaded_compe') && exists('g:loaded_emmet')
  lua require'compe'.register_source('emmet', require'emmet-compe')
endif
