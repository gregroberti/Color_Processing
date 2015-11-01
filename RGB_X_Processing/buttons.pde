///////////////////
// Export Button //
///////////////////

class exportpalette extends btnbase {
  int lclk = -1;
  
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
  int lclk = -1;
  
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
  int lclk = -1;
  
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
  int lclk = -1;
  
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