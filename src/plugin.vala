
private extern void load_plugin_c(string path);

private string[] enabled_plugins;

public void load_plugin(string path){
    if(path in enabled_plugins){
        return;
    }
    stdout.printf("Load plugin:"+path+"\n");
    load_plugin_c(path);
    enabled_plugins += path;
}
public void plugin_manager_init(){
    if(enabled_plugins == null){
        enabled_plugins = {};
    }
    foreach(string plugin in listdir("build")){
        if(startswith(plugin, "libtoy_") && endswith(plugin,".so")){
            load_plugin("build/"+plugin);
        }
    }
}
