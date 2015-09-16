//////////////////////
// Helper Functions //
//////////////////////

void render_help_txt() {
  fill(255);
  text("Press F1 for keyboard shortcuts!", (FORM_WIDTH / 2) - 90, 25);
  
}

void print_keyboard_shortcuts() {
  println("KEYBORD SHORTCUTS:");
  println("- Type 'C' to clear the color palette (toggle white/black)");
  println("- Arrow keys to navigate the color palette");
  println("- Number keys 0-9 select the corresponding live preview button");
  println("- Enter sets the selected button to the slider values");
  println("- Backspace undoes changes to your selected button");
  println("- Delete 'resets' a button (toggle white/black)");
  println("- Plus/minus toggles 'brightness' (lowers/raises all slider values equally by 10)");
  println("- Space bar toggles live preview");
  println("- F1 displays this help menu");
  println("- F11 decreases the size of your color palette");
  println("- F12 increases the size of your color palette");
  println("- Page Up increases the number of live preview buttons");
  println("- Page Down decreases the number of live preview buttons");
  println("- Home increase the speed of live preview playback");
  println("- End decreases the speed of live preview playback");
}

void toggle_live_preview() {
  live_preview = !live_preview;
  if (live_preview) {
    LIVE_PREVIEW_COUNTER = 0;
    preset_palette.unselect();
    preview_palette.set_index(0);
  }
  else {
    preview_palette.unselect();
    new_cor = color(0, 0, 0);
  }
}

int[] getRGB(color _cor) {
  return new int[]{ (_cor >> 16) & 0xFF,
                    (_cor >> 8) & 0xFF,
                    (_cor & 0xFF)
                  };
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
  new_cor = color(new_rgb[0], new_rgb[1], new_rgb[2]);
}