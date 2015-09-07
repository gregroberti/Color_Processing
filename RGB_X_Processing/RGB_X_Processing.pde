import processing.serial.*;
Serial port;

///////////////////////
// Set your COM Port //
///////////////////////
String com_port = "COM5";


/////////////////////////////////////////////
// Open palette tab to paste Color Palette //
/////////////////////////////////////////////
int[] color_palette = get_palette();



























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

color main_cor;
int cor_index = 0;
sliderV sV1, sV2, sV3, sInc;
importbtn import_cp = new importbtn(15, 15);
exportbtn export_cp = new exportbtn(410, 15);
navbtn navrgt = new navbtn(442, 398, 1, ">");
navbtn navlft = new navbtn(22, 398, -1, "<");

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
  import_cp.render();
  export_cp.render();
  
  // render favorites clrbtns
  for (int i = 0; i < bcp.length; i++) {
    bcp[i].render();
  }
  
  navrgt.render();
  navlft.render();

  // send sync character
  // send the desired value
  port.write('R');
  port.write(sV1.p);
  port.write('G');
  port.write(sV2.p);
  port.write('B');
  port.write(sV3.p);
}