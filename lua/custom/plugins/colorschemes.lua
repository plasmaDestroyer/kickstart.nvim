return {
  -- 1. TokyoNight (Updated for your current setup)
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        style = 'night', -- "night" or "storm" are great for dark translucent looks
        transparent = false, -- Keep background for translucency
        styles = {
          comments = { italic = false },
        },
      }
      -- NOTE: Do not call `colorscheme` here. Only the GitHub theme below sets
      -- the active colorscheme, otherwise two startup plugins race to set it.
    end,
  },

  -- 2. Catppuccin
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha', -- The darkest flavor
        transparent_background = false,
        styles = { comments = {} },
      }
    end,
  },

  -- 3. Rose-pine
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        variant = 'main', -- Deep dark purple/charcoal
        styles = { italic = false },
        disable_background = false,
      }
    end,
  },

  -- 4. Kanagawa
  {
    'rebelot/kanagawa.nvim',
    config = function()
      require('kanagawa').setup {
        theme = 'dragon', -- "dragon" is the darkest, heaviest variant
        transparent = false,
        commentStyle = { italic = false },
      }
    end,
  },

  -- 5. Everforest
  {
    'sainnhe/everforest',
    config = function()
      vim.g.everforest_background = 'hard' -- Darkest green background
      vim.g.everforest_transparent_background = 0
      vim.g.everforest_italic = 0
    end,
  },

  -- 6. Nord
  {
    'shaunsingh/nord.nvim',
    config = function()
      vim.g.nord_disable_background = false
      vim.g.nord_italic = false
    end,
  },

  -- 7. Gruvbox
  {
    'ellisonleao/gruvbox.nvim',
    config = function()
      require('gruvbox').setup {
        palette_overrides = { dark0_hard = '#1d2021' }, -- Deepens the black
        transparent_mode = false,
        italic = { comments = false },
      }
    end,
  },
  -- 8. Github
  {
    'projekt0n/github-nvim-theme',
    lazy = false, -- Load colorscheme during startup
    priority = 1001, -- Highest priority: this is the one plugin that sets `colorscheme`
    config = function()
      require('github-theme').setup {
        -- Optional configuration
      }
      vim.cmd 'colorscheme github_dark_high_contrast'
    end,
  },
}
