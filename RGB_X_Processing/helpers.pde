//////////////////////
// Helper Functions //
//////////////////////

void render_help_txt() {
  fill(255);
  text("Press F1 for keyboard shortcuts!", (FORM_WIDTH / 2) - 90, 25);
  
}

void print_keyboard_shortcuts() {
  println("\nKEYBORD SHORTCUTS:");
  println("- Type 'C' to clear the color palette (toggle white/black)");
  println("- Type 'R' to select a random RGB value");
  println("- Arrow keys to navigate the color palette");
  println("- Number keys 0-9 select the corresponding live preview button");
  println("- Enter (or right-click) sets the selected button to the slider values");
  println("- Backspace undoes changes to your selected button");
  println("- Delete (or double-click) 'resets' a button (toggle white/black)");
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

void update_brightness(int pct) {
  int[] rgb = getRGB(main_cor);
  int[] new_rgb = new int[rgb.length];
  
  // Repeat for R, G, and B
  for(int i=0; i<rgb.length; i++) {
    
    // Determine amount to increase/decrease
    float amnt = rgb[i]*((float)pct/100);
    if (amnt < 1 && amnt > 0) {
      amnt = 1;
    }
    else if (amnt > -1 && amnt < 0) {
      amnt = -1;
    }
    else if (amnt == 0) {
      if (pct > 0) {
        amnt = 1;
      }
      else if (pct < 0) {
        amnt = -1;
      }
    }
    
    // Update the value
    int new_val = int(rgb[i] + amnt);
    if(new_val < 0) {
      new_rgb[i] = 0;
    }
    else if(new_val > 255) {
      new_rgb[i] = 255;
    }
    else {
      new_rgb[i] = new_val;
    }
  }
  new_cor = color(new_rgb[0], new_rgb[1], new_rgb[2]);
}