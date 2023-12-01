local username = os.getenv("USER")
package.path = "./?.lua"
local loadCss = require("src.css")
local uimath = require("src.uimath")
local file = require("src.file")

local function createLauncherConter(Gtk, Gdk, GLib, content, Window)
    local correctButton = uimath.getCircleCoordinates(Window.default_width, Window.default_height, content)
    local container = Gtk.Fixed {
        visible = true
    }
    for k, v in pairs(correctButton) do
        local button = Gtk.Button {
            on_clicked = function(self)
                Window:get_style_context():add_class("fade-out-class")
                GLib.timeout_add_seconds(GLib.PRIORITY_DEFAULT, 0.2, function()
                    Window:hide()
                    os.exit()
                end)
                os.execute('gtk-launch ' .. v[2])
            end,
            visible = true
        }
        if not file.configFileExists(string.format("%s%s", v[1], ".css")) then
            print("[ERROR] couldn't find "..v[1]..".css")
        else
            loadCss("/home/"..username.."/.config/luadock/"..v[1]..".css", Gtk, Gdk)
        end
        button:set_size_request(50, 30)
        button:set_relief(Gtk.ReliefStyle.NONE)
        container:put(button, v[3].x, v[3].y)
        button:get_style_context():add_class(v[1])
    end
    return container
end


return createLauncherConter