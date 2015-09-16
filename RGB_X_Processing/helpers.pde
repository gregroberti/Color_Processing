//////////////////////
// Helper Functions //
//////////////////////

void render_help_txt() {
  fill(255);
  text("Press F1 for keyboard shortcuts!", (FORM_WIDTH / 2) - 90, 25);
  
}

void print_keyboard_shortcuts() {
  println("KEYBORD SHORTCUTS:");
  println("'c' will clear the color palette (sets all presets to white)");
  println("Arrow keys navigate the color palette (and live preview palette)");
  println("0-9 will select the corresponding color preset button");
  println("Enter will set the selected button to the slider values");
  println("Backspace will undo changes to your selected button");
  println("Delete will 'reset' a button (white/black)");
  println("Plus/Minus toggles 'brightness' (lowers/raises all slider values equally)");
  println("Space bar toggles live preview");
  println("F11 will decrease the size of your color palette");
  println("F12 will increase the size of your color palette");
  println("Page Up will increase the number of live preview buttons");
  println("Page Down will decrease the number of live preview buttons");
  println("Home will increase the speed of live preview playback");
  println("End will decrease the speed of live preview playback");
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