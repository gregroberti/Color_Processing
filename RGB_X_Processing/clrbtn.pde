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
  color cor = color(255, 255, 255);
  int lclk = -1;
  boolean selected = false;
  boolean rst = false;
  
  clrbtn (int _x, int _y, int _w, int _h, int _id) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    id = _id;
  }
  
  void render_border() {
    if (selected) {  // Selected
      fill(color(200, 0, 0));
      rect(x-2, y-2, w+4, h+4);
    }
    else {  // Not Selected
      fill(color(255, 255, 255));
      rect(x-1, y-1, w+2, h+2);
    }
  }
  
  void render_fill() {
    fill(cor);
    rect(x, y, w, h);
  }
  
  void render_text() {
    fill(255);
    int total = 0;
    int[] rgb = getRGB(cor);
    for (int i=0; i<rgb.length; i++) {
      total += rgb[i];
    }
    
    if (total > 600) {
      fill(0);
    }
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
    println("Reset Color #" + id);
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
      println("Undo Color #" + id);
      update_color(history.pop().cor, false);
      
    }
    println(history.size() + " changes left to undo");
  }
  
  void click() {
    int clk = millis();
    if(clk-lclk < 150) {
      reset();
    }
    sel();
    lclk = clk;
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
    main_cor = cor;
    update_sliders();
    println("Updated: " + _r + ", " + _g + ", " + _b + " // Color #" + id);
  }
  
  void sel() {
    selected = true;
    main_cor = cor;
  }
  
  void unsel() {
    selected = false;
  }
  
  void release() {
    int clk = millis();
    if (clk-lclk > 500) {
      update_color(sV1.p, sV2.p, sV3.p, true);
    }
    else {
      update_sliders();
    }
  }
}