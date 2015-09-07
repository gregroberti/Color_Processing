//////////////////
// Color Button //
//////////////////

class clrbtn {
  int x, y, id;
  color cor = color(255, 255, 255);
  int w = 25;
  int h = 25;
  int lclk = -1;
  boolean sel = false;
  
  clrbtn (int _x, int _y, int _id) {
    x = _x;
    y = _y;
    w = 25;
    h = 25;
    id = _id;
  }
  
  void render_border() {
    if (sel) {
      fill(color(200, 0, 0)); // RED
      rect(x-2, y-2, w+4, h+4);
    }
    else {
      fill(color(255, 255, 255)); // WHITE
      rect(x-1, y-1, w+2, h+2);
    }
  }
  
  void render_fill() {
    fill(cor);
    rect(x, y, w, h);
  }
  
  void render() {
    noStroke();
    render_border();
    render_fill();
  }
  
  boolean isOver() {
    if ((mouseX<x+w) && (mouseX>x) && (mouseY<=y+h) && (mouseY>=y)) {
      return true;
    }
    return false;
  }
  
  void click() {
    int clk = millis();
    if(clk-lclk < 150) {
      if (cor == color(255, 255, 255)) {
        update_color(0, 0, 0);
      }
      else {
        update_color(255, 255, 255);
      }
    }
    sel();
    lclk = clk;
  }
  
  void update_color(int _r, int _g, int _b) {
    cor = color(_r, _g, _b);
    println(_r + ", " + _g + ", " + _b + " // Color #" + id);
  }
  
  void sel() {
    unselect_all();
    sel = true;
    main_cor = cor;
  }
  
  void unsel() {
    sel = false;
  }
  
  void release() {
    int clk = millis();
    if (clk-lclk > 500) {
      update_color(sV1.p, sV2.p, sV3.p);
    }
    else {
      update_sliders();
    }
  }
}