public void plugin_init(){
    Gtk.ColorChooserWidget widget = new Gtk.ColorChooserWidget ();
    widget.show_editor = true;
    main_widget.add_feature("Color Picker", widget);
}
