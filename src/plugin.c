#include <dlfcn.h>

void load_plugin_c(char* path){
    void *handle;
    handle = dlopen(path, RTLD_LAZY);
    void (*plugin_func)();
    *(void**)(&plugin_func) = dlsym(handle, "plugin_init");
    plugin_func();
}
