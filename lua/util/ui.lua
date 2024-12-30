return {
    -- optimized treesitter foldexpr for Neovim >= 0.10.0
    -- Taken from lazyvim/util/ui.lua
    foldexpr = function()
        local buf = vim.api.nvim_get_current_buf()
        if vim.b[buf].ts_folds == nil then
            local ft = vim.bo[buf].filetype
            -- as long as we don't have a filetype, don't bother
            -- checking if treesitter is available (it won't)
            if ft == '' then
                return '0'
            end

            -- Check if a custom query file exists for this filetype
            local query_path = string.format('%s/queries/%s/folds.scm', vim.fn.stdpath 'config', ft)

            if (vim.uv or vim.loop).fs_stat(query_path) then
                vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
            else
                vim.b[buf].ts_folds = false
            end
        end
        return vim.b[buf].ts_folds and vim.treesitter.foldexpr() or '0'
    end,
    smart_resize = function(direction)
        local win_id = vim.fn.win_getid()
        local win_pos = vim.fn.win_screenpos(win_id)
        local win_top = win_pos[1]
        local win_left = win_pos[2]
        local win_width = vim.fn.winwidth(0)
        local win_height = vim.fn.winheight(0)
        local total_width = vim.o.columns
        local total_height = vim.o.lines - vim.o.cmdheight

        if direction == 'up' then
            if win_top <= 2 then
                vim.cmd 'resize -2'
            else
                vim.cmd 'resize +2'
            end
        elseif direction == 'down' then
            if win_top + win_height + 1 >= total_height then
                vim.cmd 'resize -2'
            else
                vim.cmd 'resize +2'
            end
        elseif direction == 'left' then
            if win_left == 1 then
                vim.cmd 'vertical resize -2'
            else
                vim.cmd 'vertical resize +2'
            end
        elseif direction == 'right' then
            if win_left + win_width >= total_width then
                vim.cmd 'vertical resize -2'
            else
                vim.cmd 'vertical resize +2'
            end
        end
    end,
}
