///////////////////
// Import Button //
///////////////////

class importbtn extends elembase {
  int lclk = -1;
  int alpha = 255;
  
  importbtn (int _x, int _y) {
    x = _x;
    y = _y;
    w = 40;
    h = 18;
  }
  
  void render_text(int alpha) {
    fill(WHITE, alpha);
    text("Import", x+2, y+13);
  }
 
  void render() {
    noStroke();
    
    render_border(alpha);
    render_fill(alpha);
    render_text(alpha);
  }
  
  void click() {
    File save_file = new File(COLOR_PALETTE_DIR + "\\*.txt");
    selectInput("Select a file to process:", "load_palette_callback", save_file);
  }
}