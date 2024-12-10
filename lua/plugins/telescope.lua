return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        local builtin = require("telescope.builtin")

        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)

        -- Keymap to change colorscheme using Telescope with live preview
        vim.keymap.set("n", "<leader>th", function()
            -- Fetch all available colorschemes
            local colorschemes = vim.fn.getcompletion("", "color")

            -- Open Telescope picker
            require("telescope.pickers").new({}, {
                prompt_title = "Select Colorscheme",
                finder = require("telescope.finders").new_table({
                    results = colorschemes
                }),
                sorter = require("telescope.config").values.generic_sorter({}),
                attach_mappings = function(prompt_bufnr, map)
                    local current_theme = vim.g.colors_name  -- Save the current theme before previewing
                    local function preview_colorscheme()
                        local selected = action_state.get_selected_entry()
                        if selected then
                            vim.cmd("colorscheme " .. selected[1])  -- Preview the theme
                        end
                    end

                    -- Restore the original theme if picker is canceled
                    actions.select_default:replace(function()
                        local selected = action_state.get_selected_entry()
                        if selected then
                            vim.cmd("colorscheme " .. selected[1])  -- Apply the theme on <CR>
                        else
                            vim.cmd("colorscheme " .. current_theme)  -- Restore original if nothing is selected
                        end
                        actions.close(prompt_bufnr)
                    end)

                    -- Preview the theme when navigating with Up/Down without selecting
                    map("i", "<Up>", function(prompt_bufnr)
                        actions.move_selection_previous(prompt_bufnr)
                        vim.defer_fn(preview_colorscheme, 10)  -- Slight delay for preview accuracy
                    end)
                    map("i", "<Down>", function(prompt_bufnr)
                        actions.move_selection_next(prompt_bufnr)
                        vim.defer_fn(preview_colorscheme, 10)  -- Slight delay for preview accuracy
                    end)

                    return true
                end
            }):find()
        end, { desc = "Telescope change theme with live preview" })

    end
}
