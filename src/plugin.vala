
private extern void load_plugin_c(string path);

private string[] enabled_plugins;
public string plugin_directory;
public void load_plugin(string path){
    if(enabled_plugins == null){
        enabled_plugins = {};
    }
    if(path in enabled_plugins){
        return;
    }
    if(plugin_directory == null){
        return;
    }
    stdout.printf("Load plugin:"+path+"\n");
    load_plugin_c(plugin_directory+"/"+path);
    enabled_plugins += path;
}
public void plugin_manager_init(){
    if(plugin_directory == null){
        plugin_directory = "./build/";
    }
    foreach(string plugin in listdir(plugin_directory)){
        if(startswith(plugin, "libtoy_") && endswith(plugin,".so")){
            load_plugin(plugin);
        }
    }
}
