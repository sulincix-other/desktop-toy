public int main(string[] args){
    Gtk.init(ref args);
    widget_init();
    load_theme("amogus");
    plugin_manager_init();
    Gtk.main();
    return 0;
}
