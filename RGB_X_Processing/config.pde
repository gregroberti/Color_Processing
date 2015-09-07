///////////////////////////////
// Save & Load Configuration //
///////////////////////////////

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