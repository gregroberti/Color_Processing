///////////////////
// Import Button //
///////////////////

class importbtn {
  int x, y, w, h;
  int lclk = -1;
  
  importbtn (int _x, int _y) {
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
    text("Import", x+2, y+13);
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
    File save_file = new File(sketchPath("") + "\\RGB_X_Processing\\color_palettes");
    selectInput("Select a file to process:", "load_palette_callback", save_file);
  }
}