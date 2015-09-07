//////////////////
// Color Button //
//////////////////

class clrbtn {
  int x, y, w, h;
  color cor;
  int lclk = -1;
  boolean sel = false;
  
  clrbtn (int _x, int _y, color _cor) {
    x = _x;
    y = _y;
    w = 25;
    h = 25;
    cor = _cor;
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
        cor = color(0, 0, 0);
      }
      else {
        cor = color(255, 255, 255);
      }
    }
    sel();
    lclk = clk;
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
    println("The color you just clicked on was:");
    int clk = millis();
    if (clk-lclk > 500) {
      cor = color(sV1.p, sV2.p, sV3.p);
      int[] rgb = getRGB(cor);
      println(rgb[0] + ", " + rgb[1] + ", " + rgb[2] + ",");
    }
    else {
      update_sliders();
    }
  }
}