///////////////////////////////
// Save & Load Configuration //
///////////////////////////////

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.UnsupportedEncodingException;

void save_palette() {
  try {
    String fname = System.getProperty("user.home") + "\\Desktop\\color_palette.txt";
    PrintWriter writer = new PrintWriter(fname, "UTF-8");
    writer.println(print_palette());
    writer.close();
    println("Saved color palette to: " + fname);
  }
  catch (FileNotFoundException e) {
    println("FileNotFoundException: " + e);
  }
  catch (UnsupportedEncodingException e) {
    println("UnsupportedEncodingException: " + e);
  }
}

void load_palette() {
  StringBuilder sb = new StringBuilder();
  String fname = System.getProperty("user.home") + "\\Desktop\\color_palette.txt";
  try {
    InputStream input = new FileInputStream(fname);
    int data = input.read();
    while(data != -1) {
     sb.append((char)data);
     data = input.read();
    }
    sb.append((char)data);
    input.close();
    
    String[] rows = sb.toString().replace(" ", "").split("\r\n");
    int[] new_palette = new int[99];
    
    for(int i = 0; i < rows.length; i++) {
      String[] row = rows[i].split("//")[0].split(",");
      if(row.length == 3 || row.length == 4) {
        new_palette[(i*3)+0] = int(row[0]);
        println("row[0] = " + row[0]);
        new_palette[(i*3)+1] = int(row[1]);
        println("row[1] = " + row[1]);
        new_palette[(i*3)+2] = int(row[2]);
        println("row[2] = " + row[2]);
        //println("(i*3)+2 = " + (i*3)+2);
      }
      //else {
      //  println("Invalid row: " + row);
      //}
    }
    
    update_palette(new_palette);
    println("Successfully loaded color palette from: " + fname);
  }
  catch (FileNotFoundException e) {
    println("FileNotFoundException: " + e);
  }
  catch (IOException e) {
   println("IOException: " + e);
  }
  catch (Exception e) {
   println("Exception: " + e);
  }
}