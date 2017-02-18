PImage img, sorted;
int index = 0;

void setup() {
  size(600, 300);  
  img = loadImage("tongue.jpg");
  //create a blank image
  sorted = createImage(img.width, img.height, RGB);
  sorted.loadPixels();
  //img.loadPixels();
  //for(int i = 0; i < sorted.pixels.length; i++) {
  //  sorted.pixels[i] = img.pixels[i];  
  //}

  // .get() just gets copy of image
  sorted = img.get();
}

void draw() {
  println(frameRate);
  background(0);

  // By putting Selection sort in draw (without outer loop), we can make it sort one pixel per frame

  // Do 100 pixels each frame to speed it up
  for (int i = 0; i < 200; i++) {

    //Selection sort
    float record = -1;
    int selectedPixel = index;
    // For every pixel, look at pixel that comes after it
    for (int j = index; j < sorted.pixels.length; j++) {
      color pix = sorted.pixels[j];
      float b = brightness(pix);
      if (b > record) {
        selectedPixel = j;
        record = b;
      }

      // Swap selectedPixel with i
      color temp = sorted.pixels[index];
      sorted.pixels[index] = sorted.pixels[selectedPixel]; 
      sorted.pixels[selectedPixel] = temp;
    }  

    //// Swap selectedPixel with i
    //color temp = sorted.pixels[index];
    //sorted.pixels[index] = sorted.pixels[selectedPixel]; 
    //sorted.pixels[selectedPixel] = temp;


    if (index < sorted.pixels.length -1) index++;


    sorted.updatePixels();
  }

  image(img, 0, 0);
  image(sorted, 300, 0);
} 