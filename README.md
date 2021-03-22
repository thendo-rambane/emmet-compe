# EMMET-COMPE

Glue between [emmet-vim](https://github.com/mattn/emmet-vim), and
[nvim-compe](https://github.com/hrsh7th/nvim-compe) that allows for emmet
completion in html files.

## Requirements

[Neovim](https://github.com/neovim/neovim)
[emmet-vim](https://github.com/mattn/emmet-vim)
[nvim-compe](https://github.com/hrsh7th/nvim-compe)

## Installation

Using [Vim-Plug](https://github.com/junegunn/vim-plug)

```vimscript
  Plug 'hrsh7th/nvim-compe'
  Plug 'mattn/emmet-vim'
```


## Configuration

```lua
require'compe'.setup {
  source = {
      emmet = true
    }
}
```
