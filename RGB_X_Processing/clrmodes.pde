/////////////////
// Color Modes //
/////////////////


class clrmodes {
  int x, y, w, h, num_btns;
  int alpha = 0;
  int index = -1;
  clrmode[] color_modes;
  
  clrmodes (int _x, int _y, int _w, int _h, int _num_btns) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    num_btns = _num_btns;
    initialize_modes();
  }
  
  void initialize_modes() {
    int top = y - 25;
    color_modes = new clrmode[num_btns];
    for(int i = 0; i < color_modes.length; i++) {
      color_modes[i] = new clrmode(x, top += 35, w, 35, i, 3);
    }
  }
  
  boolean index_in_bounds() {
    return index >= 0 && index < color_modes.length;
  }
  
  void update_mode_color(int amount) {
    if (!index_in_bounds()) {
      return;
    }
    
    color_modes[index].update_index(amount);
  }
  
  void update_mode_selection(int amount) {
    if (!index_in_bounds()) {
      return;
    }
    
    int new_index = index + amount;
    if (new_index >= num_btns) {
      new_index -= num_btns;
    }
    else if (new_index < 0) {
      new_index += num_btns;
    }
    
    color_modes[index].unselect();
    index = new_index;
    color_modes[index].select();
  }
  
  int[] get_active_palette() {
    if(!index_in_bounds()) {
      return new int[0];
    }
    else {
      return color_modes[index].get_palette();
    }
  }
  
  void check_for_btn_clicks() {
    if (!use_clrmodes) {
      return;
    }
    for (int i = 0; i < color_modes.length; i++) {
      if (color_modes[i].isOver()) {
        select_mode(i);
        color_modes[i].check_for_btn_clicks();
        return;
      }
    }
    if (index_in_bounds()) {
      color_modes[index].unselect();
      index = -1;
    }
  }
  
  void select_mode(int new_index) {
    if (index_in_bounds()) {
      color_modes[index].unselect();
    }
    index = new_index;
    color_modes[index].select();
  }
  
  void render_border(int alpha) {
    fill(GREY, alpha);
    rect(x-1, y-1, w+2, h+2);
  }
  
  void render_fill(int alpha) {
    fill(BLACK, alpha);
    rect(x, y, w, h);
  }
  
  void render() {
    update_alpha();
    render_border(alpha);
    render_fill(alpha);
    for(int i = 0; i < color_modes.length; i++) {
      color_modes[i].render(alpha);
    }
  }
  
  void adjust_size(int amount) {
    color_modes[index].adjust_size(amount);
    color_modes[index].unselect();
    index = -1;
  }
  
  void update_alpha() {
    if (use_clrmodes && alpha < 255) {
      alpha += ALPHA_MODIFIER;
    }
    else if (!use_clrmodes && alpha > 0) {
      alpha -= ALPHA_MODIFIER*2;
    }
  }
  
  boolean isOver() {
    if ((mouseX<x+w) && (mouseX>x) && (mouseY<=y+h) && (mouseY>=y)) {
      return true;
    }
    return false;
  }
  
  int[] get_palette() {
    int[] retval = new int[64];
    for(int i = 0; i < 8; i++) {
      clrmode m = color_modes[i];
      retval[i*8] = m.color_buttons.length;
      for(int j = 1; j < 8; j++) {
        if (j-1 < m.color_buttons.length) {
          if (m.color_buttons[j-1].id == -1) {
            retval[i*8 + j] = 0;
          }
          else {
            retval[i*8 + j] = m.color_buttons[j-1].id;
          }
        }
        else {
          retval[i*8 + j] = 0;
        }
      }
    }
    return retval;
  }
}