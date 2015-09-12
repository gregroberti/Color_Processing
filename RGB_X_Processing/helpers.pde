//////////////////////
// Helper Functions //
//////////////////////

void toggle_live_preview() {
  live_preview = !live_preview;
  if (live_preview) {
    preset_palette.unselect();
    preview_palette.set_index(0);
  }
}

int[] getRGB(color _cor) {
  return new int[]{ (_cor >> 16) & 0xFF,
                    (_cor >> 8) & 0xFF,
                    (_cor & 0xFF)
                  };
}

void update_sliders() {
  int[] rgb = getRGB(main_cor);
  sV1.p = rgb[0];
  sV2.p = rgb[1];
  sV3.p = rgb[2];
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