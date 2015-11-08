////////////////
// Color Mode //
////////////////

class clrmode extends elembase {
  int index = -1;
  int id, num_btns;
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
    btn_sp_x = 6;
    btn_sp_y = 10;
    bor_cor = GREY;
    num_btns = _num_btns;
    initialize_color_buttons();
  }
  
  void initialize_color_buttons() {
    int left = x + btn_w + btn_sp_x;
    color_buttons = new clrbtn[num_btns];
    for (int i = 0; i < num_btns; i++) {
      color_buttons[i] = new clrbtn(left += btn_w + btn_sp_x,  y + 5, btn_w, btn_h, -1, false);
      color_buttons[i].cor = BLACK;
    }
  }
  
  int[] get_palette() {
    int[] color_palette = new int[num_btns*3];
    for(int i = 0; i < num_btns; i++) {
      int[] rgb = getRGB(color_buttons[i].cor);
      color_palette[i*3+0] = rgb[0];
      color_palette[i*3+1] = rgb[1];
      color_palette[i*3+2] = rgb[2];
    }
    return color_palette;
  }
  
  boolean check_for_btn_clicks() {
    for (int i = 0; i < num_btns; i++) {
      if (color_buttons[i].isOver()) {
        if(mouseButton == RIGHT) {
          if (preset_palette.index != -1) {
            color_buttons[i].set_id(preset_palette.index);
            println("Set color mode slot using palette #" + preset_palette.index);
          }
          else {
            color_buttons[i].set_id(-1);
            color_buttons[i].display_id = false;
            color_buttons[i].cor = BLACK;
            println("Reset color slot");
          }
        }
        else {
          color_buttons[i].click(false);
          preset_palette.highlight(color_buttons[i].id);
        }
        index = i;
      }
      else {
        color_buttons[i].unselect();
      }
    }
    if (index == -1) {
      preset_palette.unselect();
    }
    return selected;
  }
  
  void select() {
    selected = true;
    text_cor = RED;
  }
  
  void adjust_size(int amount) {
    int num_btns_new = num_btns + amount;
    
    if (num_btns_new < 1) {
      println("Unable to reduce the size of the color mode below 1");
      return;
    }
    else if (num_btns_new > MAX_CLR_PER_MODE) {
      println("Unable to expand the size of the color mode above " + MAX_CLR_PER_MODE);
      return;
    }
    else if (num_btns_new > num_btns && num_btns_new > color_buttons.length) {
      clrbtn[] new_color_buttons = new clrbtn[num_btns_new];
      
      for (int i = 0; i < num_btns; i++) {
        new_color_buttons[i] = color_buttons[i];
      }
      int left = color_buttons[num_btns-1].x;
      for (int i = num_btns; i < num_btns_new; i++) {
        new_color_buttons[i] = new clrbtn(left += btn_sp_x + btn_w,  y + 5, btn_w, btn_h, -1, false);
        new_color_buttons[i].cor = BLACK;
      }
      color_buttons = new_color_buttons;
    }
    
    index = -1;
    num_btns = num_btns_new;
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
        new_index = num_btns-1;
      }
    }
    else {
      new_index = index+amount;
    }
    if (new_index < 0) {
      new_index += num_btns;
    }
    else if(new_index >= num_btns) {
      new_index -= num_btns;
    }
    
    if (index != -1) {
      color_buttons[index].unselect();
      preset_palette.unhighlight();
    }
    index = new_index;
    color_buttons[index].select();
    preset_palette.highlight(color_buttons[index].id);
  }
  
  void unselect() {
    unselect_color_button();
    index = -1;
    selected = false;
    text_cor = WHITE;
  }
  
  void unselect_color_button() {
    if (index_in_bounds()) {
      color_buttons[index].unselect();
      preset_palette.unhighlight();
    }
  }
  
  void render_text(int alpha) {
    fill(text_cor, alpha);
    text("Mode #" + id + ":" , x + 2, y+20);
  }
  
  void render(int alpha) {
    if (selected && use_clrmodes) {
      render_border(alpha);
      render_fill(alpha);
      send_live_preview(get_palette());
    }
    render_text(alpha);
    for(int i = 0; i < num_btns; i++) {
      if (color_buttons[i].display_id) {
        color_buttons[i].cor = preset_palette.get_color(color_buttons[i].id);
      }
      color_buttons[i].render(alpha);
    }
  }
  
  void scroll(float amnt) {
    y += amnt;
    for (int i = 0; i < color_buttons.length; i++) {
      color_buttons[i].scroll(amnt);
    }
  }
  
  int get_size() {
    return num_btns;
  }
  
  boolean index_in_bounds() {
    return index >= 0 && index < num_btns;
  }
}