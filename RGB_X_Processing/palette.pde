///////////////////
// Color Palette //
///////////////////

class palette {
  clrbtn[] bcp;
  int[] color_palette;
  int rgb_arr_size, num_btns;
  
  palette (int _size) {
    num_btns = _size;
    rgb_arr_size = _size*3;
    initialize(get_default_palette());
  }
  
  void initialize(int[] new_color_palette) {
    bcp = new clrbtn[num_btns];
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
  }
  
  void initialize_color_buttons() {
    int id = 0;
    int top_start = 360;
    int next_top = top_start;
    
    int left_start = (FORM_WIDTH-((COLOR_BTN_WIDTH+COLOR_BTN_SPACE)*NUM_BUTTONS_ACROSS))/2;
    int next_left = left_start;
    
    int top_inc = COLOR_BTN_HEIGHT+COLOR_BTN_SPACE;
    int left_inc = COLOR_BTN_WIDTH+COLOR_BTN_SPACE;
    
    for (int i=0; i<num_btns; i++) {
      if (i%NUM_BUTTONS_ACROSS==0) {
        bcp[i] = new clrbtn(next_left = left_start,  next_top += top_inc, id++);
      }
      else {
        bcp[i] = new clrbtn(next_left += left_inc,  next_top += 0, id++);
      }
      bcp[i].cor = color(color_palette[i*3 + 0],   // Red
                         color_palette[i*3 + 1],   // Green
                         color_palette[i*3 + 2]);  // Blue

      bcp[i].clear_history();
    }
    set_index(0);
  }
  
  void update_palette(int[] new_palette) {
    if (new_palette.length == color_palette.length) {
      color_palette = new_palette;
      initialize_color_buttons();
      //println("Sucessfully updated the color_palette");
    }
    //else {
    //  println("color_palette.length = " + color_palette.length);
    //  println("new_palette.length = " + new_palette.length);
    //  println("ERROR: The new color palette is the wrong size!");
    //}
  }
  
  void update_clrsel(int stp) {
    bcp[cor_index].unsel();
    increment_index(stp);
    bcp[cor_index].sel();
    update_sliders();
  }
 
 int[] get_default_palette() {
   return new int[] {
       
     //////////////////////////////////////////////
     // PASTE YOUR COLOR PALETTE BELOW THIS LINE //
     //////////////////////////////////////////////
      
     0, 0, 0,     //  Color #0 Blank
     100, 0, 0,   //  Color #1 Red
     100, 25, 0,  //  Color #2 Sunset
     100, 50, 0,  //  Color #3 Orange
     100, 75, 0,  //  Color #4 Canary
     100, 100, 0, //  Color #5 Yellow
     20, 100, 0,  //  Color #6 Lime
     0, 100, 0,   //  Color #7 Green
     0, 100, 10,  //  Color #8 Sea Foam
     13, 100, 13, //  Color #9 Mint 
     0, 100, 40,  //  Color #10 Aqua
     0, 121, 73,  //  Color #11 Turquoise
     0, 100, 108, //  Color #12 Cyan
     0, 65, 100,  //  Color #13 Frostbolt
     0 , 42, 100, //  Color #14 Frozen  
     0, 22, 100,  //  Color #15 Azure
     0, 0, 100,   //  Color #16 Blue
     3, 0, 100,   //  Color #17 Cobalt
     13, 0, 100,  //  Color #18 Mothafuckin Purple
     26, 0, 100,  //  Color #19 Purple Drank
     30, 14, 100, //  Color #20 Lavender
     47, 26, 100, //  Color #21 Mauve 
     100, 25, 25, //  Color #22 Lemonade
     50, 0, 100,  //  Color #23 Bubblegum  
     75, 0, 100,  //  Color #24 Magenta  
     100, 0, 100, //  Color #25 Pink    
     100, 0, 75,  //  Color #26 Hot Pink
     100, 0, 50,  //  Color #27 Deep Pink    
     100, 0, 25,  //  Color #28 Fuscia
     100, 0, 10,  //  Color #29 Panther Pink
     35, 67, 120, //  Color #30 Lilac  
     13, 120, 100,//  Color #31 Polar   
     34, 99, 120  //  Color #32 Moonstone
      
     //////////////////////////////////////////////
     // PASTE YOUR COLOR PALETTE ABOVE THIS LINE //
     //////////////////////////////////////////////
   };
 }

  void render() {
    for (int i = 0; i < bcp.length; i++) {
      bcp[i].render();
    }
  }
  
  void check_for_btn_clicks() {
    for (int i = 0; i < bcp.length; i++) {
      if (bcp[i].isOver()) {
        bcp[i].click();
        cor_index = i;
        return;
      }
    }
  }
  
  void check_for_btn_release() {
    for (int i = 0; i < bcp.length; i++) {
      if (bcp[i].isOver()) {
        bcp[i].release();
      }
    }
  }
  
  void reset_btn(int cor_index) {
    bcp[cor_index].reset();
  }
  
  void undo(int cor_index) {
    bcp[cor_index].undo();
  }
  
  void update_color(int cor_index) {
    bcp[cor_index].update_color(sV1.p, sV2.p, sV3.p, true);
  }
  
  void unselect_all() {
    for (int i=0; i<bcp.length; i++) {
      bcp[i].unsel();
    }
  }
  String print_palette() {
    String retval = "";
    for(int i = 0; i < bcp.length; i++) {
      int red = (bcp[i].cor >> 16) & 0xFF;
      int green = (bcp[i].cor >> 8) & 0xFF;
      int blue = (bcp[i].cor & 0xFF);
      
      if (i != bcp.length - 1) {
        retval += red + ", " + green + ", " + blue + ",  // Color #" + i + "\r\n";
      }
      else {
        retval += red + ", " + green + ", " + blue + "   // Color #" + i + "\r\n";
      }
    }
    return retval;
  }
  
  void set_index(int new_cor_index) {
    while (new_cor_index < 0 || new_cor_index > 32) {
      if (new_cor_index < 0) {
        new_cor_index = new_cor_index + 33;
      }
      else if (new_cor_index > 32) {
        new_cor_index = new_cor_index - 33;
      }
    }
    cor_index = new_cor_index;
    bcp[cor_index].sel();
    main_cor = bcp[cor_index].cor;
    update_sliders();
  }
  
  void increment_index(int stp) {
    int new_cor_index = cor_index + stp;
    set_index(new_cor_index);
  }


}