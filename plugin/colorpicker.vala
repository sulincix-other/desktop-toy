public void plugin_init(){
    var color_picker = new Gtk.Button();
    color_picker.set_label("#000000");
    color_picker.clicked.connect(()=>{
        Gtk.ColorChooserDialog dialog = new Gtk.ColorChooserDialog ("Color picker", window);
            if (dialog.run () == Gtk.ResponseType.OK) {
                Gdk.RGBA color = dialog.rgba;
                string col = "#%02x%02x%02x"
                    .printf((uint)(255*color.red),
                    (uint)(255*color.green),
                    (uint)(255*color.blue));
                color_picker.set_label(col);
            }
        dialog.close ();
    });
    main_widget.menu.pack_start(color_picker,false,false);
    color_picker.get_style_context().add_class("button");
    color_picker.show();
}
