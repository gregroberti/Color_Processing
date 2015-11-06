//////////////////
// Color Button //
//////////////////

import java.util.*;

class mycor {
  color cor = WHITE;
  
  mycor (color _cor) {
    cor = _cor;
  }
}

class clrbtn extends elembase {
  int id;
  Stack<mycor> history = new Stack();
  color txt_cor = WHITE;
  int lclk = -1;
  boolean rst = false;
  boolean display_id = false;
  
  clrbtn (int _x, int _y, int _w, int _h, int _id, boolean _display_id) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    id = _id;
    display_id = _display_id;
  }
  
  void set_id(int new_id) {
    display_id = true;
    id = new_id;
  }
  
  void render_text(int alpha) {
    fill(txt_cor, alpha);
    text(id, x+1, y+10);
  }
  
  void render(int alpha) {
    noStroke();
    render_border(alpha);
    render_fill(alpha);
    if (display_id) {
      render_text(alpha);
    }
  }
  
  void clear_history() {
    while(!history.empty()) {
      history.pop();
    }
  }
  
  void reset() {
    if (cor == WHITE) {
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
  
  void click(boolean allow_double_click) {
    if (mouseButton == LEFT) {
      int clk = millis();
      if (allow_double_click && clk-lclk < DOUBLE_CLICK_SPEED) {
        reset();
      }
      lclk = clk;
    }
    else if (mouseButton == RIGHT) {
      update_color(main_cor, true);
    }
    select();
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
  
  void highlight() {
    bor_cor = GREEN;
    bor_thk = 2;
  }
  
  void select() {
    bor_cor = RED;
    bor_thk = 2;
    new_cor = cor;
    println(print_color(getRGB(cor), id, true));
  }
  
  void unselect() {
    bor_cor = WHITE;
    bor_thk = 1;
  }
  
  void scroll(float amnt) {
    y += amnt;
  }
  
  void update_text_color() {
    int total = 0;
    int[] rgb = getRGB(cor);
    for (int i=0; i<rgb.length; i++) {
      total += rgb[i];
    }
    
    if (total > 600) {
      txt_cor = BLACK;
    }
    else {
      txt_cor = WHITE;
    }
  }
}