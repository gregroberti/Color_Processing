import processing.serial.*;
Serial port;

sliderV sV1, sV2, sV3;

int spV[] = {90, 90, 90};
int xV[]  = {100, 200, 300};
int yV[]  = {100, 100, 100};
int wV[]  = {90, 90, 90};
int hV[]  = {255, 255, 255};
color corV[] = {#FF0000, #03FF00, #009BFF};

color cor;

void setup() {
  size(500, 500);
  
  println("Available serial ports:");
  println(Serial.list());

  // check on the output monitor wich port is available on your machine
  port = new Serial(this, "COM5", 9600);

  // create 3 instances of the sliderV class
  sV1 = new sliderV(xV[0], yV[0], wV[0], hV[0], corV[0], 0);
  sV2 = new sliderV(xV[1], yV[1], wV[1], hV[1], corV[1], 1);
  sV3 = new sliderV(xV[2], yV[2], wV[2], hV[2], corV[2], 2);
}

void draw() {
  background(0);

  sV1.render();
  sV2.render();
  sV3.render();

  // send sync character
  // send the desired value
  port.write('R');
  port.write(sV1.p);
  port.write('G');
  port.write(sV2.p);
  port.write('B');
  port.write(sV3.p);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  println(e);
  
  if (e < 0){
    println("Scrolling down");
  }
  if (e > 0){
    println("Scrolling up");
  }
  
  if (mouseX<xV[0]+wV[0] && mouseX>xV[0]){
     if ((mouseY<=yV[0]+hV[0]+150) && (mouseY>=yV[0]-150)) {
       spV[0] -= e;
     }
  }
  else if (mouseX<xV[1]+wV[1] && mouseX>xV[1]){
     if ((mouseY<=yV[1]+hV[1]+150) && (mouseY>=yV[1]-150)) {
       spV[1] -= e;
     }
  }
  else if (mouseX<xV[2]+wV[2] && mouseX>xV[2]){
     if ((mouseY<=yV[2]+hV[2]+150) && (mouseY>=yV[2]-150)) {
       spV[2] -= e;
     }
  }
}

/* 
Slider Class - www.guilhermemartins.net
based on www.anthonymattox.com slider class
*/
class sliderV {
  int x, y, w, h, p, id;
  color cor;
  boolean slide;

  sliderV (int _x, int _y, int _w, int _h, color _cor, int _id) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    p = 90;
    cor = _cor;
    slide = true;
    id = _id;
  }

  void render() {
    fill(cor);
    rect(x-1, y-4, w, h+10);
    noStroke();
    fill(0);
    rect(x, h-p+y-5, w-2, 13);
    fill(255);
    text(p, x+2, h-p+y+6);
    
    if (slide==true && mouseX<x+w && mouseX>x){
      if ((mouseY<=y+h+150) && (mouseY>=y-150)) {
        if(mousePressed==true) {
          p = h-(mouseY-y);
        }
        else
        {
          p = spV[id];
        }
        
        if (p<0) {
          p=0;
        }
        else if (p>h) {
          p=h;
        }
        
        spV[id] = p;
      }
    }
  }
}