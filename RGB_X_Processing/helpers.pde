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
  if (new_cor_index < 0) {
    cor_index = 32;
  }
  else if (new_cor_index > 32) {
    cor_index = 0;
  }
  else {
    cor_index = new_cor_index;
  }
}

void update_sliders() {
  int[] rgb = getRGB(main_cor);
    sV1.p = rgb[0];
    sV2.p = rgb[1];
    sV3.p = rgb[2];
    println(rgb[0] + ", " + rgb[1] + ", " + rgb[2] + ",");
}