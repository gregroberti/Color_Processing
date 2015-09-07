////////////////////////
// Callback Functions //
////////////////////////

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  int[] rgb = getRGB(main_cor);
  if (sV1.isOver()){
     rgb[0] -= sInc.p*e;
  }
  else if (sV2.isOver()){
     rgb[1] -= sInc.p*e;
  }
  else if (sV3.isOver()) {
     rgb[2] -= sInc.p*e;
  }
  main_cor = color(rgb[0], rgb[1], rgb[2]);
  update_sliders();
}

void mousePressed() {
  for (int i = 0; i < bcp.length; i++) {
    if (bcp[i].isOver()) {
      bcp[i].click();
      cor_index = i;
      return;
    }
  }
  
  if (export_cp.isOver()) {
    export_cp.click();
  }
  else if (import_cp.isOver()) {
    import_cp.click();
  }
  else if (navrgt.isOver()) {
    navrgt.click();
  }
  else if (navlft.isOver()) {
    navlft.click();
  }
}

void mouseReleased() {
  for (int i = 0; i < bcp.length; i++) {
    if (bcp[i].isOver()) {
      bcp[i].release();
    }
  }
}

public void keyPressed(KeyEvent e) {
  if (e.getKeyCode() == 37) {  // LEFT ARROW
    update_clrsel(-1);
  }
  else if (e.getKeyCode() == 39) { // RIGHT ARROW
    update_clrsel(1);
  }
  else if (e.getKeyCode() == 38) { // UP ARROW
    update_clrsel(-11);
  }
  else if (e.getKeyCode() == 40) { // DOWN ARROW
    update_clrsel(11);
  }
  else if (e.getKeyCode() == 107) { // PLUS
    update_brightness(10);
  }
  else if (e.getKeyCode() == 109) { // MINUS
    update_brightness(-10);
  }
  else {
    println("Unbound KeyCode: " + e.getKeyCode());
  }
}