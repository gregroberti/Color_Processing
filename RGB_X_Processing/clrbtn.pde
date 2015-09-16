//////////////////
// Color Button //
//////////////////

import java.util.*;

class mycor {
  color cor = color(255, 255, 255);
  
  mycor (color _cor) {
    cor = _cor;
  }
}

class clrbtn {
  int x, y, w, h, id;
  Stack<mycor> history = new Stack();
  color txt_cor = color(255, 255, 255);
  color bor_cor = color(255, 255, 255);
  color cor = color(255, 255, 255);
  int lclk = -1;
  int bor_thk = 1;
  boolean rst = false;
  
  clrbtn (int _x, int _y, int _w, int _h, int _id) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    id = _id;
  }
  
  void render_border() {
    fill(bor_cor);
    rect(x-1*bor_thk, y-1*bor_thk, w+2*bor_thk, h+2*bor_thk);
  }
  
  void render_fill() {
    fill(cor);
    rect(x, y, w, h);
  }
  
  void render_text() {
    fill(txt_cor);
    text(id, x+1, y+10);
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
  
  void clear_history() {
    while(!history.empty()) {
      history.pop();
    }
  }
  
  void reset() {
    if (cor == color(255, 255, 255)) {
      update_color(0, 0, 0, true);
    }
    else {
      update_color(255, 255, 255, true);
    }
    rst = true;
  }
  
  void undo() {
    if(!history.empty()) {
      rst = false;
      update_color(history.pop().cor, false);
    }
    println(history.size() + " change(s) left to undo for color #" + id);
  }
  
  void click() {
    if (mouseButton == LEFT) {
      int clk = millis();
      if (clk-lclk < DOUBLE_CLICK_SPEED) {
        reset();
      }
      lclk = clk;
    }
    else if (mouseButton == RIGHT) {
      update_color(main_cor, true);
    }
    sel();
  }
  
  void update_color(color _cor, boolean psh_hst) {
    int[] rgb = getRGB(_cor);
    update_color(rgb[0], rgb[1], rgb[2], psh_hst);
  }
  
  void update_color(int _r, int _g, int _b, boolean psh_hst) {
    color _cor = color(_r, _g, _b);
    if (cor == _cor) {
      return;
    }
    if (!rst && psh_hst) {
      history.push(new mycor(cor));
    }
    cor = _cor;
    new_cor = cor;
    update_text_color();
    println("Updated: " + _r + ", " + _g + ", " + _b + " // Color #" + id);
  }
  
  void sel() {
    bor_cor = color(200, 0, 0);
    bor_thk = 2;
    new_cor = cor;
  }
  
  void unsel() {
    bor_cor = color(255, 255, 255);
    bor_thk = 1;
  }
  
  void update_text_color() {
    int total = 0;
    int[] rgb = getRGB(cor);
    for (int i=0; i<rgb.length; i++) {
      total += rgb[i];
    }
    
    if (total > 600) {
      txt_cor = color(0, 0, 0);
    }
    else {
      txt_cor = color(255, 255, 255);
    }
  }
}