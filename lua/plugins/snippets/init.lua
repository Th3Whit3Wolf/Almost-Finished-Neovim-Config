-- And now for some examples of snippets I actually use.
local snippets = require 'snippets'
local U = require 'snippets.utils'

snippets.snippets = {
    rust = require 'plugins/snippets/lang/rust',
    _global = {
        -- If you aren't inside of a comment, make the line a comment.
        copyright = U.force_comment [[Copyright (C) David Karrick ${=os.date("%Y")}]]
    }
}
