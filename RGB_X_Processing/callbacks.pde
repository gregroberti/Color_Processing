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
    }
  }
  
  if (export_cp.isOver()) {
    export_cp.click();
  }
}

void mouseReleased() {
  for (int i = 0; i < bcp.length; i++) {
    if (bcp[i].isOver()) {
      bcp[i].release();
    }
  }
}