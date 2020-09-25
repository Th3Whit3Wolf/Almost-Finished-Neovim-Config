-- And now for some examples of snippets I actually use.
local snippets = require 'snippets'
local U = require 'snippets.utils'


snippets.snippets = {
    lua = {
        req = [[local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = require '$1']],
        func = [[function${1|vim.trim(S.v):gsub("^%S"," %0")}(${2|vim.trim(S.v)})$0 end]],
        ["local"] = [[local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = ${1}]],
        -- Match the indentation of the current line for newlines.
        ["for"] = U.match_indentation [[
for ${1:i}, ${2:v} in ipairs(${3:t}) do
  $0
end]]
    },
    rust = {
        macro = U.match_indentation [[
macro_rules! ${1:name} {
  ($2) => {
    $0
  }
}
]],
        type = [[type $1 = $2;]],
        struct = U.match_indentation [[
struct $1 {
  $0
}]],
        enum = U.match_indentation [[
enum $1 {
  $0
}]],
        -- TODO(ashkan, 2020-08-19 05:33:54+0900) case change from TitleCase to snake_case for last element of ::
        field = [[$1: $2,]],
        -- field = [[${2=R.case_change.S[1]..}: $1,]];
        impl = U.match_indentation [[
impl $1 {
  $0
}
]],
        hashmap = [[use std::collections::HashMap;]],
        hashset = [[use std::collections::HashSet;]],
        collections = [[use std::collections::$1;]],
        match = U.match_indentation [[
match $1 {
  $0
}]],
        bcase = U.match_indentation [[
$1 => {
  $0
}]],
        case = U.match_indentation [[$1 => $0,]]
    },
    _global = {
        -- If you aren't inside of a comment, make the line a comment.
        copyright = U.force_comment [[Copyright (C) Ashkan Kiani ${=os.date("%Y")}]]
    }
}
