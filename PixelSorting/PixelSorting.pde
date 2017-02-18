PImage img, sorted;

void setup() {
  size(400, 200);  
  img = loadImage("idan_grace.jpg");
  //create a blank image
  sorted = createImage(img.width, img.height, RGB);
  sorted.loadPixels();
  //img.loadPixels();
  //for(int i = 0; i < sorted.pixels.length; i++) {
  //  sorted.pixels[i] = img.pixels[i];  
  //}  
  // .get() just gets copy of image
  sorted = img.get();
  
  //Selection sort
  for(int i = 0; i < sorted.pixels.length; i++) {
    float record = -1;
    int selectedPixel = i;
    // For every pixel, look at pixel that comes after it
    for(int j = i; j < sorted.pixels.length; j++) {
      color pix = sorted.pixels[j];
      float b = hue(pix);
      if(b > record) {
        selectedPixel = j;
        record = b;
      }   
    }  
    
    // Swap selectedPixel with i
    color temp = sorted.pixels[i];
    sorted.pixels[i] = sorted.pixels[selectedPixel]; 
    sorted.pixels[selectedPixel] = temp;
  }  
  
  sorted.updatePixels();
}

void draw() {
  background(0);
  image(img, 0, 0);
  image(sorted, 200, 0);
} 