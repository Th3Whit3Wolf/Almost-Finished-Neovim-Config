local U = require 'snippets.utils'

local snippets = {}

snippets = {
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
}

return snippets
