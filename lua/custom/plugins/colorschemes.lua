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
    config = function() require('github-theme').setup {} end,
  },

  -- 9. Active theme: caelestia (colors/caelestia.lua, follows the wallpaper
  -- scheme in ~/.local/state/caelestia/scheme.json). Transparent by default so
  -- ghostty's own blur/glass shows through.
  {
    dir = vim.fn.stdpath 'config', -- local spec: colors/caelestia.lua lives here
    name = 'caelestia-colors',
    lazy = false,
    priority = 1001, -- highest priority: the one spec that sets `colorscheme`
    config = function()
      vim.g.caelestia_transparent = true
      vim.cmd.colorscheme 'caelestia'

      -- <leader>ub toggles the background on/off
      vim.keymap.set('n', '<leader>ub', function()
        vim.g.caelestia_transparent = not vim.g.caelestia_transparent
        vim.cmd.colorscheme 'caelestia'
      end, { desc = 'Toggle transparent [b]ackground' })
    end,
  },
}
