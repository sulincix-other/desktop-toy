public int main(string[] args){
    Gtk.init(ref args);
    widget_init();
    plugin_manager_init();
    load_theme("amogus");
    main_widget.set_page("menu");
    Gtk.main();
    return 0;
}
