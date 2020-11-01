local vim = vim
local M = {}

function M.find_files()
    -- command for find file
    local ignore_globs = {
        ".git",
        ".ropeproject",
        "__pycache__",
        ".venv",
        "venv",
        "node_modules",
        "images",
        "*.min.*",
        "img",
        "fonts"
    }
    local cmd = nil;
    if vim.fn.executable("fd") then
        cmd = {
            "fd",
            ".",
            "--hidden",
            "--type",
            "f"
        }
        for _, x in ipairs(ignore_globs) do
            table.insert(cmd, "--exclude")
            table.insert(cmd, x)
        end
    elseif vim.fn.executable("rg") then
        cmd = {
            "rg",
            "--follow",
            "--hidden",
            "--files"
        }
        for _, x in ipairs(ignore_globs) do
            table.insert(cmd, "--glob=!" .. x)
        end
    elseif vim.fn.executable("ag") then
        cmd = {
            "ag",
            "-U",
            "--hidden",
            "--follow"
        }
        for _, x in ipairs(ignore_globs) do
            table.insert(cmd, "--exclude=" .. x)
        end
        for _, x in ipairs({
            "--nocolor",
            "--nogroup",
            "-g",
            ""
        }) do
            table.insert(cmd, x)
        end
    end

    require'telescope.builtin'.find_files {
        find_command = cmd
    }
end

return M