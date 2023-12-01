local function loadCss(css, Gtk, Gdk)
    local Provider = Gtk.CssProvider()
    Provider:load_from_path(css)
    local Screen = Gdk.Display.get_default_screen(Gdk.Display:get_default())
    local GTK_STYLE_PROVIDER_PRIORITY_APPLICATION = 600
    Gtk.StyleContext.add_provider_for_screen(
      Screen, Provider,
      GTK_STYLE_PROVIDER_PRIORITY_APPLICATION
    )
  end

return loadCss