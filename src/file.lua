local username = os.getenv("USER")
package.path = "/home/" .. username .. "/.config/luadock/?"

local file = {}


function file.configFileExists(config)
    local fileContent = false
    local filePath = "/home/" .. username .. "/.config/luadock/" .. config
    local fileIsReal = io.open(filePath, "r")
    if fileIsReal then
        io.close(fileIsReal)
        if string.find(config, ".lua") then
            local fileContent, err = loadfile(filePath)
            if err then
                print("[ERROR] Error loading config file:", err)
                return false
            elseif fileContent then
                local success, result = pcall(fileContent)
                if success then
                    return result
                else
                    print("[ERROR] Error executing config file:", result)
                    return false
                end
            end
        else
            return true
        end
    else
        print("[ERROR] Config file not found:", filePath)
        return false
    end
end

return file
