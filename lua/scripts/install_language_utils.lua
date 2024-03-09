local os = require("os")
local ft_opts = require("utils.variables").Ft_Opts

function InstallAllLanguageTools()
    local package_list = {}

    for _, language in pairs(ft_opts) do
        for _, tool_type in pairs(language) do
            table.insert(package_list, tool_type.package_name)
        end
    end

    local command = "paru -S --needed " .. table.concat(package_list, " ")
    print("Executing command:", command)
    os.execute(command)
end

function CheckUpdatesForLanguageTools()
    local package_list = {}

    for _, language in pairs(ft_opts) do
        for _, tool_type in pairs(language) do
            table.insert(package_list, tool_type.package_name)
        end
    end

    local command = "paru -Syu " .. table.concat(package_list, " ")
    print("Executing command:", command)
    os.execute(command)
end

InstallAllLanguageTools()
