public void style_init(string css){
    try {
        Gtk.CssProvider css_provider = new Gtk.CssProvider ();
        Gtk.Settings.get_default().set("gtk-theme-name", "Adwaita");
        string css_data = """
        .window, decoration {
            padding: 0px;
            margin: 0px;
            background: none;
            border: none;
        }
        .button {
            padding: 0px;
            margin: 0px;
            background: none;
            border: none;
        }
        .menu {
            padding: 0px;
            margin: 0px;
            border: none;
        }
        """;
        css_provider.load_from_data(css_data+css);
        Gtk.StyleContext.add_provider_for_screen (
            Gdk.Screen.get_default (),
            css_provider,
            Gtk.STYLE_PROVIDER_PRIORITY_USER
        );
    }catch{
        stderr.printf("Failed to load css\n");
    }
}

public void load_theme(string name){
    string path = "";
    if(isfile("/usr/share/toy/"+name+"/theme.ini")){
        path = "/usr/share/toy/"+name;
    }else if(isfile("~/"+name+"/theme.ini")){
        path = "~/"+name;
    }else if(isfile("./themes/"+name+"/theme.ini")){
        path = "./themes/"+name;
    }
    style_init(readfile(path+"/style.css"));
    main_widget.theme_path = path;
    main_widget.load_animation("idle");
}
