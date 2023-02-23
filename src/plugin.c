#include <dlfcn.h>
#include <glib.h>

void load_plugin_c(char* path){
    void *handle;
    handle = dlopen(path, RTLD_LAZY);
    if (!handle) {
        g_printerr("%s\n", dlerror());
        return;
    }
    dlerror();
    void (*plugin_func)();
    *(void**)(&plugin_func) = dlsym(handle, "plugin_init");
    plugin_func();
    // dlclose does not used. Because plugins may use other plugin as dependency.

}
