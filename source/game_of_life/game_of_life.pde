PImage buffer1, buffer2;

int windowX, windowY, windowW, windowH;
int born, dies;

void setup() {
  size(1000, 1000);
  windowX = 0;
  windowY = 0;
  windowW = 100;
  windowH = 100;
   
  buffer1 = createImage(1000, 1000, RGB);
  buffer1.loadPixels();
  buffer2 = createImage(1000, 1000, RGB);
  buffer2.loadPixels();
  for (int i = 0; i < buffer1.pixels.length; i++) {
    if (random(0,1) > 0.5) {
      buffer1.pixels[i] = color(0, 0, 0);
      buffer2.pixels[i] = color(0, 0, 0);
    } else {
      buffer1.pixels[i] = color(255, 255, 255);
      buffer2.pixels[i] = color(255, 255, 255);
    } 
  }
  buffer1.updatePixels();
  buffer2.updatePixels();
}

void draw() {
  background(0);
  windowX++;
  if(windowX + windowW > width) { windowX = 0; }
  
  windowY+=2;
  if(windowY + windowH > height) { windowY = 0; }
  
  
  
 // loadPixels(); 
  buffer1.loadPixels();
  buffer2.loadPixels();
  
  //corners
  //left edge
  //right edge
  //top edge
  //bottom edge
  
  born = 0;
  dies = 0;
  
  for (int y = 1; y < height-1; y++) {
    for (int x = 1; x < width-1; x++) {
      int loc = x + y*width;
      
      float r = red(buffer2.pixels[loc])/255;
      float n =   (red(buffer2.pixels[loc-1]) +
                  red(buffer2.pixels[loc+1]) +
                  red(buffer2.pixels[loc-width]) +
                  red(buffer2.pixels[loc+width]) +
                  red(buffer2.pixels[loc-width-1]) +
                  red(buffer2.pixels[loc+width-1]) +
                  red(buffer2.pixels[loc-width+1]) +
                  red(buffer2.pixels[loc+width+1]))/255;
                  
      float newValue = 0;
      if (r > 0) {
        if ((n > 1) && (n < 4)) {
          newValue = 255;
        }else {
         dies++;
        }
      }else {
        if (n == 3) {
          newValue = 255;
          born++;
        }        
      }
      //newValue = r;
      
      buffer1.pixels[loc] = color(newValue,newValue,newValue);        
    }
  }
 
  
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int loc = x + y*width;
      
      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      float r = red(buffer1.pixels[loc]);
      float g = green(buffer1.pixels[loc]);
      float b = blue(buffer1.pixels[loc]);
 
      // Set the display pixel to the image pixel
      buffer2.pixels[loc] =  color(r,g,b);
    }
  }
  buffer2.updatePixels();

  
  loadPixels();
  
  for (int y = 0; y < windowH; y++) {
    for (int x = 0; x < windowH; x++) {
      int loc = windowX + x + (windowY +y)*width;
      int screenLOC = x + y*width;
      
      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      float r = red(buffer1.pixels[loc]);
      float g = green(buffer1.pixels[loc]);
      float b = blue(buffer1.pixels[loc]);
 
      // Set the display pixel to the image pixel
      pixels[screenLOC] =  color(r,g,b);
    }
  }
  updatePixels();
  
  buffer1.updatePixels();
  
  println(born + " : " + dies);
  
}
