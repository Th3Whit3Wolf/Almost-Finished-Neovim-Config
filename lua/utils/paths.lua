local vim = vim
local package = package

local path = {}

local function Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

local function reversedipairsiter(t, i)
    i = i - 1
    if i ~= 0 then
        return i, t[i]
    end
end
function reversedipairs(t)
    return reversedipairsiter, t, #t + 1
end



function path.to_table()
    local paths = Split(package.path, ";")
    print(vim.inspect(paths))
    for k,_ in pairs(paths) do
        if string.match(paths[k], "nvim/site/pack/") then
        count = count + 1
        end
    end
    print('plugins: ' .. count)
end


function path.lua_plugins()
    local len = string.len(vim.fn.stdpath("config") .. '/lua/') + 1
    for _,k in pairs(vim.fn.systemlist("fd . $HOME'/.config/nvim/lua/plugins' -t d -d 1")) do
        print(k)
        print(string.sub(k, len))
    end
end

function path.totalPlugins()
    local count = 0
    paths = {};
    for match in (package.path..';'):gmatch("(.-)"..';') do
        table.insert(paths, match);
    end
    for k,_ in pairs(paths) do
        if string.match(paths[k], "nvim/site/pack/") then
        count = count + 1
        end
    end
    return count
end

return path