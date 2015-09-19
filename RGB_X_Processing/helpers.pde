//////////////////////
// Helper Functions //
//////////////////////

color get_random_color() {
  int rgb[] = { int(random(256)), int(random(256)), int(random(256)) };
  switch (int(random(10))) {
    case 0:
      rgb[0] = 0;
      break;
    case 1:
      rgb[1] = 0;
      break;
    case 2:
      rgb[2] = 0;
      break;
  }
  //println("Random color: " + rgb[0] + ", " + rgb[1] + ", " + rgb[2]);
  return color(rgb[0], rgb[1], rgb[2]);
}

void update_sliders(int[] rgb) {
  sV1.p = rgb[0];
  sV2.p = rgb[1];
  sV3.p = rgb[2];
  calculate_ratio();
}

void render_help_txt() {
  fill(255);
  text("Press F1 for keyboard shortcuts!", (FORM_WIDTH / 2) - 90, 25);
}

void calculate_ratio() {
  int min = 0;
  int[] rgb = getRGB(main_cor);
  
  if (rgb[0] == 0 && rgb[1] == 0 && rgb[2] > 0) {
    min = rgb[2];
  }
  else if (rgb[0] == 0 && rgb[1] > 0 && rgb[2] == 0) {
    min = rgb[1];
  }
  else if (rgb[0] > 0 && rgb[1] == 0 && rgb[2] == 0) {
    min = rgb[0];
  }
  else if (rgb[0] == 0 && rgb[1] > 0 && rgb[2] > 0) {
    min = min(rgb[1], rgb[2]);
  }
  else if (rgb[0] > 0 && rgb[1] == 0 && rgb[2] > 0) {
    min = min(rgb[0], rgb[2]);
  }
  else if (rgb[0] > 0 && rgb[1] > 0 && rgb[2] == 0) {
    min = min(rgb[0], rgb[1]);
  }
  else {
    min = min(rgb[0], rgb[1], rgb[2]);
  }
  
  if(min == 0) {
    min = 1;
  }
  
  for (int i=0; i < rgb.length; i++) {
    rgb_ratio[i] = (float)rgb[i] / min;
  }
}
 
 void render_ratio_txt() {
  fill(255);
  text(rgb_ratio[0], sV1.x + (sV1.w/2) - 20, sV1.y + sV1.h + 30);
  text(":", sV1.x + sV1.w + 3, sV1.y + sV1.h + 30);
  text(rgb_ratio[1], sV2.x + (sV2.w/2) - 20, sV2.y + sV2.h + 30);
  text(":", sV2.x + sV2.w + 3, sV2.y + sV2.h + 30);
  text(rgb_ratio[2], sV3.x + (sV3.w/2) - 20, sV3.y + sV3.h + 30);
}

void print_keyboard_shortcuts() {
  println("\nKEYBORD SHORTCUTS:");
  println("- Esc will close Slider-Pro!");
  println("- Type 'C' to clear the color palette (toggle white/black)");
  println("- Type 'R' to select a random RGB value");
  println("- Arrow keys to navigate the color palette");
  println("- Number keys 0-9 select the corresponding live preview button");
  println("- Enter (or right-click) sets the selected button to the slider values");
  println("- Backspace undoes changes to your selected button");
  println("- Delete (or double-click) 'resets' a button (toggle white/black)");
  println("- Plus increases the brightness of the main color");
  println("- Minus decreases the brightness of the main color");
  println("- Space bar toggles live preview");
  println("- F1 displays this help menu");
  println("- F11 decreases the size of your color palette");
  println("- F12 increases the size of your color palette");
  println("- Page Up increases the number of live preview buttons");
  println("- Page Down decreases the number of live preview buttons");
}

void turn_off_light() {
  preset_palette.unselect();
  preview_palette.unselect();
  new_cor = color(0, 0, 0);
  main_cor = color(0, 0, 0);
  int[] rgb = getRGB(new_cor);
  update_sliders(rgb);
  render_everything();
  
  if (connected) {
    port.write('R');
    port.write(0);
    port.write('G');
    port.write(0);
    port.write('B');
    port.write(0);
  }
}

void disable_live_preview() {
  if(live_preview) {
    set_live_preview(false);
  }
}

void toggle_live_preview() {
  set_live_preview(live_preview = !live_preview);
}

void set_live_preview(boolean _live_preview) {
  live_preview = _live_preview;
  turn_off_light();
  
  if (live_preview) {
    println("Live Preview Enabled");
    if (connected) {
      port.write('L');
      int[] color_palette = preview_palette.get_palette();
      for (int i = 0; i < color_palette.length; i++) {
        port.write(color_palette[i]);
      }
      port.write('P');
    }
  }
  else {
    println("Live Preview Disabled");
  }
}

int[] getRGB(color _cor) {
  return new int[]{ (_cor >> 16) & 0xFF,
                    (_cor >> 8) & 0xFF,
                    (_cor & 0xFF)
                  };
}

void update_brightness(int amnt) {
  int[] rgb = getRGB(main_cor);
  int[] new_rgb = new int[rgb.length];
  
  // Repeat for R, G, and B
  for (int i=0; i<rgb.length; i++) {
    if (rgb[i] > 0) {
      int new_val = rgb[i] + int(rgb_ratio[i]*amnt);
      if (new_val <= 0 || new_val > 255) {
        return;
      }
      else {
        new_rgb[i] = new_val;
      }
    }
  }
  new_cor = color(new_rgb[0], new_rgb[1], new_rgb[2]);
}