local keybinds = {}
function keybinds.setup(window, Gtk, Gdk)
    window:add_events(Gdk.EventMask.KEY_PRESS_MASK)
    function window.on_key_press_event(widget, event)
        keybinds.listenUp(event, Gdk)
    end
end
function keybinds.listenUp(event, Gdk)
        if Gdk.keyval_name(event.keyval) == "Escape" then
            print("[INFO] shutting down...")
            os.exit()
        end
end
--imma be real i could've put this in another file...
return keybinds
