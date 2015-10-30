////////////////
// Color Mode //
////////////////

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
            println("Updated slot to palette #" + preset_palette.index);
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
    else if (num_btns_new > num_btns && num_btns_new > color_buttons.length) {
      clrbtn[] new_color_buttons = new clrbtn[num_btns_new];
      
      for (int i = 0; i < num_btns; i++) {
        new_color_buttons[i] = color_buttons[i];
      }
      for (int i = num_btns; i < num_btns_new; i++) {
        new_color_buttons[i] = new clrbtn(x+50+((btn_w+btn_sp_x)*num_btns)+(btn_w+btn_sp_x),  y + 5, btn_w, btn_h, -1, false);
        new_color_buttons[num_btns_new-1].cor = BLACK;
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
}