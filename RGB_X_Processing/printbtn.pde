//////////////////
// Print Button //
//////////////////

class printbtn {
  int x, y, w, h;
  color cor = color(255, 255, 255);
  int lclk = -1;
  
  printbtn (int _x, int _y) {
    x = _x;
    y = _y;
    w = 160;
    h = 25;
  }
  
  void render() {
    noStroke();
    fill(cor);
    rect(x, y, w, h);
    
    fill(0);
    text("Click here to print your colors!", x+1, 25);
  }
  
  boolean isOver() {
    if ((mouseX<x+w) && (mouseX>x) && (mouseY<=y+h) && (mouseY>=y)) {
      return true;
    }
    return false;
  }
  
  void click() {
    println("Copy and paste to customize your color palette in NEO!");
    for(int i = 0; i < bcp.length; i++) {
      int red = (bcp[i].cor >> 16) & 0xFF;
      int green = (bcp[i].cor >> 8) & 0xFF;
      int blue = (bcp[i].cor & 0xFF);
      
      if (i != bcp.length - 1) {
        println(red + ", " + green + ", " + blue + ",  // Color #" + i);
      }
      else {
        println(red + ", " + green + ", " + blue + "   // Color #" + i);
      }
    }
  }
}