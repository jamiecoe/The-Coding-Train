PImage idan, smaller;
PImage[] allImages;
int scaleFactor = 8;
int w, h;
// Corresponding brightness value
float[] brightness;
// Images by brightness
PImage[] brightImages;

void setup() {
  size(1500, 1000);
  idan = loadImage("maya.jpg");

  // Find all the images
  File[] files = listFiles(sketchPath("data/photos"));
  printArray(files);
  //allImages = new PImage[files.length-1];
  // Use a smaller amount just for testing
  allImages = new PImage[files.length-1];
  // Need brightness average for each image
  brightness = new float[allImages.length];
  
  // Only 256 brightness values
  brightImages = new PImage[256];

  // Deal with all the images
  for (int i = 0; i < allImages.length; i++) {

    // What's the filename?
    // Should really check to see if it's a JPG
    // Starting at +1 to ignore .DS_Store on Mac
    String filename = files[i+1].toString();

    // Load the image
    PImage img = loadImage(filename);

    // Shrink it down
    allImages[i] = createImage(scaleFactor, scaleFactor, RGB);
    allImages[i].copy(img, 0, 0, img.width, img.height, 0, 0, scaleFactor, scaleFactor);
    allImages[i].loadPixels();

    // Calculate average brightness
    float avg = 0;
    for (int j = 0; j < allImages[i].pixels.length; j++) {
      float b =  brightness(allImages[i].pixels[j]);
      avg += b;
    }
    avg /= allImages[i].pixels.length;


    brightness[i] = avg;
  }
  
  // Find the closest image for each brightness value
  for (int i = 0; i < brightImages.length; i++) {
    float record = 256;
    for (int j = 0; j < brightness.length; j++) {
      float diff = abs(i - brightness[j]);
      if (diff < record) {
        record = diff;
        brightImages[i] = allImages[j];
      }
    }
  }

  w = idan.width/scaleFactor;
  h = idan.height/scaleFactor;
  smaller = createImage(w, h, RGB);
  smaller.copy(idan, 0, 0, idan.width, idan.height, 0, 0, w, h);
}

void draw() {
  background(0);
  // Create pixelated version of main image
  smaller.loadPixels();
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      // Draw an image with equivalent brightness to source pixel
      int index = x + y * w;
      color c = smaller.pixels[index];
      int imageIndex = int(brightness(c));
      // fill(brightness(c));
      // noStroke();
      // rect(x*scl, y*scl, scl, scl);
      image(brightImages[imageIndex], x*scaleFactor, y*scaleFactor, scaleFactor, scaleFactor);
    }
  }
  //image(idan,0,0);
  //image(smaller,0,0);

  noLoop();
}

// Function to list all the files in a directory
File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    // If it's not a directory
    return null;
  }
}