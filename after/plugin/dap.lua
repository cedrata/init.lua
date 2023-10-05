local dap = require('dap')
local widgets = require('dap.ui.widgets')



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

vim.fn.sign_define('DapBreakpoint', { text = "🪅", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define('DapStopped', { text = "👀", texthl = "", linehl = "", numhl = "" })

-- open inspect a variable
vim.keymap.set({ "n", "v" }, "<leader>dh", function()
    widgets.hover()
end)

-- begin debug session
vim.keymap.set("n", "<leader>sb", function()
    dap.continue({ new = true })
    -- dap.repl.toggle()
end)

-- end debug session
vim.keymap.set("n", "<leader>se", function()
    dap.close()
    -- dap.repl.toggle()
end)

-- continue session
vim.keymap.set("n", "<F5>", function() dap.continue() end)

-- step over
vim.keymap.set("n", "<F8>", function() dap.step_over() end)

-- step in
vim.keymap.set("n", "<F9>", function() dap.step_into() end)

-- step out
vim.keymap.set("n", "<F10>", function() dap.step_out() end)

-- toggle breakpoint
vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end)

-- clear breakpoints
vim.keymap.set("n", "<leader>cb", function() dap.clear_breakpoints() end)


require('dap.ext.vscode').load_launchjs()
