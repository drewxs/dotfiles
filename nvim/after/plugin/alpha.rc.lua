local status, alpha = pcall(require, 'alpha')
if (not status) then return end

local dashboard = require('alpha.themes.dashboard')
math.randomseed(os.time())

local logo = {
  '▄████▄   ▒█████  ▓█████▄ ▓█████  ',
  '▒██▀ ▀█  ▒██▒  ██▒▒██▀ ██▌▓█   ▀ ',
  '▒▓█    ▄ ▒██░  ██▒░██   █▌▒███   ',
  '▒▓▓▄ ▄██▒▒██   ██░░▓█▄   ▌▒▓█  ▄ ',
  '▒ ▓███▀ ░░ ████▓▒░░▒████▓ ░▒████▒',
  '░ ░▒ ▒  ░░ ▒░▒░▒░  ▒▒▓  ▒ ░░ ▒░ ░',
  '  ░  ▒     ░ ▒ ▒░  ░ ▒  ▒  ░ ░  ░',
  '░        ░ ░ ░ ▒   ░ ░  ░    ░   ',
  '░ ░          ░ ░     ░       ░  ░',
  '░                  ░             '
}
dashboard.section.header.val = logo
dashboard.section.header.opts.hl = 'AlphaHeader'

local function button(sc, txt, keybind, keybind_opts)
  local b = dashboard.button(sc, txt, keybind, keybind_opts)
  b.opts.hl = 'AlphaButton'
  b.opts.hl_shortcut = 'AlphaButton'
  return b
end

dashboard.section.buttons.val = {
  button('Ctrl + B', '  File Explorer', ':NvimTreeToggle<cr>'),
  button('Ctrl + \\', '  Open Terminal', ':ToggleTerm<cr>'),
  button('Leader + f', '  Find File', ':Telescope find_files <cr>'),
  button('Leader + F', '  Find Word', ':Telescope live_grep<cr>'),
  button('q', '  Quit', ':qa<cr>')
}

local heading = {
  type = 'text',
  val = 'System.exit()?',
  opts = {
    position = 'center',
    hl = 'AlphaComment',
  },
}

local function footer()
  local total_plugins = #vim.tbl_keys(packer_plugins)

  return 'Loaded ' .. total_plugins .. ' plugins  '
end

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = 'AlphaFooter'
local opts = {
  layout = {
    { type = 'padding', val = 5 },
    dashboard.section.header,
    { type = 'padding', val = 3 },
    heading,
    { type = 'padding', val = 2 },
    dashboard.section.buttons,
    { type = 'padding', val = 1 },
    dashboard.section.footer,
  },
  opts = {
    margin = 5
  },
}
alpha.setup(opts)
vim.cmd([[ autocmd FileType alpha setlocal nofoldenable]])
vim.api.nvim_create_augroup('alpha_tabline', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = 'alpha_tabline',
  pattern = 'alpha',
  command = 'set showtabline=0 laststatus=0 noruler',
})

vim.api.nvim_create_autocmd('FileType', {
  group = 'alpha_tabline',
  pattern = 'alpha',
  callback = function()
    vim.api.nvim_create_autocmd('BufUnload', {
      group = 'alpha_tabline',
      buffer = 0,
      command = 'set showtabline=2 ruler laststatus=3',
    })
  end,
})
