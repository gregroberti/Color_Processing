///////////////////
// Import Button //
///////////////////

class importbtn extends btnbase {
  int lclk = -1;
  
  importbtn (int _x, int _y) {
    x = _x;
    y = _y;
    w = 40;
    h = 18;
    cor = GREY;
    btn_txt = "Import";
    btn_txt_x = x+2;
    btn_txt_y = y+13;
  }
 
  void click() {
    File save_file = new File(COLOR_PALETTE_DIR + "\\*.txt");
    selectInput("Select a file to process:", "load_palette_callback", save_file);
  }
}