public toy main_widget = null;
public Gtk.Window window = null;
public class toy : Gtk.Box {
    public Gtk.Button main;
    private Gtk.Image image;
    private Gtk.Box menu;
    public string theme_path;
    public ResizeButton resize;
    private Gtk.Stack stack;
    private Gtk.Overlay overlay;

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
        pack_start(b,false,false,0);
        overlay = new Gtk.Overlay();
        overlay.add_overlay(stack);
        pack_start(overlay,true,true,0);
        stack.show();
        overlay.set_size_request(400,400);
        resize = new ResizeButton();
        resize.halign = Gtk.Align.END;
        resize.valign = Gtk.Align.END;
        stack.halign = Gtk.Align.FILL;
        stack.valign = Gtk.Align.FILL;
        resize.show();
        overlay.add_overlay(resize);
        show();
        b.show_all();
        hide_menu();
    }
    public void show_menu(){
       overlay.show();
       menu_status = true;
       window.set_accept_focus(true);
       window.present();
    }
    public void hide_menu(){
       overlay.hide();
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
        menu.pack_start(but,false,false,0);
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


public class ResizeButton : Gtk.Button {

    public ResizeButton(){
        Gtk.Image i = new Gtk.Image();
        i.set_from_icon_name("gtk-ok",0);
        i.set_pixel_size(4);
        this.set_image(i);
        this.set_can_focus(false);
        this.get_style_context().add_class("transparent");
        this.set_relief(Gtk.ReliefStyle.NONE);
    }
    public void define_resize_event(Gtk.Window window){
     // move button event
        int offset_x = -1;
        int offset_y = -1;
        this.motion_notify_event.connect((event) => {
            if((event.state & Gdk.ModifierType.BUTTON1_MASK) == Gdk.ModifierType.BUTTON1_MASK){
                int w, h;
                Gtk.Allocation alloc;
                window.get_allocation(out alloc);
                w = alloc.width;
                h = alloc.height;
                int window_x = 0;
                int window_y = 0;
                window.get_position(out window_x, out window_y);
                if(offset_x < 0){
                    offset_x = (int)(w - event.x_root + window_x);
                    offset_y = (int)(h - event.y_root + window_y);
                }
                window.move(window_x, window_y);
                window.resize((int)(event.x_root + offset_x - window_x), (int)(event.y_root + offset_y - window_y));
                return true;
            }
            return false;
        });
        this.button_release_event.connect((event)=>{
             offset_x = -1;
             offset_y = -1;
             return false;
        });
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
    window.set_resizable(true);
    window.set_can_focus(false);
    window.stick();
    // set main widget
    main_widget = new toy();
    window.add(main_widget);
    window.get_style_context().add_class("window");
    main_widget.resize.define_resize_event(window);
    window.show();
}
