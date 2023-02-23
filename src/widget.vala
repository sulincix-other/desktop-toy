public class toy : Gtk.Box {
    public Gtk.Button main;
    public string theme_path;
    public toy(){
        main = new Gtk.Button();
        main.clicked.connect((widget)=>{
            stdout.printf("Clicked\n");
        });
        add(main);
        show_all();
    }
    public void load_animation(string name){
        if(isfile(theme_path+"/"+name+".png")){
            main.set_image(new Gtk.Image.from_file(theme_path+"/"+name+".png"));
        }
    }
}
