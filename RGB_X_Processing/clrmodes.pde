/////////////////
// Color Modes //
/////////////////

class clrmode {
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
      color_buttons[i] = new clrbtn(left += 35,  y + 5, btn_w, btn_h, -1);
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
    //println("checking");
    for (int i = 0; i < color_buttons.length; i++) {
      if (color_buttons[i].isOver()) {
        color_buttons[i].click();
        select();
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
  }
  
  boolean isOver() {
    if ((mouseX<x+w) && (mouseX>x) && (mouseY<=y+h) && (mouseY>=y)) {
      return true;
    }
    return false;
  }
  
  void unselect() {
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
      color_buttons[i].render(alpha);
    }
  }
}

class clrmodes {
  int x, y, w, h, num_btns;
  int alpha = 0;
  int selected_mode = -1;
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
  
  boolean selected_mode_in_bounds() {
    return selected_mode >= 0 && selected_mode < color_modes.length;
  }
  
  void update_selection(int amount) {
    if (!selected_mode_in_bounds()) {
      return;
    }
    
    int new_selection = selected_mode + amount;
    if (new_selection >= num_btns) {
      new_selection -= num_btns;
    }
    else if (new_selection < 0) {
      new_selection += num_btns;
    }
    
    color_modes[selected_mode].unselect();
    color_modes[new_selection].select();
    selected_mode = new_selection;
  }
  
  int[] get_active_palette() {
    if(!selected_mode_in_bounds()) {
      return new int[0];
    }
    else {
      return color_modes[selected_mode].get_palette();
    }
  }
  
  void check_for_btn_clicks() {
    if (!use_clrmodes) {
      return;
    }
    //println("checking clrmodes");
    for (int i = 0; i < color_modes.length; i++) {
      if (color_modes[i].isOver()) {
        //println("isOver() clrmode " + i);
        color_modes[i].check_for_btn_clicks();
        color_modes[i].select();
        selected_mode = i;
      }
      else {
        color_modes[i].unselect();
      }
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
  
  void render() {
    update_alpha();
    render_border(alpha);
    render_fill(alpha);
    for(int i = 0; i < color_modes.length; i++) {
      color_modes[i].render(alpha);
    }
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
}