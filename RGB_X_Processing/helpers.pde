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

void increment_index(int stp) {
  int new_cor_index = cor_index + stp;
  while (new_cor_index < 0 || new_cor_index > 32) {
    if (new_cor_index < 0) {
      new_cor_index = new_cor_index + 33;
    }
    else if (new_cor_index > 32) {
      new_cor_index = new_cor_index - 33;
    }
  }
  cor_index = new_cor_index;
}

void update_sliders() {
  int[] rgb = getRGB(main_cor);
    sV1.p = rgb[0];
    sV2.p = rgb[1];
    sV3.p = rgb[2];
}

void initialize_color_palette() {
  for (int i = 0; i < bcp.length; i++) {
    bcp[i].cor = color(color_palette[i*3],
                        color_palette[i*3 + 1],
                        color_palette[i*3 + 2]);
  }
  
  // Set selection to Color #0
  bcp[0].sel();
}

void update_palette(int[] new_palette) {
  if (new_palette.length == color_palette.length) {
    color_palette = new_palette;
    initialize_color_palette();
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
  
}