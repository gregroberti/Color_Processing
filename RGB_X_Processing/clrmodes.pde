/////////////////
// Color Modes //
/////////////////

class clrmode {
  int index = -1;
  int x, y, w, h, id, num_btns;
  int btn_w, btn_h, btn_sp_x, btn_sp_y, btn_acr, btn_acr_unch;
  color text_cor = WHITE;
  boolean selected = false;
  clrbtn[] color_buttons;
  
  clrmode (int _x, int _y, int _w, int _h, int _id, int _num_btns) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    id = _id;
    btn_w = 25;
    btn_h = 25;
    btn_sp_x = 10;
    btn_sp_y = 10;
    num_btns = _num_btns;
    initialize_color_buttons();
  }
  
  void initialize_color_buttons() {
    int left = x + 50;
    color_buttons = new clrbtn[num_btns];
    for (int i = 0; i < num_btns; i++) {
      color_buttons[i] = new clrbtn(left += 35,  y + 5, btn_w, btn_h, -1, false);
      color_buttons[i].cor = BLACK;
    }
  }
  
  int[] get_palette() {
    int[] color_palette = new int[color_buttons.length*3];
    for(int i = 0; i < color_buttons.length; i++) {
      int[] rgb = getRGB(color_buttons[i].cor);
      color_palette[i*3+0] = rgb[0];
      color_palette[i*3+1] = rgb[1];
      color_palette[i*3+2] = rgb[2];
    }
    return color_palette;
  }
  
  boolean check_for_btn_clicks() {
    for (int i = 0; i < color_buttons.length; i++) {
      if (color_buttons[i].isOver()) {
        if(mouseButton == RIGHT) {
          if (preset_palette.index != -1) {
            color_buttons[i].set_id(preset_palette.index);
          }
        }
        else {
          color_buttons[i].click(false);
        }
        index = i;
      }
      else {
        color_buttons[i].unselect();
      }
    }
    return selected;
  }
  
  void select() {
    selected = true;
    text_cor = RED;
    send_live_preview(get_palette());
  }
  
  boolean isOver() {
    if ((mouseX<x+w) && (mouseX>x) && (mouseY<=y+h) && (mouseY>=y)) {
      return true;
    }
    return false;
  }
  
  void adjust_size(int amount) {
    int num_btns_new = num_btns + amount;
    
    if (num_btns_new < 1) {
      println("Unable to reduce the size of the color mode below 1");
      return;
    }
    else if (num_btns_new > 7) {
      println("Unable to expand the size of the color mode above 7");
      return;
    }
    
    index = -1;
    num_btns = num_btns_new;
    initialize_color_buttons();
  }
  
  void update_index(int amount) {
    if (!selected) {
      return;
    }
    
    int new_index = -1;
    if (index == -1) {
      if (amount > 0) {
        new_index = 0;
      }
      else {
        new_index = color_buttons.length-1;
      }
    }
    else {
      new_index = index+amount;
    }
    if (new_index < 0) {
      new_index += color_buttons.length;
    }
    else if(new_index >= color_buttons.length) {
      new_index -= color_buttons.length;
    }
    
    if (index != -1) {
      color_buttons[index].unselect();
    }
    index = new_index;
    color_buttons[index].select();
  }
  
  void unselect() {
    index = -1;
    selected = false;
    text_cor = WHITE;
    for (int i = 0; i < color_buttons.length; i++) {
      color_buttons[i].unselect();
    }
  }
  
  void render_border(int alpha) {
    fill(GREY, alpha);
    rect(x-1, y-1, w+2, h+2);
  }
  
  void render_fill(int alpha) {
    fill(BLACK, alpha);
    rect(x, y, w, h);
  }
  
  void render_text(int alpha) {
    fill(text_cor, alpha);
    text("Mode #" + id + ":" , x+15, y+20);
  }
  
  void render(int alpha) {
    if (selected) {
      render_border(alpha);
      render_fill(alpha);
    }
    render_text(alpha);
    for(int i = 0; i < num_btns; i++) {
      if (color_buttons[i].display_id) {
        color_buttons[i].cor = preset_palette.get_color(color_buttons[i].id);
      }
      color_buttons[i].render(alpha);
    }
  }
}

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