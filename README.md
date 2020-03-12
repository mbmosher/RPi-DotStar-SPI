# RPi-DotStar-SPI


Here is a sample sketch for using Adafruit DotStar LEDs with Processing for Pi on Raspberry Pi over hardware SPI.

My Java skills are not up to the challenge of making an actual Processing Library, so I've just implimented the code here as the DotStar class.

Within this class there is a contructor - DotStar(numLEDs),
and methods for:
- setting an individual LED's color - setColor(n, r, g, b)
- setting the whole strip to a single color - ledFill(r, g, b)
- turning the strip off/black - wipe()

You'll need to conenct the Raspberry Pi's SPI MOSI (GPIO 10) to the DotStar Data In (DI), the Pi SPI Clock (GPIO 11) to the Dotstar Clock In (CI), and Pi Ground to the DotStar Ground.  If you are only powering a few LEDs you can connect the DotStar 5V to the Pi 5V, but for longer strips you'll need a dedicated 5V power supply.  See Adafruits helpful guide on best practices for powerinf DotStar strips.  https://learn.adafruit.com/adafruit-dotstar-leds/power-and-connections

Before starting this project I wasn't sure if it was possible to control the DotStar LED's with Processing for Pi, but was able to do so with this class.  I hope that it is useful to others who may be trying to do something similar.  
