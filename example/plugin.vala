/* example plugin
 for build You must use this command
      valac plugin.vala \
          --library=libtoy_plugin \
          -o libtoy_plugin.so
          --pkg gtk+-3.0 \
          --pkg toy \
          --vapidir=../build/ \
           -X -fpic -X -I../build -X -shared
*/
public void plugin_init(){
    stdout.printf("Hello world\n");
    var label = new Gtk.Label("Hello World");
    main_widget.add_feature("Hello World",label);
}
