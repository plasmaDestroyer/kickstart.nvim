-- ~/.config/nvim/lua/custom/plugins/cp.lua

return {
  {
    'xeluxee/competitest.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
      -- 1421/A.cpp — contest id + problem letter off the URL, since $(CONTEST)/$(PROBLEM) carry spaces
      local function ids(task)
        local url = task.url or ''
        -- /contest/1421/problem/A and /gym/104555/problem/B
        local contest, letter = url:match '/(%d+)/problem/(%w+)'
        if not contest then -- /problemset/problem/1421/A
          contest, letter = url:match '/problem/(%d+)/(%w+)'
        end
        if not contest then -- ponytail: non-codeforces fallback, just squash spaces
          contest = (task.group or 'misc'):gsub('%W', '')
          letter = (task.name or 'X'):gsub('%W', '')
        end
        return contest, letter
      end

      require('competitest').setup {
        received_problems_path = function(task, ext)
          local c, p = ids(task)
          return string.format('%s/cp/%s/%s.%s', vim.env.HOME, c, p, ext)
        end,
        received_problems_prompt_path = true,
        received_contests_directory = function(task)
          local c = ids(task)
          return string.format('%s/cp/%s', vim.env.HOME, c)
        end,
        received_contests_problems_path = function(task, ext)
          local _, p = ids(task)
          return string.format('%s.%s', p, ext)
        end,
        template_file = '$(HOME)/cp/template.$(FEXT)',
        evaluate_template_modifiers = true,
        companion_port = 10045,
        receive_print_message = true,

        compile_command = {
          cpp = {
            exec = 'g++',
            args = {
              '-std=c++23',
              '-O2',
              '-Wall',
              '-Wextra',
              '-Wshadow',
              '-D_GLIBCXX_DEBUG',
              '-fsanitize=address,undefined',
              '-g',
              '$(FNAME)',
              '-o',
              '$(FNOEXT)',
            },
          },
        },
        run_command = { cpp = { exec = './$(FNOEXT)' } },
      }

      -- keymaps here — scoped inside config so they load after plugin
      local map = vim.keymap.set
      map('n', '<leader>cp', ':CompetiTest receive problem<CR>', { desc = '[C]P receive [P]roblem', silent = true })
      map('n', '<leader>cc', ':CompetiTest receive contest<CR>', { desc = '[C]P receive [C]ontest', silent = true })
      map('n', '<leader>tr', ':CompetiTest run<CR>', { desc = '[T]est [R]un', silent = true })
      map('n', '<leader>ts', ':CompetiTest show_ui<CR>', { desc = '[T]est [S]how UI', silent = true })
      map('n', '<leader>cr', ':CompetiTest run<CR>', { desc = '[C]P [R]un', silent = true })
      map('n', '<leader>ca', ':CompetiTest add_testcase<CR>', { desc = '[C]P [A]dd testcase', silent = true })
      map('n', '<leader>ce', ':CompetiTest edit_testcase<CR>', { desc = '[C]P [E]dit testcase', silent = true })
      map('n', '<leader>cR', ':CompetiTest receive problem<CR>', { desc = '[C]P [R]eceive problem', silent = true })
      map('n', '<leader>cC', ':CompetiTest receive contest<CR>', { desc = '[C]P receive [C]ontest', silent = true })
      map('n', '<leader>cs', '<cmd>e /tmp/scratch.cpp<cr>', { desc = '[C]P [S]cratch buffer', silent = true })
    end,
  },
}
