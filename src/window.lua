local username = os.getenv("USER")
package.path = "./?.lua"
local platformCheck = require("src.platform")
local file = require("src.file")
local buttons = require("src.buttons")
local loadCss = require("src.css")
local keybinds = require("src.keybinds")
local uiModule = {}

local function on_destroy()
    print("[INFO] shutting down...")
    os.exit()
end
local function platformSettings(platform, window, lsh, Gdk)
    if platform == "x11" then
        print("[ERROR] x11 should work, but it might not behave as excepted, pray...")
        window:set_type_hint(Gdk.WindowTypeHint.DIALOG)
        window:set_keep_above(true)
    elseif platform == "wayland" then
        print("[ERROR] normal wayland hasn't been figured out... \n except things to not work at all regarding to the window")
    elseif platform == "wlroots" then
        lsh.init_for_window(window)
        lsh.set_layer(window, lsh.Layer.TOP)
        lsh.set_keyboard_mode(window, 1)
    end
end
function uiModule.createMainWindow(Gtk, Gdk, lsh, GLib)
    local window = Gtk.Window {
        application = app,
        title = 'luaDock',
        decorated = false,
        default_width = 195,
        default_height = 195,
        on_destroy = on_destroy,
    }
    local iscontent = file.configFileExists("init.lua")
    if iscontent then
        Content = iscontent
    end
    if not file.configFileExists("window.css") then
        print("[ERROR] coudln't find window.css file")
    else
        loadCss("/home/"..username.."/.config/luadock/window.css", Gtk, Gdk)
    end
    window:add(buttons(Gtk, Gdk, GLib, Content, window))
    keybinds.setup(window, Gtk, Gdk)    
    local platform = platformCheck.check()
    platformSettings(platform, window, lsh, Gdk)
    window:show_all()

end

function uiModule.run(Gtk)
    Gtk.main()
end

return uiModule