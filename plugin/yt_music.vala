public void plugin_init(){

    Gtk.ScrolledWindow scrolled = new Gtk.ScrolledWindow (null, null);
    WebKit.WebView web = new WebKit.WebView();
    web.load_uri("https://music.youtube.com/");
    scrolled.add (web);
    scrolled.show_all();
    scrolled.set_size_request(400,400);
    main_widget.add_feature("Youtube Music", scrolled);
}
