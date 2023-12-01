local lgi = require("lgi")
local Gtk = lgi.require('Gtk', '3.0')
local Gdk = lgi.require('Gdk', '3.0')
local GLib = lgi.require("GLib", "2.0")
local Cairo = lgi.require("cairo")
local lsh = lgi.GtkLayerShell
package.path = "./?.lua"
local window = require("src.window")
--chatgpt told me i can silence normal lua errors with this, should make it easier
local function customErrorHandler(err)
    print(err)
end
local original_stdout = io.stdout
local original_stderr = io.stderr
local dummy_stream = { write = function() end }
io.stdout = dummy_stream
io.stderr = dummy_stream
local succ, err = pcall(window.createMainWindow, Gtk, Gdk, lsh, GLib)
io.stdout = original_stdout
io.stderr = original_stderr
if not succ then
    customErrorHandler(err)
else
    print("[INFO] Created window")
    print("[INFO] Window is being displayed")
    pcall(window.run, Gtk)
end
