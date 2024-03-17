require("coverage").setup({
    commands = true, -- create commands
    -- auto_reload = true,
    highlights = {
        -- customize highlight groups created by the plugin
        covered = { fg = "#C3E88D" }, -- supports style, fg, bg, sp (see :h highlight-gui)
        uncovered = { fg = "#F07178" },
    },
    signs = {
        -- use your own highlight groups or text markers
        covered = { hl = "CoverageCovered", text = "▎" },
        uncovered = { hl = "CoverageUncovered", text = "▎" },
    },
    summary = {
        -- customize the summary pop-up
        min_coverage = 70.0, -- minimum coverage threshold (used for highlighting)
    },
    lang = {
        -- customize language specific settings
        go = {
            coverage_file = "cover.out",
        },
    },
})

local cv = require("coverage")
vim.keymap.set("n", "<leader>cl", function() cv.load(true) end)
vim.keymap.set("n", "<leader>cs", function() cv.summary() end)
vim.keymap.set("n", "<leader>ch", function() cv.hide() end)
