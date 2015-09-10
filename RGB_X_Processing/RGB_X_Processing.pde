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
int FORM_HEIGHT = 550;
int SLIDER_TOP = 75;
int SLIDER_SPACE = 10;
int SLIDER_WIDTH = 90;
int SLIDER_HEIGHT = 255;
int COLOR_BTN_WIDTH = 25;
int COLOR_BTN_HEIGHT = 25;
int COLOR_BTN_SPACE = 10;
int NUM_BUTTONS_ACROSS = 13;
palette entire_palette = new palette(33);

int cor_index = 0;
color main_cor = color(0, 0, 0);
sliderV sV1, sV2, sV3, sInc;
importbtn import_cp = new importbtn(10, 10);
exportbtn export_cp = new exportbtn(FORM_WIDTH - 50, 10);

void setup() {
  // Update FORM_WIDTH & FORM_HEIGHT
  size(500, 550);
  
  println("Available serial ports:");
  println(Serial.list());

  // check on the output monitor wich port is available on your machine
  port = new Serial(this, com_port, 9600);

  // create 3 instances of the sliderV class
  sV1 = new sliderV(((FORM_WIDTH-((SLIDER_WIDTH+SLIDER_SPACE)*3))/2) + (SLIDER_WIDTH+SLIDER_SPACE)*0,
                      SLIDER_TOP, SLIDER_WIDTH, SLIDER_HEIGHT, 0, #FF0000, 0, "Red");
  sV2 = new sliderV(((FORM_WIDTH-((SLIDER_WIDTH+SLIDER_SPACE)*3))/2) + (SLIDER_WIDTH+SLIDER_SPACE)*1,
                      SLIDER_TOP, SLIDER_WIDTH, SLIDER_HEIGHT, 0, #03FF00, 1, "Green");
  sV3 = new sliderV(((FORM_WIDTH-((SLIDER_WIDTH+SLIDER_SPACE)*3))/2) + (SLIDER_WIDTH+SLIDER_SPACE)*2,
                      SLIDER_TOP, SLIDER_WIDTH, SLIDER_HEIGHT, 0, #009BFF, 2, "Blue");
  
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