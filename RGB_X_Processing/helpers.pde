//////////////////////
// Helper Functions //
//////////////////////

int[] getRGB(color _cor) {
  return new int[]{ (_cor >> 16) & 0xFF,
                    (_cor >> 8) & 0xFF,
                    (_cor & 0xFF)
                  };
}

void unselect_all() {
  for (int i = 0; i < bcp.length; i++) {
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

void update_sliders() {
  int[] rgb = getRGB(main_cor);
  sV1.p = rgb[0];
  sV2.p = rgb[1];
  sV3.p = rgb[2];
}

void initialize_color_buttons() {
  int id = 0;
  int left = 0;
  int top = 360;
  for (int i = 0; i < bcp.length; i++) {
    println(i);
    if (i%NUM_BUTTONS_ACROSS==0) {
      bcp[i] = new clrbtn(left = 57,  top += 35, id++);
    }
    else
    {
      bcp[i] = new clrbtn(left += 35,  top += 0, id++);
    }
    println(color_palette.length);
    color pset = color(color_palette[i*3 + 0],   // Red
                       color_palette[i*3 + 1],   // Green
                       color_palette[i*3 + 2]);  // Blue
    bcp[i].cor = pset;
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

void update_brightness(int stp) {
  int[] rgb = getRGB(main_cor);
  int[] new_rgb = new int[rgb.length];
  
  for(int i=0; i<rgb.length; i++) {
    if(rgb[i]+stp < 0) {
      new_rgb[i] = 0;
    }
    else if(rgb[i]+stp > 255) {
      new_rgb[i] = 255;
    }
    else {
      new_rgb[i] = rgb[i]+stp;
    }
  }
  main_cor = color(new_rgb[0], new_rgb[1], new_rgb[2]);
  update_sliders();
}