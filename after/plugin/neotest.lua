-- get neotest namespace (api call creates or returns namespace)
local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
    virtual_text = {
        format = function(diagnostic)
            local message =
                diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
        end,
    },
}, neotest_ns)
require("neotest").setup({
    -- your neotest config here
    adapters = {
        require("neotest-go")({
            args = {"-count=1"}
        }),
    },
    icons = {
        child_indent = "│",
        child_prefix = "├",
        collapsed = "─",
        expanded = "╮",
        failed = "🔴",
        final_child_indent = " ",
        final_child_prefix = "╰",
        non_collapsible = "─",
        passed = "🟢",
        running = "⌚",
        running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
        skipped = "…",
        unknown = "❓",
        watching = "👀"
    }

})

vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end)
vim.keymap.set("n", "<leader>ta", function() require("neotest").run.run({ suite = true }) end)

