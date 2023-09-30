local dap = require('dap')

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

-- begin debug session
vim.keymap.set("n", "<leader>sb", function()
    dap.continue({ new = true })
    dap.repl.toggle()
end)

-- end debug session
vim.keymap.set("n", "<leader>se", function()
    dap.close()
    dap.repl.toggle()
end)

-- continue session
vim.keymap.set("n", "<leader>sc", function() dap.continue() end)

-- step over
vim.keymap.set("n", "<leader>so", function() dap.step_over() end)

-- step out
vim.keymap.set("n", "<leader>sp", function() dap.step_out() end)

-- step in
vim.keymap.set("n", "<leader>si", function() dap.step_into() end)

-- toggle breakpoint
vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end)

-- clear breakpoints
vim.keymap.set("n", "<leader>cb", function() dap.clear_breakpoints() end)


require('dap.ext.vscode').load_launchjs()
