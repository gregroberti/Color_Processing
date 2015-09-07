import processing.serial.*;
Serial port;

///////////////////////
// Set your COM Port //
///////////////////////
String com_port = "COM5";


int[] color_palette  =
{
    /////////////////////////////
    // PASTE COLOR LINES BELOW //
    /////////////////////////////
    
    0, 0 , 0,    // Color #0

    255 , 0 , 0,   //  Color #1
    255 , 63 , 0,   //  Color #2
    255 , 127 , 0,   //  Color #3
    255 , 191 , 0,   //  Color #4
    255 , 255 , 0,   //  Color #5
    191 , 255 , 0,   //  Color #6
    127 , 255 , 0,   //  Color #7
    63 , 255 , 0,   //  Color #8


    0 , 255 , 0,   //  Color #9
    0 , 255 , 63,   //  Color #10
    0 , 255 , 127,   //  Color #11
    0 , 255 , 191,   //  Color #12
    0 , 255 , 255,   //  Color #13
    0 , 191 , 255,   //  Color #14
    0 , 127 , 255,   //  Color #15
    0 , 63 , 255,   //  Color #16


    0 , 0 , 255,   //  Color #17
    63 , 0 , 255,   //  Color #18
    127 , 0 , 255,   //  Color #19
    191 , 0 , 255,   //  Color #20
    255 , 0 , 255,   //  Color #21
    255 , 0 , 191,   //  Color #22
    255 , 0 , 127,   //  Color #23
    255 , 0 , 63,   //  Color #24

    255 , 255 , 255,   //  Color #25
    170 , 255 , 255,    //  Color #26
    172 , 241 , 255,   //  Color #27
    85 , 96 , 241,   //  Color #28
    57 , 0, 23,   //  Color #29
    0 , 0 , 6,   //  Color #30
    0 , 6 , 0,   //  Color #31
    6 , 0 , 0   //  Color #32
    
    /////////////////////////////
    // PASTE COLOR LINES ABOVE //
    /////////////////////////////
};














///////////////////////////////////////
// BEWARE: DRAGONS BEYOND THIS POINT //
///////////////////////////////////////















////////////////////////////////
// LAST CHANCE, TURN BACK NOW //
////////////////////////////////















///////////////////////////////////////////
// OK, BUT DON'T SAY I DIDN'T WARN YOU.. //
///////////////////////////////////////////













int left = 0;
int top = 395;
clrbtn[] bcp = { // Row #1
                  new clrbtn(left = 57,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  
                  // Row #2
                  new clrbtn(left = 57,  top += 35, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  
                  // Row #3
                  new clrbtn(left = 57,  top += 35, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255)),
                  new clrbtn(left += 35,  top += 0, color(255, 255, 255))
                  
                  // Don't add more clrbtns unless you add more colors
                  // to the color_palette or you get index out of bounds
                };

color cor;
int cor_index = 0;
sliderV sV1, sV2, sV3, sInc;
printbtn export_cp = new printbtn(330, 10);

void initialize_color_palette() {
  for (int i = 0; i < bcp.length; i++) {
    bcp[i].cor = color(color_palette[i*3],
                        color_palette[i*3 + 1],
                        color_palette[i*3 + 2]);
  }
  
  // Set selection to Color #0
  bcp[0].sel();
}

void setup() {
  size(500, 500);
  
  println("Available serial ports:");
  println(Serial.list());

  // check on the output monitor wich port is available on your machine
  port = new Serial(this, com_port, 9600);

  // create 3 instances of the sliderV class
  sV1 = new sliderV(100, 100, 90, 255, 0, #FF0000, 0, "Red");
  sV2 = new sliderV(200, 100, 90, 255, 0, #03FF00, 1, "Green");
  sV3 = new sliderV(300, 100, 90, 255, 0, #009BFF, 2, "Blue");
  
  // create scroll wheel increment slider (yeah.. I know)
  sInc = new sliderV(10, 10, 50, 10, 1, #FFFFFF, 3, "Scroll");
  
  initialize_color_palette();
}

void draw() {
  background(0);

  sV1.render();
  sV2.render();
  sV3.render();
  
  // sInc.render();
  export_cp.render();
  
  // render favorites clrbtns
  for (int i = 0; i < bcp.length; i++) {
    bcp[i].render();
  }

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

int[] getRGB(color _cor) {
  return new int[]{ (_cor >> 16) & 0xFF,
                    (_cor >> 8) & 0xFF,
                    (_cor & 0xFF)
                  };
}

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

void unselect_all() {
  for (int i = 0; i < bcp.length; i++) {
    bcp[i].unsel();
  }
}

class clrbtn {
  int x, y, w, h;
  color cor;
  int lclk = -1;
  boolean sel = false;
  
  clrbtn (int _x, int _y, color _cor) {
    x = _x;
    y = _y;
    w = 25;
    h = 25;
    cor = _cor;
  }
  
  void render_border() {
    if (sel) {
      fill(color(200, 0, 0)); // RED
      rect(x-2, y-2, w+4, h+4);
    }
    else {
      fill(color(255, 255, 255)); // WHITE
      rect(x-1, y-1, w+2, h+2);
    }
  }
  
  void render_fill() {
    fill(cor);
    rect(x, y, w, h);
  }
  
  void render() {
    noStroke();
    render_border();
    render_fill();
  }
  
  boolean isOver() {
    if ((mouseX<x+w) && (mouseX>x) && (mouseY<=y+h) && (mouseY>=y)) {
      return true;
    }
    return false;
  }
  
  void click() {
    int clk = millis();
    if(clk-lclk < 150) {
      cor = color(255, 255, 255);
    }
    sel();
    lclk = clk;
  }
  
  void sel() {
    unselect_all();
    sel = true;
  }
  
  void unsel() {
    sel = false;
  }
  
  void release() {
    println("The color you just clicked on was:");
    int clk = millis();
    if (clk-lclk > 500) {
      cor = color(sV1.p, sV2.p, sV3.p);
      int[] rgb = getRGB(cor);
      println(rgb[0] + ", " + rgb[1] + ", " + rgb[2] + ",");
    }
    else {
      int[] rgb = getRGB(cor);
      sV1.p = rgb[0];
      sV2.p = rgb[1];
      sV3.p = rgb[2];
      println(rgb[0] + ", " + rgb[1] + ", " + rgb[2] + ",");
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
  String name;

  sliderV (int _x, int _y, int _w, int _h, int _p, color _cor, int _id, String _name) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    p = _p;
    cor = _cor;
    id = _id;
    name = _name;
  }

  void render() {
    noStroke();
    
    // MIN AREA
    fill(color(55, 55, 55));
    rect(x-1, y+h+4, w, 15);
    
    // MIN AREA TEXT
    fill(255);
    text("MIN", x+30, y+h+17);
    
    // BAR
    fill(cor);
    rect(x-1, y-4, w, h+10);
    
    // MAX AREA
    fill(color(55, 55, 55));
    rect(x-1, y-19, w, 15);
    
    // MAX AREA TEXT
    fill(255);
    text("MAX", x+30, y-7);
    
    // SLIDER
    fill(0);
    rect(x, h-p+y-5, w-2, 13);
    
    // SLIDER TEXT
    fill(255);
    text(p + " " + name, x+2, h-p+y+6);
    
    if (mouseX<x+w && mouseX>x && (mouseY<=y+h+20) && (mouseY>=y-20)) {
      if(mousePressed==true) {
        p = h-(mouseY-y);
      }
      
      if (p<0) {
        p=0;
      }
      else if (p>h) {
        p=h;
      }
    }
  }
  
  boolean isOver() {
    if ((mouseX>x) && (mouseX<x+w) &&
        (mouseY>=y-150) && (mouseY<=y+h+150)) {
      return true;
    }
    return false;
  }
}