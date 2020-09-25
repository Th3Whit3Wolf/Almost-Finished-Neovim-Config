require 'plugins/lsp'
require 'plugins/snippets'

-- Requires termguicolors to be set
require'colorizer'.setup {
    '*', -- Highlight all files, but customize some others.
    css = {
        css = true
    }, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    html = {
        names = false
    } -- Disable parsing "names" like Blue or Gray
}
