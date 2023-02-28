public void plugin_init(){
    Gtk.TextView widget = new Gtk.TextView ();
    Gtk.ScrolledWindow scrolled = new Gtk.ScrolledWindow (null, null);
    widget.set_monospace(true);
    scrolled.add (widget);
    scrolled.show_all();
    scrolled.set_size_request(400,400);
    main_widget.add_feature("Note", scrolled);
}
