///////////////////
// Export Button //
///////////////////

class exportbtn extends elembase {
  int lclk = -1;
  int alpha = 255;
  
  exportbtn (int _x, int _y) {
    x = _x;
    y = _y;
    w = 40;
    h = 18;
    cor = GREY;
  }
  
  void render_text(int alpha) {
    fill(WHITE, alpha);
    text("Export", x+2, y+13);
  }
 
  void render() {
    noStroke();
    
    render_border(alpha);
    render_fill(alpha);
    render_text(alpha);
  }
  
  void click() {
    File save_file = new File(COLOR_PALETTE_DIR + "\\*.txt");
    selectOutput("Select a file to process:", "save_palette_callback", save_file);
  }
}