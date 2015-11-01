///////////////////
// Export Button //
///////////////////

class exportpalette extends btnbase {
  
  exportpalette (int _x, int _y) {
    x = _x;
    y = _y;
    w = 80;
    h = 18;
    cor = GREY;
    btn_txt = "Export Palette";
    btn_txt_x = x+2;
    btn_txt_y = y+13;
  }
  
  void click() {
    File save_file = new File(COLOR_PALETTE_DIR + "\\*.txt");
    selectOutput("Select a file to process:", "save_palette_callback", save_file);
  }
}


class importpalette extends btnbase {
  
  importpalette (int _x, int _y) {
    x = _x;
    y = _y;
    w = 80;
    h = 18;
    cor = GREY;
    btn_txt = "Import Palette";
    btn_txt_x = x+2;
    btn_txt_y = y+13;
  }
 
  void click() {
    File save_file = new File(COLOR_PALETTE_DIR + "\\*.txt");
    selectInput("Select a file to process:", "load_palette_callback", save_file);
  }
}


class exportclrmodes extends btnbase {
  
  exportclrmodes (int _x, int _y) {
    x = _x;
    y = _y;
    w = 80;
    h = 18;
    cor = GREY;
    btn_txt = "Export Modes";
    btn_txt_x = x+2;
    btn_txt_y = y+13;
  }
  
  void click() {
    File save_file = new File(COLOR_MODE_DIR + "\\*.txt");
    selectOutput("Select a file to process:", "save_modes_callback", save_file);
  }
}


class importclrmodes extends btnbase {
  
  importclrmodes (int _x, int _y) {
    x = _x;
    y = _y;
    w = 80;
    h = 18;
    cor = GREY;
    btn_txt = "Import Modes";
    btn_txt_x = x+2;
    btn_txt_y = y+13;
  }
 
  void click() {
    File save_file = new File(COLOR_MODE_DIR + "\\*.txt");
    selectInput("Select a file to process:", "load_modes_callback", save_file);
  }
}


class btn_view_clrmodes extends btnbase {
  
  btn_view_clrmodes (int _x, int _y) {
    x = _x;
    y = _y;
    w = 20;
    h = 18;
    cor = GREY;
    btn_txt = "F2";
    btn_txt_x = x+2;
    btn_txt_y = y+13;
  }
 
  void click() {
    set_view_clrmodes();
  }
}


class btn_view_sliders extends btnbase {
  
  btn_view_sliders (int _x, int _y) {
    x = _x;
    y = _y;
    w = 20;
    h = 18;
    cor = GREY;
    btn_txt = "F4";
    btn_txt_x = x+2;
    btn_txt_y = y+13;
  }
 
  void click() {
    set_view_sliders();
  }
}


class btn_view_clrpicker extends btnbase {
  
  btn_view_clrpicker (int _x, int _y) {
    x = _x;
    y = _y;
    w = 20;
    h = 18;
    cor = GREY;
    btn_txt = "F5";
    btn_txt_x = x+2;
    btn_txt_y = y+13;
  }
 
  void click() {
    set_view_clrpicker();
  }
}


class btn_view_imgpicker extends btnbase {
  
  btn_view_imgpicker (int _x, int _y) {
    x = _x;
    y = _y;
    w = 20;
    h = 18;
    cor = GREY;
    btn_txt = "F6";
    btn_txt_x = x+2;
    btn_txt_y = y+13;
  }
 
  void click() {
    set_view_imgpicker();
  }
}


class btn_view extends elembase {
  int index = 1;
  btnbase[] btns = new btnbase[4];
  btn_view_clrmodes clrmodes_btn;
  btn_view_sliders sliders_btn;
  btn_view_clrpicker clrpicker_btn;
  btn_view_imgpicker imgpicker_btn;
  
  btn_view(int _x, int _y, int _w) {
    x = _x;
    y = _y;
    w = _w;
    h = 18;
    
    int btn_sp = w/4;
    int left = x;
    btns[0] = new btn_view_clrmodes(left += btn_sp, y);
    btns[1] = new btn_view_sliders(left += btn_sp, y);
    btns[2] = new btn_view_clrpicker(left += btn_sp, y);
    btns[3] = new btn_view_imgpicker(left += btn_sp, y);
  }
  
  void render(int alpha) {
    for (int i = 0; i < btns.length; i++) {
      if (index == i) {
        btns[i].select();
      }
      else {
        btns[i].unselect();
      }
      btns[i].render(alpha);
    }
  }
  
  void check_for_btn_clicks() {
    for (int i = 0; i < btns.length; i++) {
      if (btns[i].isOver()) {
        btns[i].click();
      }
    }
  }
}