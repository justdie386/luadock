local checker = {}
function checker.check()
    local env = os.getenv("XDG_SESSION_TYPE")
    if env == "wayland" then
        if not checkWlroots() then
            print("[INFO] wayland is detected")
            return "wayland"
        else
            print("[INFO] wlroots wayland is detected")
            return "wlroots"
        end
    elseif env == "x11" then
        print("[INFO] x11 is detected")
        return "x11"
    end
end

 function checkWlroots()
    local output = io.popen("ldd $(which sway) | grep wlroots")
    for k, v in output:lines() do
        if string.match(k, "wlroots") then
            return true
        end
    end
end

return checker
