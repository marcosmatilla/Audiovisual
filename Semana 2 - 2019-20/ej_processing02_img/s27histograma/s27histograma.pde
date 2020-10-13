// All Examples Written by Casey Reas and Ben Fry

// unless otherwise stated.

/* @pjs preload="data/cdi01_g.jpg"; */



size(200,200);

colorMode(RGB, width);



int[] hist = new int[width];



// Load an image from the data directory

// Load a different image by modifying the comments

PImage a;

a = loadImage("lena200.jpg");

image(a, 0, 0);



// Calculate the histogram

for (int i=0; i<width; i++) {

  for (int j=0; j<height; j++) {
    println(int(red(get(i, j))));

    hist[int(brightness(get(i, j)))-1]++; 

  }

} 



// Find the largest value in the histogram

float maxval = 0;

for (int i=0; i<width; i++) {

  if(hist[i] > maxval) {

    maxval = hist[i];

  }  

}



// Normalize the histogram to values between 0 and "height"

for (int i=0; i<width; i++) {

  hist[i] = int(hist[i]/maxval * height);

}



// Draw half of the histogram (skip every second value)

stroke(width);

for (int i=0; i<width; i+=2) {

  line(i, height, i, height-hist[i]);

}
