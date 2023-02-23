public void plugin_init(){
    window.destroy.connect(Gtk.main_quit);
    window.draw.connect((widget, context)=>{
        context.set_source_rgba(0, 0, 0, 0);
        context.set_operator(Cairo.Operator.SOURCE);
        context.paint();
        context.set_operator(Cairo.Operator.OVER);
        return false;
    });
    main_widget.main.motion_notify_event.connect((event) => {
        if((event.state & Gdk.ModifierType.BUTTON1_MASK) == Gdk.ModifierType.BUTTON1_MASK){
            int w, h;
            window.get_size(out w, out h);
            window.move((int)(event.x_root-(w/2)), (int)(event.y_root-(h/2)));
            return true;
        }
        return false;
    });
}
