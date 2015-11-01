/////////////////
// Color Modes //
/////////////////


class clrmodes extends elembase {
  int num_modes = 8;
  int num_btns;
  int alpha = 0;
  int index = -1;
  clrmode[] color_modes;
  exportclrmodes export_cm;
  importclrmodes import_cm;
  
  clrmodes (int _x, int _y, int _w, int _h, int _num_btns) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    bor_cor = GREY;
    num_btns = _num_btns;
    initialize_modes();
    export_cm = new exportclrmodes(x + w - 80, y - 30);
    import_cm = new importclrmodes(x, y - 30);
  }
  
  void initialize_modes() {
    int top = y - 25;
    color_modes = new clrmode[num_btns];
    for(int i = 0; i < color_modes.length; i++) {
      color_modes[i] = new clrmode(x+10, top += 35, w-20, 35, i, 3);
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
    if (export_cm.isOver()) {
      export_cm.click();
    }
    else if (import_cm.isOver()) {
      import_cm.click();
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
    turn_off_light();
  }
  
  void select_mode(int new_index) {
    if (index_in_bounds()) {
      color_modes[index].unselect();
    }
    index = new_index;
    color_modes[index].select();
  }
  
  void render() {
    update_alpha();
    render_border(alpha);
    render_fill(alpha);
    export_cm.render(alpha);
    import_cm.render(alpha);
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
  
  int[] get_palette() {
    int[] retval = new int[64];
    for(int i = 0; i < num_modes; i++) {
      clrmode m = color_modes[i];
      retval[i*8] = m.get_size();
      for(int j = 1; j < num_modes; j++) {
        if (j-1 < m.get_size()) {
          if (m.color_buttons[j-1].id == -1) {
            retval[i*num_modes + j] = 0;
          }
          else {
            retval[i*num_modes + j] = m.color_buttons[j-1].id;
          }
        }
        else {
          retval[i*num_modes + j] = 0;
        }
      }
    }
    return retval;
  }
  
  void save_modes(File selection) {
    try {
      PrintWriter writer = new PrintWriter(selection, "UTF-8");
      int mode = 1;
      int line_count = 1;
      int[] modes_arr = get_palette();
      for(int i = 0; i <= 64; i++) {
        if(i > 0 && i % 8 == 0) {
          writer.print("  0," + line_count++ + ",    // Mode " + mode + "  // Prime A\r\n");
          writer.print("  0,0,  0,0,  0,0,  0,0,  0,0,  0,0,  0,0,  0,0,  0," + line_count++ + ",   // Mode " + mode++ + "  // Prime B\r\n");
        }
        if (i < 64) {
          writer.print("  " + modes_arr[i] + ",0,");
        }
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
    
    int current_mode = 0;
    int[][] mode_array = new int[num_modes][8];
    for(int i = 0; i < rows.length; i++) {
      if (rows[i].length() == 0) {
        continue;
      }
      
      if (i % 2 == 0 && current_mode < num_modes) { // Prime A
        String[] row = rows[i].split("//")[0].split(",");
        int num_colors = int(row[0]);
        
        for(int j = 1; j <= num_colors; j++) {
          mode_array[current_mode][j] = int(row[j*2]);
        }
        mode_array[current_mode][0] = num_colors;
        current_mode++;
      }
    }
    
    for (int i = 0; i < num_modes; i++) {
      int num_colors = int(mode_array[i][0]);
      int size = color_modes[i].get_size();
      if (num_colors != size) {
        color_modes[i].adjust_size(num_colors - size);
      }
      
      for (int j = 1; j <= num_colors; j++) {
        color_modes[i].color_buttons[j-1].set_id(mode_array[i][j]);
      }
    }
    println("Successfully loaded color modes from: " + selection.getAbsolutePath());
  }
}