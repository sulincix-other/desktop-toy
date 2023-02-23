public toy main_widget = null;
public Gtk.Window window = null;
public class toy : Gtk.Box {
    public Gtk.Button main;
    public Gtk.Image image;
    public string theme_path;
    public toy(){
        anim_lock = false;
        main = new Gtk.Button();
        image = new Gtk.Image();
        main.set_image(image);
        main.clicked.connect((widget)=>{
            stdout.printf("Clicked\n");
        });
        add(main);
        show_all();
    }
    public void load_animation(string name){
        if(anim_name != name | anim_name == null){
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
        stdout.printf(theme_path+"/"+anim_name+".png\n");
        if(isfile(theme_path+"/"+anim_name+".png")){
            image.set_from_file(theme_path+"/"+anim_name+".png");
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

public void widget_init(){
    // window definition
    window = new Gtk.Window();
    // visual settings
    var screen = window.get_screen();
    var visual = screen.get_rgba_visual();
    if(visual != null && screen.is_composited()){
        window.set_visual(visual);
    }
    // feature definition
    window.set_app_paintable(true);
    window.set_decorated(false);
    window.set_keep_above(true);
    window.set_skip_pager_hint(true);
    window.set_skip_taskbar_hint(true);
    window.set_accept_focus(false);
    window.set_resizable(false);
    window.set_can_focus(false);
    window.stick();
    // set main widget
    main_widget = new toy();
    window.add(main_widget);
    window.show_all();
}
