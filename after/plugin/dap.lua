local dap = require('dap')
local widgets = require('dap.ui.widgets')
local my_sidebar = widgets.sidebar(widgets.scopes)



dap.configurations.go = {
    {
        type = 'go',
        name = 'Debug current file default',
        request = 'launch',
        program = '${file}',
    }
}

dap.adapters.go = {
    type = "server",
    port = "${port}",
    executable = {
        command = vim.fn.stdpath("data") .. '/mason/bin/dlv',
        args = { "dap", "-l", "127.0.0.1:${port}" },
    },
}

require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

dap.configurations.python = {
    {
        type = 'python',
        name = 'Debug current file default',
        request = 'launch',
        program = '${file}',
    }
}

vim.fn.sign_define('DapBreakpoint', { text = "🪅", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define('DapStopped', { text = "👀", texthl = "", linehl = "DiffText", numhl = "" })

-- open inspect a variable
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function() require('dap.ui.widgets').hover() end)

-- open inspect all variables in scope with side window
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function() my_sidebar.open() end)

-- close inspect all variables in scope with side window
vim.keymap.set({ 'n', 'v' }, '<Leader>pc', function() my_sidebar.close() end)

-- begin debug session
vim.keymap.set("n", "<leader>sb", function() dap.continue({ new = true }) end)

-- end debug session
vim.keymap.set("n", "<leader>se", function() dap.close() end)
vim.keymap.set("n", "<F5>", function() dap.continue() end)
vim.keymap.set("n", "<F6>", function() dap.step_over() end)
vim.keymap.set("n", "<F7>", function() dap.step_into() end)
vim.keymap.set("n", "<F8>", function() dap.step_out() end)
vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end)
vim.keymap.set("n", "<leader>cb", function() dap.clear_breakpoints() end)


require('dap.ext.vscode').load_launchjs()
