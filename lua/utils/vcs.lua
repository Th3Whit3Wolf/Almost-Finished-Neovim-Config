vim = vim
local api = vim.api
local fn = vim.fn

local vcs = {}

--- Strip leading and lagging whitespace
local function trim(str)
    return str:gsub("^%s+", ""):gsub("%s+$", "")
end

--- Get project_root_dir for git repository
function vcs.project_root_dir()
    -- try file location first
    local gitdir = fn.system('cd "' .. fn.expand('%:p:h') .. '" && git rev-parse --show-toplevel')
    local isgitdir = fn.matchstr(gitdir, '^fatal:.*') == ""
    if isgitdir then
        return trim(gitdir)
    end

    -- try symlinked file location instead
    gitdir = fn.system('cd "' .. fn.fnamemodify(fn.resolve(fn.expand('%:p')), ':h') .. '" && git rev-parse --show-toplevel')
    isgitdir = fn.matchstr(gitdir, '^fatal:.*') == ""
    if isgitdir then
        return trim(gitdir)
    end

    -- just return current working directory
    return fn.getcwd(0, 0)
end

--- Determine whether or not in a git repository
function vcs.is_git()
    local path, status = vcs.project_root_dir()
    if status == 1 then
        return true
    else
        return false
    end
end

return vcs