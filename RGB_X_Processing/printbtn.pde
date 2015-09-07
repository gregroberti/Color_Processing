//////////////////
// Print Button //
//////////////////

class printbtn {
  int x, y, w, h;
  int lclk = -1;
  
  printbtn (int _x, int _y) {
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
    text("Export Palette", x+1, 22);
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
    println("Copy and paste to customize your color palette in NEO!");
    println(print_palette());
    save_palette();
  }
}