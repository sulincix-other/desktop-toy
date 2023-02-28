public void plugin_init(){
    stdout.printf("Hello world\n");
    var label = new Gtk.Label("Hello World");
    main_widget.add_feature("Hello World",label);
}
