public class toy : Gtk.Box {
    public Gtk.Button main;
    public Gtk.Image image;
    public string theme_path;
    public toy(){
        main = new Gtk.Button();
        image = new Gtk.Image();
        main.set_image(image);
        main.clicked.connect((widget)=>{
            stdout.printf("Clicked\n");
        });
        add(main);
        show_all();
        anim_lock = false;
    }
    public void load_animation(string name){
        if(anim_name != name){
            anim_name = name;
            anim_i = 0;
            animate();
        }
    }
    private string anim_name;
    private int anim_i;
    private bool anim_lock;
    private bool animate(){
        if(anim_lock){
            return false;
        }
        anim_lock = true;
        if(isfile(theme_path+"/"+name+".png")){
            image.set_from_file(theme_path+"/"+name+".png");
        }else{
            image.set_from_file(theme_path+"/"+anim_name+"/"+anim_i.to_string()+".png");
            anim_i += 1;
            if(!isfile(theme_path+"/"+anim_name+"/"+anim_i.to_string()+".png")){
                anim_i = 0;
            }
            GLib.Timeout.add(33,animate);
        }
        anim_lock = false ;
        return false;
    }
}
