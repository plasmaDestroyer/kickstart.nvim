-- ~/.config/nvim/lua/custom/plugins/cp.lua

return {
  {
    'xeluxee/competitest.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
      require('competitest').setup {
        received_problems_path = '$(HOME)/cp/$(judge)/$(contest)/$(problem)/main.cpp',
        received_contests_directory = '$(HOME)/cp/$(judge)/$(contest)',
        template_file = '$(HOME)/cp/templates/base.cpp',
        evaluate_template_modifiers = true,
        companion_port = 10045,
        receive_print_message = true,

        compile_command = {
          exec = 'g++',
          args = {
            '-std=c++23',
            '-O2',
            '-Wall',
            '-Wextra',
            '-Wshadow',
            '-D_GLIBCXX_DEBUG',
            '-fsanitize=address,undefined',
            '$(FNAME)',
            '-o',
            '$(FNOEXT)',
          },
        },
        run_command = { exec = './$(FNOEXT)' },
      }

      -- keymaps here — scoped inside config so they load after plugin
      local map = vim.keymap.set
      map('n', '<leader>cp', ':CompetiTest receive problem<CR>', { desc = '[C]P receive [P]roblem', silent = true })
      map('n', '<leader>cc', ':CompetiTest receive contest<CR>', { desc = '[C]P receive [C]ontest', silent = true })
      map('n', '<leader>tr', ':CompetiTest run<CR>', { desc = '[T]est [R]un', silent = true })
      map('n', '<leader>ts', ':CompetiTest show_ui<CR>', { desc = '[T]est [S]how UI', silent = true })
    end,
  },
}
