///////////////////
// Color Palette //
///////////////////

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.UnsupportedEncodingException;

class palette {
  int y, index = -1;
  clrbtn[] bcp;
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
    
    for(int i=0; i<rgb_arr_size; i++)
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
    
    if (num_btns_new < 1) {
      println("Unable to reduce the size of the color palette below 1");
      return;
    }
    //this fancy little doo-dad will keep your live preview buttons from going off screen..
    else if (horizontal && (((FORM_WIDTH-btn_w_padded)-(btn_w_padded*num_btns_new))/btn_w_padded < 0)) {
      println("Try increasing the form size");
      return;
    }
    
    int rgb_arr_size_new = rgb_arr_size + amnt*3;
    int[] color_palette_new = new int[rgb_arr_size_new];
    
    // Fit the old array into the new one and pad if necessary
    for(int i=0; i<rgb_arr_size_new; i++) {
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
    
    int left_start = (FORM_WIDTH-((btn_w+btn_sp_x)*btn_acr))/2;
    int next_left = left_start;
    
    int top_inc = btn_h+btn_sp_y;
    int left_inc = btn_w+btn_sp_x;
    
    bcp = new clrbtn[num_btns];
    for (int i=0; i<num_btns; i++) {
      if (i%btn_acr==0) {
        bcp[i] = new clrbtn(next_left = left_start,  next_top += top_inc, btn_w, btn_h, id++);
      }
      else {
        bcp[i] = new clrbtn(next_left += left_inc,  next_top += 0, btn_w, btn_h, id++);
      }
      bcp[i].cor = color(color_palette[i*3 + 0],   // Red
                         color_palette[i*3 + 1],   // Green
                         color_palette[i*3 + 2]);  // Blue

      bcp[i].clear_history();
    }
  }
  
  void update_clrsel(int stp) {
    if (index >= 0 && index < num_btns) {
      increment_index(stp);
    }
  }

  void render() {
    for (int i = 0; i < bcp.length; i++) {
      bcp[i].render();
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
      bcp[index].unsel();
    }
    index = new_index;
    render();
  }
  
  void unselect() {
    if (index != -1) {
      bcp[index].unsel();
      index = -1;
    }
  }
  
  void reset_selected() {
    if (index != -1) {
      bcp[index].reset();
      update_color_palette_arr();
    }
  }
  
  void reset_all() {
    for (int i = 0; i < bcp.length; i++) {
      bcp[i].reset();
    }
  }
  
  void undo() {
    if (index != -1) {
      bcp[index].undo();
      update_color_palette_arr();
    }
  }
  
  void update_color() {
    if (index != -1) {
      color_palette[index*3+0] = sV1.p;
      color_palette[index*3+1] = sV2.p;
      color_palette[index*3+2] = sV3.p;
      bcp[index].update_color(sV1.p, sV2.p, sV3.p, true);
    }
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
  
  String print_palette() {
    String retval = "";
    for(int i = 0; i < bcp.length; i++) {
      int red = color_palette[i*3+0];
      int green = color_palette[i*3+1];
      int blue = color_palette[i*3+2];
      String line = "";
      
      if (i != bcp.length - 1) {
        line = red + ", " + green + ", " + blue + ",";
      }
      else {
        line = red + ", " + green + ", " + blue;
      }
      
      while (line.length() < 16) {
        line += " ";
      }
      
      retval += line + "// Color #" + i + "\r\n";
      
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
    
    if (index >= 0) {
      bcp[index].unsel();
    }
    index = new_cor_index;
    bcp[index].sel();
    new_cor = bcp[index].cor;
  }
  
  void increment_index(int stp) {
    int new_index = index + stp;
    set_index(new_index);
  }
  
  int get_size() {
    return num_btns;
  }
  
  void save_palette() {
    try {
      String fname = System.getProperty("user.home") + "\\Desktop\\color_palette.txt";
      PrintWriter writer = new PrintWriter(fname, "UTF-8");
      writer.print(print_palette());
      writer.close();
      println("Saved color palette to: " + fname);
    }
    catch (FileNotFoundException e) {
      println("FileNotFoundException: " + e);
    }
    catch (UnsupportedEncodingException e) {
      println("UnsupportedEncodingException: " + e);
    }
  }
  
  void load_palette() {
    StringBuilder sb = new StringBuilder();
    String fname = System.getProperty("user.home") + "\\Desktop\\color_palette.txt";
    try {
      InputStream input = new FileInputStream(fname);
      int data = input.read();
      while(data != -1) {
       sb.append((char)data);
       data = input.read();
      }
      sb.append((char)data);
      input.close();
      
      int rgb_arr_size_new = 0;
      String[] rows = sb.toString().replace(" ", "").split("\r\n");
      for(int i=0; i<rows.length; i++) {
        String[] row = rows[i].split("//")[0].split(",");
        if(row.length == 3 || row.length == 4) {
          for(int j=0; j<row.length; j++) {
            rgb_arr_size_new++;
          }
        }
      }
      int[] color_palette_new = new int[rgb_arr_size_new];
      
      println("rgb_arr_size_new="+rgb_arr_size_new);
      println("rows.length="+rows.length);
      println("color_palette_new.length="+color_palette_new.length);
      
      for(int i=0; i<rows.length; i++) {
        println("rows[i]="+rows[i]);
        String[] row = rows[i].split("//")[0].split(",");
        if(row.length == 3 || row.length == 4) {
          color_palette_new[(i*3)+0] = int(row[0]);
          println("R="+int(row[0]));
          color_palette_new[(i*3)+1] = int(row[1]);
          println("G="+int(row[1]));
          color_palette_new[(i*3)+2] = int(row[2]);
          println("B="+int(row[2]));
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
      println("Successfully loaded color palette from: " + fname);
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