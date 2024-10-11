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
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'

-- Indent using Tab in visual mode
vim.api.nvim_set_keymap('v', '<Tab>', '>gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', { noremap = true, silent = true })
-- Map Ctrl + S to :w (save) in Normal mode
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-s>', '<Esc>:w<CR>gv', { noremap = true, silent = true })
-- Map Ctrl + z to go one step back
vim.api.nvim_set_keymap('n', '<C-z>','u',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-z>','<Esc>ui',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-z>','<Esc>u',{ noremap = true, silent = true })
-- Map Ctrl + q to quit the file
vim.api.nvim_set_keymap('n', '<C-q>',':wq<CR>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-q>','<Esc>:wq<CR>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-q>','<Esc>:wq<CR>',{ noremap = true, silent = true })


vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
-- comment test 12312312xaxaxaxaxa
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
  use  'nvim-tree/nvim-tree.lua'
  use ('Tsuzat/NeoSolarized.nvim')
  use 'windwp/nvim-ts-autotag'
  use 'nvim-tree/nvim-web-devicons'  -- File icons
  use 'nvim-lua/plenary.nvim'  -- Required dependency for Telescope

-- Add more plugins here
end)
-- LuaSnip
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "typescript", "tsx", "json", "html", "css" },
  highlight = {
    enable = true,
  },
    autotag = {
    enable = true,  -- Enable nvim-ts-autotag
  }
}

-- Configure lualine
require('lualine').setup {
  options = {
    theme = 'gruvbox',
    section_separators = '',
    component_separators = ''
  }
}

require'nvim-tree'.setup {
  view = {
    side = 'left',  -- Position of the explorer (left or right)
  },
  filters = {
    dotfiles = false,  -- Show or hide dotfiles
  },
  git = {
    enable = true,  -- Show git status icons
  }
}

-- Function to toggle focus on the NvimTree
function ToggleNvimTreeFocus()
  local nvim_tree = require("nvim-tree")
  local is_tree_open = require("nvim-tree.view").is_visible()  -- Check if the tree is open
  
  if is_tree_open then
    -- If the tree is open, focus on it
    vim.cmd("NvimTreeFocus")
  else
    -- If the tree is not open, toggle it open
    nvim_tree.toggle({ focus = true })  -- Ensure it opens focused
  end
end
-- enabling the file tree
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- Keymapping to move focus to the file tree
vim.api.nvim_set_keymap('n', '<C-e>', ':lua ToggleNvimTreeFocus()<CR>', { noremap = true, silent = true })


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
lspconfig.ts_ls.setup({
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
  enable_italics = true, -- Italics for different hightlight groups (eg. Statement, Condition, Comment, Include, etc.)
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
    catch /^Vim\%((\a\+)\)\=:E18/
        colorscheme default
        set background=dark
    endtry
]]


-- Load Telescope
require('telescope').setup{
  defaults = {
    prompt_prefix = "> ",  -- Prefix shown in prompt
    selection_caret = "> ",  -- Character for selected item
    layout_config = {
      horizontal = {
        mirror = false,  -- Set to true to flip the layout horizontally
      },
      vertical = {
        mirror = false,  -- Set to true to flip the layout vertically
      },
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown",  -- Change appearance of file finder
    },
    live_grep = {
      theme = "dropdown",
    },
  },
}

-- Key mappings for Telescope commands
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })  -- Find files
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })  -- Live grep
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })  -- List buffers
vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true })  -- Help tags
