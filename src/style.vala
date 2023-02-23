public void style_init(string css){
    try {
        Gtk.CssProvider css_provider = new Gtk.CssProvider ();
        string css_data = "
        * {
            background: none;
            border: none;
        }";
        css_provider.load_from_data(css_data+css);
        Gtk.StyleContext.add_provider_for_screen (
            Gdk.Screen.get_default (),
            css_provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );
    }catch{
        stderr.printf("Failed to load css\n");
    }
}
