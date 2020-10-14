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
    ---print(vim.inspect(paths))
    for k,_ in pairs(paths) do
        local dirs = Split(paths[k], "/")
        for i=1, #dirs do
            if dirs[#dirs + 1 - i] == 'nvim-lspconfig' then
                print(paths[k])
                local str = table.concat(dirs , '/' , 1 , #dirs + 1 - i )
                print("path: " .. str)
                print(dirs[#dirs + 1 - i])
            end
        end
    end
end

return path