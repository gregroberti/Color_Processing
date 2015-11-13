/////////////////
// Color Modes //
/////////////////


class clrmodes extends elembase {
  float scroll_amnt = 0;
  int num_modes;
  int alpha = 0;
  int index = -1;
  int buff_x = 5;
  clrmode[] color_modes;
  exportclrmodes export_cm;
  importclrmodes import_cm;
  
  clrmodes (int _x, int _y, int _w, int _h, int _num_modes) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    bor_cor = GREY;
    num_modes = _num_modes;
    initialize_modes();
    export_cm = new exportclrmodes(x + w - 80, y - 30);
    import_cm = new importclrmodes(x, y - 30);
  }
  
  void initialize_modes() {
    int top = y - 25;
    color_modes = new clrmode[num_modes];
    for(int i = 0; i < num_modes; i++) {
      color_modes[i] = new clrmode(x+buff_x, top += MODE_HEIGHT, w-buff_x*2, MODE_HEIGHT, i, 3);
    }
  }
  
  boolean index_in_bounds() {
    return index >= 0 && index < num_modes;
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
    if (new_index >= num_modes) {
      return;
    }
    else if (new_index < 0) {
      return;
    }
    
    keep_index_on_screen(index, new_index);
    color_modes[index].unselect();
    index = new_index;
    color_modes[index].select();
  }
  
  void check_for_btn_clicks() {
    if (!use_clrmodes) {
      return;
    }
    if (export_cm.isOver()) {
      export_cm.click();
    }
    else if (import_cm.isOver()) {
      import_cm.click();
    }
    for (int i = 0; i < num_modes; i++) {
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
    turn_off_light();
  }
  
  void select_mode(int new_index) {
    if (index_in_bounds()) {
      color_modes[index].unselect();
    }
    index = new_index;
    color_modes[index].select();
  }
  
  void unselect() {
    if (index_in_bounds()) {
      color_modes[index].unselect();
      index = -1;
    }
  }
  
  void render_perimeter_mask(int _x, int _y, int _w, int _h) {
    fill(BLACK);
    rect(_x, _y, _w, _h);
  }
  
  void render() {
    update_alpha();
    render_border(alpha);
    render_fill(alpha);
    
    for(int i = 0; i < num_modes; i++) {
      color_modes[i].render(alpha);
    }
    
    render_perimeter_mask(0, 0, width, y-1);
    render_perimeter_mask(0, y+h+1, width, height-y+h);
    render_perimeter_mask(0, 0, x-1, height);
    render_perimeter_mask(x+w+1, 0, width-y-h, height);
    
    export_cm.render(alpha);
    import_cm.render(alpha);
  }
  
  void adjust_num_modes(int amount) {
    int new_num_modes = num_modes + amount;
    if (new_num_modes < 1) return;
    unselect();
    if (new_num_modes > color_modes.length) {
      clrmode[] new_color_modes = new clrmode[new_num_modes];
      for (int i = 0; i < num_modes; i++) {
        new_color_modes[i] = color_modes[i];
      }
      for (int i = num_modes; i < new_num_modes; i++) {
        new_color_modes[i] = new clrmode(x+buff_x, color_modes[num_modes-1].y + MODE_HEIGHT, w-buff_x*2, MODE_HEIGHT, i, 3);
      }
      color_modes = new_color_modes;
    }
    num_modes = new_num_modes;
  }
  
  void adjust_mode_size(int amount) {
    color_modes[index].unselect_color_button();
    color_modes[index].adjust_size(amount);
  }
  
  void keep_index_on_screen(int old_index, int new_index) {
    int index_diff = old_index - new_index;
    if (color_modes[new_index].y >= (y + h-20)) {
      scroll(MODE_HEIGHT*index_diff);
    }
    else if (color_modes[new_index].y < y) {
      scroll(MODE_HEIGHT*index_diff);
    }
  }
  
  void scroll(float amnt) {
    int new_scroll_amnt = int(scroll_amnt + amnt);
    if (new_scroll_amnt > 0) return;
    if (new_scroll_amnt <= -(num_modes-7)*MODE_HEIGHT) return;
    for (int i = 0; i < num_modes; i++) {
      color_modes[i].scroll(amnt);
    }
    scroll_amnt = new_scroll_amnt;
  }
  
  void update_alpha() {
    if (use_clrmodes && alpha < 255) {
      alpha += ALPHA_MODIFIER;
    }
    else if (!use_clrmodes && alpha > 0) {
      alpha -= ALPHA_MODIFIER*2;
    }
  }
  
  int[][] get_modes() {
    int[][] retval = new int[num_modes][MAX_CLR_PER_MODE+1];
    for(int i = 0; i < num_modes; i++) {
      clrmode m = color_modes[i];
      retval[i][0] = m.get_size();
      for(int j = 1; j <= MAX_CLR_PER_MODE; j++) {
        int clr_index = j-1;
        if (clr_index < m.get_size()) {
          if (m.color_buttons[clr_index].id == -1) {
            retval[i][j] = 0;
          }
          else {
            retval[i][j] = m.color_buttons[clr_index].id;
          }
        }
        else {
          retval[i][j] = 0;
        }
      }
    }
    return retval;
  }
  
  void save_modes(File selection) {
    try {
      PrintWriter writer = new PrintWriter(selection, "UTF-8");
      int[][] modes_arr = get_modes();
      writer.println(num_modes + "|" + MAX_CLR_PER_MODE);
      for(int i = 0; i < num_modes; i++) {
        writer.print(modes_arr[i][0] + ":");
        for(int j = 1; j <= modes_arr[i][0]; j++) {
          writer.print(modes_arr[i][j] + ",");
        }
        writer.println();
      }
      writer.close();
      println("Saved color palette to: " + selection);
    }
   catch (FileNotFoundException e) {
     println("FileNotFoundException: " + e);
    }
    catch (UnsupportedEncodingException e) {
     println("UnsupportedEncodingException: " + e);
    }
  }
  
  void load_modes(File selection) {
    StringBuilder sb = read_file(selection);
    String[] rows = sb.toString().replace(" ", "").replace("\r\n", "\n").split("\n");
    String[] header = rows[0].split("|");
    int new_num_modes = int(header[0]);
    for(int i = 0; i < new_num_modes; i++) {
      String[] row_meta = rows[i+1].split(":");
      int num_colors = int(row_meta[0]);
      if (num_colors < MAX_CLR_PER_MODE && num_colors != color_modes[i].get_size()) {
        color_modes[i].adjust_size(num_colors - color_modes[i].get_size());
      }
      String[] row = row_meta[1].split(",");
      for(int j = 0; j < num_colors; j++) {
        color_modes[i].color_buttons[j].set_id(int(row[j]));
      }
    }
    println("Successfully loaded color modes from: " + selection.getAbsolutePath());
  }
}