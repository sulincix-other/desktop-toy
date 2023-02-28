public toy main_widget = null;
public Gtk.Window window = null;
public class toy : Gtk.Box {
    public Gtk.Button main;
    private Gtk.Image image;
    private Gtk.Box menu;
    public string theme_path;
    private Gtk.Stack stack;

    private bool menu_status;
    public toy(){
        set_orientation(Gtk.Orientation.VERTICAL);
        anim_lock = false;
        main = new Gtk.Button();
        image = new Gtk.Image();
        main.set_image(image);
        menu_status = false;
        int64 last_click = get_epoch();
        main.clicked.connect((widget)=>{
            if (get_epoch() - last_click < 300){
                if(menu_status){
                    hide_menu();
                }else{
                    show_menu();
                }
            }
            last_click = get_epoch();
        });
        menu = new Gtk.Box(Gtk.Orientation.VERTICAL,3);
        menu.show_all();
        var b = new Gtk.Box(Gtk.Orientation.HORIZONTAL,3);
        b.add(main);
        stack = new Gtk.Stack();
        stack.set_vexpand(true);
        stack.set_hexpand(true);
        stack.add_titled(menu, "menu", "menu");
        stack.get_style_context().add_class("menu");
        main.get_style_context().add_class("window");
        main.set_relief(Gtk.ReliefStyle.NONE);
        add(b);
        add(stack);
        show();
        b.show_all();
        hide_menu();
    }
    public void show_menu(){
       stack.show();
       menu_status = true;
       window.set_accept_focus(true);
       window.present();
    }
    public void hide_menu(){
       stack.hide();
       menu_status = false;
       window.set_accept_focus(false);
       set_page("menu");

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

    private string[] page_names;
    public void add_feature(string label, Gtk.Widget page){
        if(page_names == null){
            page_names = {};
        }
        page_names += label;
        stack.add_titled(page, label, label);
        Gtk.Button but = new Gtk.Button();
        but.set_label(label);
        menu.pack_start(but);
        but.get_style_context().add_class("button");
        page.hide();
        but.show();
        but.set_relief(Gtk.ReliefStyle.NONE);
        but.clicked.connect(()=>{
            set_page(label);
        });
    }
    private void hide_all_pages(){
        stack.get_child_by_name("menu").hide();
        foreach(string page in page_names){
            stack.get_child_by_name(page).hide();
        }
    }
    public void set_page(string name){
        hide_all_pages();
        stack.get_child_by_name(name).show();
        stack.set_visible_child_name(name);
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
    window.set_resizable(false);
    window.set_can_focus(false);
    window.stick();
    // set main widget
    main_widget = new toy();
    window.add(main_widget);
    window.get_style_context().add_class("window");
    window.show();
}
