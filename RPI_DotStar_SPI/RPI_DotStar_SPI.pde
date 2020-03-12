import processing.io.*;
import processing.serial.*;

SPI spi;
DotStar dotstrip;
// Set ledCount to the number of LEDs on your strip
int ledCount = 10;  
// brightness can be used as an RGB value multiplier
float brightness = 1;



void setup() {
  size(350, 160);
  // init SPI connection
  printArray(SPI.list());
  spi = new SPI(SPI.list()[0]);
  spi.settings(500000, SPI.MSBFIRST, SPI.MODE0);
  // init Dotstar LED strip
  dotstrip = new DotStar(ledCount);
  dotstrip.wipe();  // set all pixels to black
}

void draw() {
  // sample LED code
  for(int i = 0; i < ledCount; i++) {
    dotstrip.setColor(i, i*20*brightness, 150*brightness, 250*brightness);
    dotstrip.show();
    delay(500);
  }
  dotstrip.ledFill(250, 150, 50);
  dotstrip.show();
  delay(1000);
  dotstrip.wipe();
  dotstrip.show();
  delay(1000);
}


class DotStar {
  int dataPin = 10; // SPI MOSI, GPIO 10, HW 19
  int clockPin = 11;  // SPI CLK, GPIO 11, HW 23
  int numleds;
  //int *pix;
  int[] pix = {0};
  int roffset = 2 & 3;
  int goffset = ((0 << 2) >> 2) & 3;
  int boffset = ((1 << 4) >> 4) & 3;
  
  DotStar(int l) {
    numleds = l;
    pix = expand(pix, l*3);
    for(int i = 0; i < l*3; i++) { pix[i] = 0; }
  }
  
  void show() {
    // send pixel data to LEDs via SPI
    int i = 0;
    for(i = 0; i < 4; i++) { spi.transfer(0x00); }
    
    for(int j = 0; j < numleds * 3; j += 3) {
      spi.transfer(0xFF);
      for(i = 0; i < 3; i++) { 
        spi.transfer(pix[j+i]); 
      }
    }
    
    for(i = 0; i < 4; i++) { spi.transfer(0xFF); }
  }
    
  void wipe() {
    // Set all pixels in strip to black (off)
    for(int i = 0; i < numleds*3; i++) { pix[i] = 0; }
  }
  
  void setColor(int n, int r, int g, int b) {
    // Set a single LED #n to specified RGB values (0-255)
    if(n < numleds) {
    pix[n*3] = b;
    pix[n*3+1] = g;
    pix[n*3+2] = r;
    }
  }
  
  void ledFill(int r, int g, int b) {
    // Set all pixels to speicifed RGB values (0-255)
    for(int i = 0; i < numleds*3; i+=3) {
      pix[i] = b;
      pix[i+1] = g;
      pix[i+2] = r;
    }
  }
 
}
