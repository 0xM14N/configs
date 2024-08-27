-- Set leader key
vim.g.mapleader = " "

-- Basic settings
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Show relative line numbers
vim.opt.tabstop = 4            -- Number of spaces tabs count for
vim.opt.shiftwidth = 4         -- Number of spaces to use for autoindent
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.smartindent = true     -- Smart indenting
vim.opt.wrap = false           -- Don't wrap lines

vim.cmd("h ighlight Normal guibg=NONE ctermbg=NONE")

-- Enable mouse support
vim.opt.mouse = "a"

-- Enable syntax highlighting
vim.cmd("syntax on")

-- Enable 24-bit RGB color in the TUI
vim.opt.termguicolors = true

-- Set up a basic status line
vim.opt.laststatus = 2
vim.opt.showmode = false

-- Plugin management with 'packer.nvim' (requires installation)
-- Install packer.nvim if not already installed
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd('packadd packer.nvim')
end

-- Plugins configuration
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'  -- Packer can manage itself
  use 'nvim-treesitter/nvim-treesitter'  -- Better syntax highlighting
  use 'nvim-lualine/lualine.nvim'  -- Statusline
  use 'nvim-telescope/telescope.nvim'  -- Fuzzy finder
  use 'neovim/nvim-lspconfig'  -- LSP
  use 'hrsh7th/nvim-cmp'  -- Autocompletion framework
  use 'hrsh7th/cmp-nvim-lsp'  -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-buffer'  -- Buffer source for nvim-cmp
  use 'hrsh7th/cmp-path'  -- Path source for nvim-cmp
  use 'hrsh7th/cmp-cmdline'  -- Cmdline source for nvim-cmp
  use 'L3MON4D3/LuaSnip'  -- Snippet engine
  use 'saadparwaiz1/cmp_luasnip'  -- Snippet source for nvim-cmp
  use ('Tsuzat/NeoSolarized.nvim')
-- Add more plugins here
end)
-- Lua

-- Configure lualine
require('lualine').setup {
  options = {
    theme = 'gruvbox',
    section_separators = '',
    component_separators = ''
  }
}
vim.cmd[[colorscheme NeoSolarized]]
-- Autocompletion setup
local cmp = require('cmp')
local lspconfig = require('lspconfig')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Configure LSP for JavaScript (using TypeScript language server)
lspconfig.tsserver.setup({
  on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end,
})
local ok_status, NeoSolarized = pcall(require, "NeoSolarized")

if not ok_status then
  return
end

-- Default Setting for NeoSolarized

NeoSolarized.setup {
  style = "dark", -- "dark" or "light"
  transparent = true, -- true/false; Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  enable_italics = true, -- Italics for different hightlight groups (eg. Statement, Condition, Comment, Include, >
  styles = {
    -- Style to be applied to different syntax groups
    comments = { italic = true },
    keywords = { italic = true },
    functions = { bold = true },
    variables = {},
    string = { italic = true },
    underline = true, -- true/false; for global underline
    undercurl = true, -- true/false; for global undercurl
  },
  -- Add specific hightlight groups
  on_highlights = function(highlights, colors)
    -- highlights.Include.fg = colors.red -- Using `red` foreground for Includes
  end,
}
-- Set colorscheme to NeoSolarized
vim.cmd [[
   try
        colorscheme NeoSolarized
    catch /^Vim\%((\a\+)\)\=:E18o
        colorscheme default
        set background=dark
    endtry
]]
