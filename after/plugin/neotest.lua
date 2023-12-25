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
            args = {"-count=1", "-v"}
        }),
        require("neotest-python")({
          -- Extra arguments for nvim-dap configuration
          -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
          dap = { justMyCode = false },
          -- Command line arguments for runner
          -- Can also be a function to return dynamic values
          -- args = {"--log-level", "DEBUG"},
          -- Runner to use. Will use pytest if available by default.
          -- Can be a function to return dynamic value.
          -- runner = "pytest",
          -- Custom python path for the runner.
          -- Can be a string or a list of strings.
          -- Can also be a function to return dynamic value.
          -- If not provided, the path will be inferred by checking for 
          -- virtual envs in the local directory and for Pipenev/Poetry configs
          -- python = ".venv/bin/python",
          -- Returns if a given file path is a test file.
          -- NB: This function is called a lot so don't perform any heavy tasks within it.
          -- is_test_file = function(file_path)
          -- end,
          -- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
          -- instances for files containing a parametrize mark (default: false)
          -- pytest_discover_instances = true,
        }),
        require("neotest-rust")
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
vim.keymap.set("n", "<leader>tr", function() require("neotest").run.run() end) -- run closest test to cursor
vim.keymap.set("n", "<leader>ta", function() require("neotest").run.run({ suite = true }) end) -- run all tests
vim.keymap.set("n", "<leader>tc", function() require("neotest").run.run({ suite = true, extra_args = {"-coverprofile='cover.out'"} }) end) -- run all tests and store coverage
vim.keymap.set("n", "<leader>td", function() require("neotest").diagnostic() end)
vim.keymap.set("n", "<leader>to", function() require("neotest").output_panel.toggle() end)
