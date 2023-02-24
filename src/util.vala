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
public int64 get_epoch(){
    return GLib.get_real_time () / 1000 ;
    GLib.DateTime now = new GLib.DateTime.now_local();
    return (now.to_unix() * 1000) + now.get_microsecond();
}
public string[] listdir(string path){
    string[] ret = {};
    string name;
    try{
        Dir dir = Dir.open(path+"/", 0);
        while ((name = dir.read_name ()) != null) {
            ret += name;
        }

    }catch(Error e){
        stderr.printf(e.message);
        return {};
    }
    return ret;
}
public bool startswith(string data,string f){
    if(data.length < f.length){
        return false;
    }
    return data[:f.length] == f;
}
public bool endswith(string data,string f){
    if(data.length < f.length){
        return false;
    }
    return data[data.length-f.length:] == f;
}
