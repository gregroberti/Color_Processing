////////////////////////
// Callback Functions //
////////////////////////

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  int[] rgb = getRGB(main_cor);
  if (use_sliders) {
    if (sV1.isOver()){
       rgb[0] -= MOUSE_WHEEL_INC*e;
    }
    else if (sV2.isOver()){
       rgb[1] -= MOUSE_WHEEL_INC*e;
    }
    else if (sV3.isOver()) {
       rgb[2] -= MOUSE_WHEEL_INC*e;
    }
    new_cor = color(rgb[0], rgb[1], rgb[2]);
  }
  else if (use_picker) {
    new_cor = get_random_color();
  }
  else if (use_image && image_picker.isOver()) {
    image_picker.zoom(e);
  }
  
  if (new_cor != main_cor) {
    unselect_all();
  }
}

void mousePressed() {
  fillpalette = false;
  clearpalette = false;
  disable_live_preview();
  color_modes.check_for_btn_clicks();
  preview_palette.check_for_btn_clicks();
  preset_palette.check_for_btn_clicks();

  if (use_sliders) {
    if (sV1.isOver()) {
      sV1.click();
    }
    else if (sV2.isOver()) {
      sV2.click();
    }
    else if (sV3.isOver()) {
      sV3.click();
    }
  }
  
  if (export_cp.isOver()) {
    export_cp.click();
  }
  else if (import_cp.isOver()) {
    import_cp.click();
  }
}

public void keyPressed(KeyEvent e) {
  if (clearpalette) {
    if (e.getKeyCode() != 67) {
      println("Pffew, that was close :)");
    }
    else if (e.getKeyCode() == 67) {
      println("All gone!");
      preset_palette.reset_all();
    }
    clearpalette = false;
  }
  else if (fillpalette) {
    if (e.getKeyCode() != 70) {
      println("Pffew, that was close :)");
    }
    else if (e.getKeyCode() == 70) {
      println("Your shiny new rainbow color palette is complete!");
      preset_palette.fill_rainbow();
    }
    fillpalette = false;
  }
  else if (live_preview && e.getKeyCode() != 32) {
    disable_live_preview();
  }
  else if (e.getKeyCode() == 67) { // C
    println("Press 'c' again to clear the color preset palette (white/black)");
    clearpalette = true;
  }
  else if (e.getKeyCode() == 70) { // F
    println("Press 'f' again to replace the color palette with evenly spaced colors");
    fillpalette = true;
  }
  else if (e.getKeyCode() == 73) { // I
    preview_palette.insert_selected();
    preset_palette.insert_selected();
  }
  else if (e.getKeyCode() == 80) { // P
    println();
    println("// Color Palette (" + preset_palette.num_btns + " colors) //");
    print("  ");
    println(String.join("\r\n  ", preset_palette.print_palette()));
    println("// Color Palette (" + preset_palette.num_btns + " colors) //");
    println();
    println("// Live Preview (" + preview_palette.num_btns + " colors) //");
    print("  ");
    println(String.join("\r\n  ", preview_palette.print_palette()));
    println("// Live Preview (" + preview_palette.num_btns + " colors) //");
  }
  else if (e.getKeyCode() == 82) { // R
    new_cor = get_random_color();
  }
  else if (e.getKeyCode() == 84) { // T
    invert_main_color();
  }
  else if (e.getKeyCode() == 88) { // X
    preview_palette.remove_selected();
    preset_palette.remove_selected();
  }
  else if (e.getKeyCode() == 27) {  // ESC
    println("Bye now");
    turn_off_light();
  }
  else if (e.getKeyCode() == 32) {  // SPACE
    toggle_live_preview();
  }
  else if (e.getKeyCode() == 37) {  // LEFT ARROW
    preview_palette.update_clrsel(-1);
    preset_palette.update_clrsel(-1);
    color_modes.update_mode_color(-1);
  }
  else if (e.getKeyCode() == 39) { // RIGHT ARROW
    preview_palette.update_clrsel(1);
    preset_palette.update_clrsel(1);
    color_modes.update_mode_color(1);
  }
  else if (e.getKeyCode() == 38) { // UP ARROW
    color_modes.update_mode_selection(-1);
    preset_palette.update_clrsel(-preset_palette.btn_acr);
  }
  else if (e.getKeyCode() == 40) { // DOWN ARROW
    color_modes.update_mode_selection(1);
    preset_palette.update_clrsel(preset_palette.btn_acr);
  }
  else if (e.getKeyCode() == 91) { // [
    shift_rgb_values(1);
  }
  else if (e.getKeyCode() == 93) { // ]
    shift_rgb_values(-1);
  }
  else if (e.getKeyCode() == 107) { // PLUS
    update_brightness(BRIGHTNESS_MODIFIER);
  }
  else if (e.getKeyCode() == 109) { // MINUS
    update_brightness(-1*BRIGHTNESS_MODIFIER);
  }
  else if (e.getKeyCode() == 127) { // DELETE
    preview_palette.reset_selected();
    preset_palette.reset_selected();
  }
  else if (e.getKeyCode() == 8) { // BACKSPACE
    preview_palette.undo();
    preset_palette.undo();
  }
  else if (e.getKeyCode() == 10) { // ENTER
    preview_palette.update_color();
    preset_palette.update_color();
  }
  else if (e.getKeyCode() == 33) { // PAGE UP
    preview_palette.adjust_size(1);
    println("Updated Preview Palette Size: " + preview_palette.get_size());
  }
  else if (e.getKeyCode() == 34) { // PAGE DOWN
    preview_palette.adjust_size(-1);
    println("Updated Preview Palette Size: " + preview_palette.get_size());
  }
  else if (e.getKeyCode() == 97) { // NUM1
    image_picker.shift_img(-IMAGE_SHIFT, IMAGE_SHIFT); // DOWN LEFT
  }
  else if (e.getKeyCode() == 98) { // NUM2
    image_picker.shift_img(0, IMAGE_SHIFT); // DOWN
  }
  else if (e.getKeyCode() == 99) { // NUM3
    image_picker.shift_img(IMAGE_SHIFT, IMAGE_SHIFT); // DOWN RIGHT
  }
  else if (e.getKeyCode() == 100) { // NUM4
    image_picker.shift_img(-IMAGE_SHIFT, 0); // LEFT
  }
  //else if (e.getKeyCode() == 101) { // NUM5
  //  image_picker.shift_img(0, 0); // RESET
  //}
  else if (e.getKeyCode() == 102) { // NUM6
    image_picker.shift_img(IMAGE_SHIFT, 0);  // RIGHT
  }
  else if (e.getKeyCode() == 103) { // NUM7
    image_picker.shift_img(-IMAGE_SHIFT, -IMAGE_SHIFT);  // UP LEFT
  }
  else if (e.getKeyCode() == 104) { // NUM8
    image_picker.shift_img(0, -IMAGE_SHIFT);  // UP
  }
  else if (e.getKeyCode() == 105) { // NUM9
    image_picker.shift_img(IMAGE_SHIFT, -IMAGE_SHIFT);  // UP RIGHT
  }
  else if (e.getKeyCode() == 112) { // F1
    print_keyboard_shortcuts();
  }
 else if (e.getKeyCode() == 113) { // F2
   set_view_clrmodes();
 }
 else if (e.getKeyCode() == 114) { // F3
   set_view_wheel();
 }
  else if (e.getKeyCode() == 115) { // F4
    set_view_sliders();
  }
  else if (e.getKeyCode() == 116) { // F5
    set_view_picker();
  }
  else if (e.getKeyCode() == 117) { // F6
    set_view_image();
  }
  else if (e.getKeyCode() == 122) { // F11
    preset_palette.adjust_size(-1);
    println("Updated Color Palette Size: " + preset_palette.get_size());
  }
  else if (e.getKeyCode() == 123) { // F12
    preset_palette.adjust_size(1);
    println("Updated Color Palette Size: " + preset_palette.get_size());
  }
  else if (e.getKeyCode() >= 48 && e.getKeyCode() <= 57) { // 0 - 9
    preset_palette.unselect();
    preview_palette.set_index(e.getKeyCode() - 48);
  }
  else {
    println("Unbound KeyCode: " + e.getKeyCode());
  }
}

void load_image_callback(File selection) {
  if (selection == null) {
    println("No image file selected");
  }
  else {
    image_picker.load(selection);
  }
  mousePressed = false;
}

void load_palette_callback(File selection) {
  if (selection == null) {
    println("No file selected to load palette");
  }
  else {
    preset_palette.load_palette(selection);
  }
  mousePressed = false;
}

void save_palette_callback(File selection) {
  if (selection == null) {
    println("No file selected to save palette");
  }
  else {
    preset_palette.save_palette(selection);
  }
  mousePressed = false;
}