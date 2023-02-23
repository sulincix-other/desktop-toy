public string readfile(string path){
    string ret = "";
    File file = File.new_for_path (path);
    try {
        FileInputStream @is = file.read ();
        DataInputStream dis = new DataInputStream (@is);
        string line;
        while ((line = dis.read_line ()) != null) {
            ret += line+"\n";
        }
    } catch (Error e) {
        print ("Error: %s\n", e.message);
    }
    return ret;
}

public bool isfile(string path){
    return GLib.FileUtils.test(path, GLib.FileTest.IS_REGULAR);
}

public extern string load_plugin(string path);
