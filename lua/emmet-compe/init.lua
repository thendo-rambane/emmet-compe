local compe = require'compe'
local Emmet = {}

-- Calling emmet functions from lua causes issues
-- so...
vim.cmd[[
  function! GetLastWord()
    let line = trim(getline('.'))
    let words = split(line)
    return words[-1]
  endfunction
  function! EmmetComplete()
    let last_word = GetLastWord()
    let type = 'html'
    let tree_view = emmet#parseIntoTree(last_word, type).child[0]
    let indentation = emmet#getIndentation(type)
    let string_view = emmet#toString(tree_view, type, 0, [type], 0, indentation)
    return string_view
  endfunction
]]
function Emmet.get_metadata(_)
  return {
    priority = 1000,
    dup = 1,
    menu = '[Emmet]',
    filetypes = {"html", "htmldjango"}
  }
end

function Emmet.determine(_, context)
 return compe.helper.determine(context,{
    keyword_pattern = '[\\.\\h]*\\w*\\%([\\.\\>\\-\\#\\$\\*\\_]\\w*\\)*$',
 })
end

function Emmet.complete(_, context)
  local list = {}
  local word = vim.fn['GetLastWord']()
  table.insert(list, vim.fn['EmmetComplete']())
  local items = {}
  for _, expansion in pairs(list) do
    table.insert(items, {
      word = word,
      user_data = {
        emmet = {
          snippet = {expansion},
        }
      },
      empty = 1,
      preselect = 1,
      abbr = word,
      dup = 1
    })
  end

  context.callback({
    items = items
  })
end

function Emmet.documentation(_, args)
  local document = {}
  table.insert(document, '```' .. args.context.filetype)

  local expanded = vim.fn['EmmetComplete']()
  for _, line in ipairs(vim.split(expanded, "\n")) do
    table.insert(document, line)
  end
  table.insert(document, '```')
  args.callback(document)
end

function Emmet.confirm(_, _)
  vim.fn['emmet#expandAbbr'](0, '')
end
return Emmet
