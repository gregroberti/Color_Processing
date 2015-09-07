////////////////////////
// Callback Functions //
////////////////////////

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  
  if (sV1.isOver()){
     sV1.p -= sInc.p*e;
  }
  else if (sV2.isOver()){
     sV2.p -= sInc.p*e;
  }
  else if (sV3.isOver()) {
     sV3.p -= sInc.p*e;
  }
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
  else {
    println("Unbound KeyCode: " + e.getKeyCode());
  }
}