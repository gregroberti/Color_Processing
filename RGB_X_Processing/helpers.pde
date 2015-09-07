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