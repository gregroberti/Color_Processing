///////////////////
// Export Button //
///////////////////

class exportbtn {
  int x, y, w, h;
  int lclk = -1;
  
  exportbtn (int _x, int _y) {
    x = _x;
    y = _y;
    w = 40;
    h = 18;
  }
  
  void render_border() {
    fill(WHITE);
    rect(x-1, y-1, w+2, h+2);
  }
  
  void render_fill() {
    fill(GREY);
    rect(x, y, w, h);
  }
  
  void render_text() {
    fill(WHITE);
    text("Export", x+2, y+13);
  }
 
  void render() {
    noStroke();
    
    render_border();
    render_fill();
    render_text();
  }
  
  boolean isOver() {
    if ((mouseX<x+w) && (mouseX>x) && (mouseY<=y+h) && (mouseY>=y)) {
      return true;
    }
    return false;
  }
  
  void click() {
    File save_file = new File(COLOR_PALETTE_DIR + "\\*.txt");
    selectOutput("Select a file to process:", "save_palette_callback", save_file);
  }
}