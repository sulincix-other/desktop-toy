public Gtk.Widget toy_create(){
    var main = new Gtk.Button();
    main.set_image(new Gtk.Image.from_icon_name("gtk-ok",Gtk.IconSize.BUTTON));
    main.clicked.connect((widget)=>{
        stdout.printf("Clicked\n");
    });
    return main;
}
