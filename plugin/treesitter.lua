-- Install core parsers
require('nvim-treesitter').install { 'c', 'lua', 'vim', 'vimdoc', 'query' }

-- Enable treesitter highlighting for all filetypes
vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        local buf = args.buf
        -- Try to start highlighting; if parser is missing, auto-install it
        local started = pcall(vim.treesitter.start, buf)
        if not started then
            local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
            if lang then
                require('nvim-treesitter').install { lang }
            end
        end
    end,
})

require('treesitter-context').setup {
    enable = true,
    max_lines = 0,
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 20,
    trim_scope = 'outer',
    mode = 'cursor',
    separator = nil,
    zindex = 20,
    on_attach = nil,
}
