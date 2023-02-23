public Gtk.Widget toy_create(){
    var main = new Gtk.Button();
    string css_data = "";
    style_init(css_data);
    main.set_image(new Gtk.Image.from_file("./themes/amogus/idle.png"));
    main.set_relief(Gtk.ReliefStyle.NONE);
    main.set_can_focus(false);
    main.clicked.connect((widget)=>{
        stdout.printf("Clicked\n");
    });
    return main;
}
