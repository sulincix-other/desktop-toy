public void plugin_init(){
    stdout.printf("Hello world\n");
    var label = new Gtk.Label("Hello World");
    main_widget.menu.pack_start(label,false,false);
    label.show_all();
}
