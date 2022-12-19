local status, onedarkpro = pcall(require, "onedarkpro")
if not status then
  return
end

onedarkpro.setup({
  colors = {}, -- Override default colors by specifying colors for 'onelight' or 'onedark' themes
  plugins = { -- Override which plugin highlight groups are loaded
    -- See the Supported Plugins section for a list of available plugins
  },
  styles = { -- Choose from 'bold,italic,underline'
    strings = "NONE", -- Style that is applied to strings.
    comments = "NONE", -- Style that is applied to comments
    keywords = "NONE", -- Style that is applied to keywords
    functions = "NONE", -- Style that is applied to functions
    variables = "NONE", -- Style that is applied to variables
    virtual_text = "NONE", -- Style that is applied to virtual text
  },
  options = {
    bold = true, -- Use the colorscheme's opinionated bold styles?
    italic = true, -- Use the colorscheme's opinionated italic styles?
    underline = true, -- Use the colorscheme's opinionated underline styles?
    undercurl = true, -- Use the colorscheme's opinionated undercurl styles?
    cursorline = true, -- Use cursorline highlighting?
    transparency = true, -- Use a transparent background?
    terminal_colors = true, -- Use the colorscheme's colors for Neovim's :terminal?
    highlight_inactive_windows = true, -- When the window is out of focus, change the normal background?
  },
})
