return {
    {
        'sudo-tee/opencode.nvim',
        enabled = false,
        config = function()
            require('opencode').setup {
                keymap = {
                    global = {
                        toggle = '<leader>og', -- Open opencode. Close if opened
                        open_input = '<leader>oi', -- Opens and focuses on input window on insert mode
                        open_input_new_session = '<leader>oI', -- Opens and focuses on input window on insert mode. Creates a new session
                        open_output = '<leader>oo', -- Opens and focuses on output window
                        toggle_focus = '<leader>ot', -- Toggle focus between opencode and last window
                        close = '<leader>oq', -- Close UI windows
                        select_session = '<leader>os', -- Select and load a opencode session
                        configure_provider = '<leader>op', -- Quick provider and model switch from predefined list
                        diff_open = '<leader>od', -- Opens a diff tab of a modified file since the last opencode prompt
                        diff_next = '<leader>o]', -- Navigate to next file diff
                        diff_prev = '<leader>o[', -- Navigate to previous file diff
                        diff_close = '<leader>oc', -- Close diff view tab and return to normal editing
                        diff_revert_all_last_prompt = '<leader>ora', -- Revert all file changes since the last opencode prompt
                        diff_revert_this_last_prompt = '<leader>ort', -- Revert current file changes since the last opencode prompt
                        diff_revert_all = '<leader>orA', -- Revert all file changes since the last opencode session
                        diff_revert_this = '<leader>orT', -- Revert current file changes since the last opencode session
                        swap_position = '<leader>ox', -- Swap Opencode pane left/right
                    },
                    window = {
                        submit = '<cr>', -- Submit prompt (normal mode)
                        submit_insert = '<cr>', -- Submit prompt (insert mode)
                        close = '<esc>', -- Close UI windows
                        stop = '<C-c>', -- Stop opencode while it is running
                        next_message = ']]', -- Navigate to next message in the conversation
                        prev_message = '[[', -- Navigate to previous message in the conversation
                        mention = '@', -- Insert mention (file/agent)
                        mention_file = '~', -- Pick a file and add to context. See File Mentions section
                        slash_commands = '/', -- Pick a command to run in the input window
                        toggle_pane = '<tab>', -- Toggle between input and output panes
                        prev_prompt_history = '<up>', -- Navigate to previous prompt in history
                        next_prompt_history = '<down>', -- Navigate to next prompt in history
                        switch_mode = '<M-m>', -- Switch between modes (build/plan)
                        focus_input = '<C-i>', -- Focus on input window and enter insert mode at the end of the input from the output window
                        select_child_session = '<leader>oS', -- Select and load a child session
                        debug_message = '<leader>oD', -- Open raw message in new buffer for debugging
                        debug_output = '<leader>oO', -- Open raw output in new buffer for debugging
                    },
                },
            }
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    anti_conceal = { enabled = false },
                    file_types = { 'markdown', 'opencode_output' },
                },
                ft = { 'markdown', 'opencode_output' },
            },
            -- Optional, for file mentions and commands completion, pick only one
            'saghen/blink.cmp',
            -- 'hrsh7th/nvim-cmp',

            -- Optional, for file mentions picker, pick only one
            -- 'folke/snacks.nvim',
            -- 'nvim-telescope/telescope.nvim',
            'ibhagwan/fzf-lua',
            -- 'nvim_mini/mini.nvim',
        },
    },
    {
        'folke/sidekick.nvim',
        opts = {
            cli = {
                tools = {
                    codex = {
                        cmd = { 'codex', '--sandbox', 'danger-full-access' },
                    },
                },
            },
        },
    },
}
