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
  entire_palette.check_for_btn_clicks();

  
  if (export_cp.isOver()) {
    export_cp.click();
  }
  else if (import_cp.isOver()) {
    import_cp.click();
  }
}

void mouseReleased() {
  entire_palette.check_for_btn_release();
}

public void keyPressed(KeyEvent e) {
  if (e.getKeyCode() == 37) {  // LEFT ARROW
    entire_palette.update_clrsel(-1);
  }
  else if (e.getKeyCode() == 39) { // RIGHT ARROW
    entire_palette.update_clrsel(1);
  }
  else if (e.getKeyCode() == 38) { // UP ARROW
    entire_palette.update_clrsel(-11);
  }
  else if (e.getKeyCode() == 40) { // DOWN ARROW
    entire_palette.update_clrsel(11);
  }
  else if (e.getKeyCode() == 107) { // PLUS
    update_brightness(10);
  }
  else if (e.getKeyCode() == 109) { // MINUS
    update_brightness(-10);
  }
  else if (e.getKeyCode() == 127) { // DELETE
    entire_palette.reset_btn(cor_index);
  }
  else if (e.getKeyCode() == 8) { // BACKSPACE
    entire_palette.undo(cor_index);
  }
  else if (e.getKeyCode() == 10) { // ENTER
    entire_palette.
    bcp[cor_index].update_color(sV1.p, sV2.p, sV3.p, true);
  }
  else if (e.getKeyCode() == 122) { // F12
    entire_palette.adjust_size(-1);
  }
  else if (e.getKeyCode() == 123) { // F12
    entire_palette.adjust_size(1);
  }
  else {
    println("Unbound KeyCode: " + e.getKeyCode());
  }
}