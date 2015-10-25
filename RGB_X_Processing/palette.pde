///////////////////
// Color Palette //
///////////////////

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.UnsupportedEncodingException;

class palette {
  int y, index = -1;
  clrbtn[] bcp;
  int alpha = 255;
  boolean horizontal;
  int btn_w, btn_h, btn_sp_x, btn_sp_y, btn_acr, btn_acr_unch;
  int[] color_palette;
  int rgb_arr_size, num_btns;
  
  palette (int[] _color_palette, int _y, int _size, int _btn_w, int _btn_h, int _btn_sp_x, int _btn_sp_y, int _btn_acr, boolean _horizontal) {
    y = _y;
    btn_w = _btn_w;
    btn_h = _btn_h;
    btn_sp_x = _btn_sp_x;
    btn_sp_y = _btn_sp_y;
    num_btns = _size;
    
    btn_acr_unch = _btn_acr;
    if (_btn_acr < _size) {
      btn_acr = _btn_acr;
    }
    else {
      btn_acr = _size;
    }
    
    rgb_arr_size = _size*3;
    horizontal = _horizontal;
    
    if (_color_palette == null) {
      _color_palette = get_default_palette();
    }
    initialize(_color_palette);
  }
  
  void initialize(int[] new_color_palette) {
    color_palette = new int[rgb_arr_size];
    
    for(int i = 0; i < rgb_arr_size; i++)
    {
      if(i<new_color_palette.length) {
        color_palette[i] = new_color_palette[i];
      }
      else {
        color_palette[i] = 0;
      }
    }
  }

  void adjust_size(int amnt) {
    int num_btns_new = num_btns + amnt;
    int btn_w_padded = (btn_w+btn_sp_x);
    int btn_h_padded = (btn_h+btn_sp_y);
    
    if (num_btns_new < 1) {
      println("Unable to reduce the size of the color palette below 1");
      return;
    }
    //these fancy little doo-dads will keep your palettes from going off screen..
    else if (amnt > 0 && horizontal && (((width-btn_w_padded)-(btn_w_padded*num_btns_new))/btn_w_padded < 0)) {
      println("Try increasing the form size");
      return;
    }
    else if (amnt > 0 && !horizontal && btn_h_padded*Math.ceil(float(num_btns_new)/btn_acr_unch) > height - y - btn_h_padded) {
      println("Try increasing the form size");
      return;
    }
    
    int rgb_arr_size_new = rgb_arr_size + amnt*3;
    int[] color_palette_new = new int[rgb_arr_size_new];
    
    // Fit the old array into the new one and pad if necessary
    for(int i = 0; i < rgb_arr_size_new; i++) {
      if(i<rgb_arr_size) {
        color_palette_new[i] = color_palette[i];
      }
      else {
        color_palette_new[i] = 0;
      }
    }
    
    if(num_btns_new < btn_acr || (num_btns_new > btn_acr && num_btns_new <= btn_acr_unch)) {
      btn_acr = num_btns_new;
    }
    
    index = -1;
    num_btns = num_btns_new;
    rgb_arr_size = rgb_arr_size_new;
    color_palette = color_palette_new;
    initialize_color_buttons();
  }
  
  void initialize_color_buttons() {
    int id = 0;
    int top_start = y;
    int next_top = top_start;
    
    int left_start = (width-((btn_w+btn_sp_x)*btn_acr))/2;
    int next_left = left_start;
    
    int top_inc = btn_h+btn_sp_y;
    int left_inc = btn_w+btn_sp_x;
    
    bcp = new clrbtn[num_btns];
    for (int i = 0; i < num_btns; i++) {
      if (i%btn_acr==0) {
        bcp[i] = new clrbtn(next_left = left_start,  next_top += top_inc, btn_w, btn_h, id++, true);
      }
      else {
        bcp[i] = new clrbtn(next_left += left_inc,  next_top += 0, btn_w, btn_h, id++, true);
      }
      
      bcp[i].clear_history();
      bcp[i].cor = color(color_palette[i*3 + 0],   // Red
                         color_palette[i*3 + 1],   // Green
                         color_palette[i*3 + 2]);  // Blue
    }
  }
  
  void fill_rainbow() {
    // Credit for this feature goes to Alvin Yao-Wen Cheung
    
    unselect();
    new_cor = BLACK;
    int phase = (int)random(0,1200);
    double frequency = Math.PI*2/num_btns;
    
    for (int i = 0; i < num_btns; i++) {
      color_palette[i*3+0] = (int)Math.floor(Math.sin(frequency*i+2+phase) * RAINBOW_PALETTE_CONTRAST + RAINBOW_PALETTE_BRIGHTNESS);
      color_palette[i*3+1] = (int)Math.floor(Math.sin(frequency*i+0+phase) * RAINBOW_PALETTE_CONTRAST + RAINBOW_PALETTE_BRIGHTNESS);
      color_palette[i*3+2] = (int)Math.floor(Math.sin(frequency*i+4+phase) * RAINBOW_PALETTE_CONTRAST + RAINBOW_PALETTE_BRIGHTNESS);
      
      bcp[i].clear_history();
      bcp[i].cor = color(color_palette[i*3 + 0],   // Red
                         color_palette[i*3 + 1],   // Green
                         color_palette[i*3 + 2]);  // Blue
    }
  }
  
  void update_clrsel(int stp) {
    if (index >= 0 && index < num_btns) {
      increment_index(stp);
    }
  }

  void render() {
    for (int i = 0; i < bcp.length; i++) {
      bcp[i].render(alpha);
    }
  }
  
  void check_for_btn_clicks() {
    int new_index = -1;
    for (int i = 0; i < bcp.length; i++) {
      if (bcp[i].isOver()) {
        bcp[i].click();
        update_color_palette_arr();
        new_index = i;
      }
    }
    if(index >= 0 && new_index != index) {
      bcp[index].unselect();
    }
    index = new_index;
    render();
  }
  
  void unselect() {
    if (index != -1) {
      bcp[index].unselect();
      index = -1;
    }
  }
  
  void insert_selected() {
    if (index == -1) {
      return;
    }
    println("Inserting Color #" + index);
    int curr_index = index;
    adjust_size(1);
    for (int i = num_btns - 1; i > curr_index; i--) {
      color_palette[i*3+0] = color_palette[(i*3+0) - 3];
      color_palette[i*3+1] = color_palette[(i*3+1) - 3];
      color_palette[i*3+2] = color_palette[(i*3+2) - 3];
    }
    
    color_palette[curr_index*3+0] = 0;
    color_palette[curr_index*3+1] = 0;
    color_palette[curr_index*3+2] = 0;
    
    initialize_color_buttons();
    set_index(curr_index);
  }
  
  void remove_selected() {
    if (index == -1 || num_btns == 1) {
      return;
    }
    println("Deleting Color #" + index);
    int curr_index = index;
    
    for (int i = index; i < bcp.length - 1; i++) {
      color_palette[i*3+0] = color_palette[(i*3+0)+3];
      color_palette[i*3+1] = color_palette[(i*3+1)+3];
      color_palette[i*3+2] = color_palette[(i*3+2)+3];
    }
    
    adjust_size(-1);
    initialize_color_buttons();
    
    if (curr_index == num_btns) {
      curr_index = curr_index - 1;
    }
    set_index(curr_index);
  }
  
  void reset_selected() {
    if (index == -1) {
      return;
    }
    
    bcp[index].reset();
    update_color_palette_arr();
  }
  
  void reset_all() {
    for (int i = 0; i < bcp.length; i++) {
      bcp[i].reset();
    }
  }
  
  void undo() {
    if (index == -1) {
      return;
    }
    
    bcp[index].undo();
    update_color_palette_arr();
  }
  
  void update_color() {
    if (index == -1) {
      return;
    }
    
    color_palette[index*3+0] = sV1.p;
    color_palette[index*3+1] = sV2.p;
    color_palette[index*3+2] = sV3.p;
    bcp[index].update_color(sV1.p, sV2.p, sV3.p, true);
  }
  
  void update_color_palette_arr() {
    for(int i = 0; i < bcp.length; i++) {
      color_palette[i*3+0] = (bcp[i].cor >> 16) & 0xFF;
      color_palette[i*3+1] = (bcp[i].cor >> 8) & 0xFF;
      color_palette[i*3+2] = (bcp[i].cor & 0xFF);
    }
  }
  
  int[] get_palette() {
    return color_palette;
  }
  
  String[] print_palette() {
    String[] retval = new String[bcp.length];
    for(int i = 0; i < bcp.length; i++) {
      int[] rgb = { color_palette[i*3+0],
                    color_palette[i*3+1],
                    color_palette[i*3+2]
                  };
      retval[i] = print_color(rgb, i, i == bcp.length - 1);
    }
    return retval;
  }
  
  void set_index(int new_cor_index) {
    if (new_cor_index < 0) {
      new_cor_index = num_btns - 1;
    }
    else if (new_cor_index >= num_btns) {
      new_cor_index = 0;
    }
    
    if (index >= 0 && index < num_btns) {
      bcp[index].unselect();
    }
    index = new_cor_index;
    bcp[index].select();
    new_cor = bcp[index].cor;
  }
  
  void increment_index(int stp) {
    int new_index = index + stp;
    set_index(new_index);
  }
  
  int get_size() {
    return num_btns;
  }
  
void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
  }
}
  
  void save_palette(File selection) {
    try {
      PrintWriter writer = new PrintWriter(selection, "UTF-8");
      writer.print(String.join("\r\n", print_palette()));
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
  
  void load_palette(File selection) {
    StringBuilder sb = new StringBuilder();
    try {
      InputStream input = new FileInputStream(selection);
      int data = input.read();
      while(data != -1) {
       sb.append((char)data);
       data = input.read();
      }
      sb.append((char)data);
      input.close();
      
      int rgb_arr_size_new = 0;
      String[] rows = sb.toString().replace(" ", "").replace("\r\n", "\n").split("\n");
      for(int i = 0; i < rows.length; i++) {
        String[] row = rows[i].split("//")[0].split(",");
        if(row.length == 3 || row.length == 4) {
          for(int j = 0; j < row.length; j++) {
            rgb_arr_size_new++;
          }
        }
      }
      int[] color_palette_new = new int[rgb_arr_size_new];
      
      //println("rgb_arr_size_new="+rgb_arr_size_new);
      //println("rows.length="+rows.length);
      //println("color_palette_new.length="+color_palette_new.length);
      
      for(int i = 0; i < rows.length; i++) {
        //println("rows[i]="+rows[i]);
        String[] row = rows[i].split("//")[0].split(",");
        if(row.length == 3 || row.length == 4) {
          color_palette_new[(i*3)+0] = int(row[0]);
          //println("R="+int(row[0]));
          color_palette_new[(i*3)+1] = int(row[1]);
          //println("G="+int(row[1]));
          color_palette_new[(i*3)+2] = int(row[2]);
          //println("B="+int(row[2]));
        }
        //else {
        //  println("Invalid row: " + row);
        //}
      }
      
      btn_acr = btn_acr_unch;
      num_btns = rgb_arr_size_new/3;
      rgb_arr_size = rgb_arr_size_new;
      color_palette = color_palette_new;
      initialize_color_buttons();
      println("Successfully loaded color palette from: " + selection.getAbsolutePath());
    }
    catch (FileNotFoundException e) {
      println("FileNotFoundException: " + e);
    }
    catch (IOException e) {
     println("IOException: " + e);
    }
    catch (Exception e) {
     println("Exception: " + e);
    }
  }
}