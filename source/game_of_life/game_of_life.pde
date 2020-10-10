PImage buffer;

void setup() {
  size(1000, 1000);
  loadPixels(); 
  
  buffer = createImage(1000, 1000, RGB);
  buffer.loadPixels();
  for (int i = 0; i < buffer.pixels.length; i++) {
    if (random(0,1) > 0.5) {
      buffer.pixels[i] = color(0, 0, 0);
      pixels[i] = color(0, 0, 0);
    } else {
      buffer.pixels[i] = color(255, 255, 255);
      pixels[i] = color(255, 255, 255);
    } 
  }
  buffer.updatePixels();
  updatePixels();
}

void draw() {
  loadPixels(); 
  buffer.loadPixels();
  
  //corners
  //left edge
  //right edge
  //top edge
  //bottom edge
  
  for (int y = 1; y < height-1; y++) {
    for (int x = 1; x < width-1; x++) {
      int loc = x + y*width;
      
      float r = red(pixels[loc])/255;
      float n =   (red(pixels[loc-1]) +
                  red(pixels[loc+1]) +
                  red(pixels[loc-width]) +
                  red(pixels[loc+width]) +
                  red(pixels[loc-width-1]) +
                  red(pixels[loc+width-1]) +
                  red(pixels[loc-width+1]) +
                  red(pixels[loc+width+1]))/255;
                  
      float newValue = 0;
      if (r > 0) {
        if ((n > 1) && (n < 4)) {
          newValue = 255;
        }
      }else {
        if (n == 3) {
          newValue = 255;
        }        
      }
      //newValue = r;
      
      buffer.pixels[loc] = color(newValue,newValue,newValue);        
    }
  }
  
  
  
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int loc = x + y*width;
      
      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      float r = red(buffer.pixels[loc]);
      float g = green(buffer.pixels[loc]);
      float b = blue(buffer.pixels[loc]);
 
      // Set the display pixel to the image pixel
      pixels[loc] =  color(r,g,b);          
    }
  }
  
  buffer.updatePixels();
  updatePixels();
}
