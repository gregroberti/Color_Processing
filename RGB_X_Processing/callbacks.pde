////////////////////////
// Callback Functions //
////////////////////////

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  int[] rgb = getRGB(main_cor);
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

void mousePressed() {
  disable_live_preview();
  preview_palette.check_for_btn_clicks();
  preset_palette.check_for_btn_clicks();

  if (sV1.isOver()) {
    sV1.click();
  }
  else if (sV2.isOver()) {
    sV2.click();
  }
  else if (sV3.isOver()) {
    sV3.click();
  }
  else if (export_cp.isOver()) {
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
  else if (e.getKeyCode() == 67) { // C
    println("Press 'c' again to clear the color preset palette (white/black)");
    clearpalette = true;
  }
  else if (e.getKeyCode() == 82) { // R
    new_cor = get_random_color();
    preview_palette.unselect();
    preset_palette.unselect();
  }
  else if (e.getKeyCode() == 27) {  // ESC
    println("Bye now");
  }
  else if (e.getKeyCode() == 32) {  // SPACE
    toggle_live_preview();
  }
  else if (e.getKeyCode() == 37) {  // LEFT ARROW
    preview_palette.update_clrsel(-1);
    preset_palette.update_clrsel(-1);
  }
  else if (e.getKeyCode() == 39) { // RIGHT ARROW
    preview_palette.update_clrsel(1);
    preset_palette.update_clrsel(1);
  }
  else if (e.getKeyCode() == 38) { // UP ARROW
   preset_palette.update_clrsel(-preset_palette.btn_acr);
  }
  else if (e.getKeyCode() == 40) { // DOWN ARROW
   preset_palette.update_clrsel(preset_palette.btn_acr);
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
  else if (e.getKeyCode() == 112) { // F1
    print_keyboard_shortcuts();
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