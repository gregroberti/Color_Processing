///////////////////
// Import Button //
///////////////////

class importbtn {
  int x, y, w, h;
  int lclk = -1;
  
  importbtn (int _x, int _y) {
    x = _x;
    y = _y;
    w = 80;
    h = 18;
  }
  
  void render_border() {
    fill(color(255, 255, 255));
    rect(x-1, y-1, w+2, h+2);
  }
  
  void render_fill() {
    fill(color(55, 55, 55));
    rect(x, y, w, h);
  }
  
  void render_text() {
    fill(255);
    text("Import Palette", x+2, y+13);
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
    load_palette();
  }
}