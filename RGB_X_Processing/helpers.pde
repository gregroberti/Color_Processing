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