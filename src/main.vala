public int main(string[] args){
    Gtk.init(ref args);
    // window definition
    var window = new Gtk.Window();
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
    window.stick();
    // set main widget
    set_widget(toy_create());
    window.add(main_widget);
    window.show_all();
    // draw signal
    window.destroy.connect(Gtk.main_quit);
    window.draw.connect((widget, context)=>{
        context.set_source_rgba(0, 0, 0, 0);
        context.set_operator(Cairo.Operator.SOURCE);
        context.paint();
        context.set_operator(Cairo.Operator.OVER);
        return false;
    });
    // draw & move event
    main_widget.motion_notify_event.connect((event) => {
        if((event.state & Gdk.ModifierType.BUTTON2_MASK) == Gdk.ModifierType.BUTTON2_MASK){
            int w, h;
            window.get_size(out w, out h);
            window.move((int)(event.x_root-(w/2)), (int)(event.y_root-(h/2)));
            return true;
        }
        return false;
    });
    Gtk.main();
    return 0;
}

private Gtk.Widget main_widget = null;

public void set_widget(Gtk.Widget widget){
    main_widget = widget;
    main_widget.show();
}
