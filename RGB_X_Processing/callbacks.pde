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
  main_cor = color(rgb[0], rgb[1], rgb[2]);
  update_sliders();
}

void mousePressed() {
  preview_palette.check_for_btn_clicks();
  preset_palette.check_for_btn_clicks();

  if (export_cp.isOver()) {
    export_cp.click();
  }
  else if (import_cp.isOver()) {
    import_cp.click();
  }
}

void mouseReleased() {
  preview_palette.check_for_btn_release();
  preset_palette.check_for_btn_release();
}

public void keyPressed(KeyEvent e) {
  if (e.getKeyCode() == 32) {  // SPACE
    preview_palette.update_clrsel(1);
  }
  else if (e.getKeyCode() == 37) {  // LEFT ARROW
    preset_palette.update_clrsel(-1);
  }
  else if (e.getKeyCode() == 39) { // RIGHT ARROW
    preset_palette.update_clrsel(1);
  }
  else if (e.getKeyCode() == 38) { // UP ARROW
   preset_palette.update_clrsel(-preset_palette.btn_acr);
  }
  else if (e.getKeyCode() == 40) { // DOWN ARROW
   preset_palette.update_clrsel(preset_palette.btn_acr);
  }
  else if (e.getKeyCode() == 107) { // PLUS
    update_brightness(10);
  }
  else if (e.getKeyCode() == 109) { // MINUS
    update_brightness(-10);
  }
  else if (e.getKeyCode() == 127) { // DELETE
    preset_palette.reset_btn();
  }
  else if (e.getKeyCode() == 8) { // BACKSPACE
    preset_palette.undo();
  }
  else if (e.getKeyCode() == 10) { // ENTER
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
  else if (e.getKeyCode() == 122) { // F11
    preset_palette.adjust_size(-1);
    println("Updated Color Palette Size: " + preset_palette.get_size());
  }
  else if (e.getKeyCode() == 123) { // F12
    preset_palette.adjust_size(1);
    println("Updated Color Palette Size: " + preset_palette.get_size());
  }
  else {
    println("Unbound KeyCode: " + e.getKeyCode());
  }
}