import processing.serial.*;
Serial port;

///////////////////////
// Set your COM Port //
///////////////////////
String com_port = "COM5";





























///////////////////////////////////////
// BEWARE: DRAGONS BEYOND THIS POINT //
///////////////////////////////////////

















////////////////////////////////
// LAST CHANCE, TURN BACK NOW //
////////////////////////////////


























///////////////////////////////////////////
// OK, BUT DON'T SAY I DIDN'T WARN YOU.. //
///////////////////////////////////////////

int MOUSE_WHEEL_INC = 1;
int FORM_WIDTH = 500;
int FORM_HEIGHT = 500;
int COLOR_BTN_WIDTH = 25;
int COLOR_BTN_HEIGHT = 25;
int COLOR_BTN_SPACE = 10;
int COLOR_PALETTE_SIZE = 33; // Don't forget about 0
int NUM_BUTTONS_ACROSS = 11;
palette entire_palette = new palette(COLOR_PALETTE_SIZE);

int cor_index = 0;
color main_cor = color(0, 0, 0);
sliderV sV1, sV2, sV3, sInc;
importbtn import_cp = new importbtn(15, 15);
exportbtn export_cp = new exportbtn(410, 15);

void setup() {
  // FORM_WIDTH = 500
  // FORM_HEIGHT = 500
  size(500, 500);
  
  println("Available serial ports:");
  println(Serial.list());

  // check on the output monitor wich port is available on your machine
  port = new Serial(this, com_port, 9600);

  // create 3 instances of the sliderV class
  sV1 = new sliderV(100, 100, 90, 255, 0, #FF0000, 0, "Red");
  sV2 = new sliderV(200, 100, 90, 255, 0, #03FF00, 1, "Green");
  sV3 = new sliderV(300, 100, 90, 255, 0, #009BFF, 2, "Blue");
  
  entire_palette.initialize_color_buttons();
}

void draw() {
  background(0);

  sV1.render();
  sV2.render();
  sV3.render();
  
  import_cp.render();
  export_cp.render();
  
  entire_palette.render();

  // send sync character
  // send the desired value
  port.write('R');
  port.write(sV1.p);
  port.write('G');
  port.write(sV2.p);
  port.write('B');
  port.write(sV3.p);
}