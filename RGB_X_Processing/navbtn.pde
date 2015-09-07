///////////////////////
// Navigation Button //
///////////////////////

class navbtn {
  int x, y, w, h, stp;
  int lclk = -1;
  String txt;
  
  navbtn (int _x, int _y, int _stp, String _txt) {
    x = _x;
    y = _y;
    w = 25;
    h = 90;
    stp = _stp;
    txt = _txt;
  }
  
  void render_border() {
    fill(color(255, 255, 255));
    rect(x-1, y-1, w+2, h+2);
  }
  
  void render_fill() {
    fill(color(55, 55, 55));
    rect(x, y, w, h);
  }
  
  void render_text() {
    fill(255);
    text(txt, x+(w/2)-3, y+(h/2));
  }
 
  void render() {
    noStroke();
    
    render_border();
    render_fill();
    render_text();
  }
  
  boolean isOver() {
    if ((mouseX<x+w) && (mouseX>x) && (mouseY<=y+h) && (mouseY>=y)) {
      return true;
    }
    return false;
  }
  
  void click() {
    bcp[cor_index].unsel();
    increment_index(stp);
    bcp[cor_index].sel();
    update_sliders();
  }
}