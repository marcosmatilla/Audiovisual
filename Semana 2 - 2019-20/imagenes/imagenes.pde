PImage cartaAjuste;

void setup () {
  cartaAjuste=loadImage("carta-ajuste.jpg");
  println(cartaAjuste.width);
  println(cartaAjuste.height);
  fullScreen();
  scale(0.5);
  image(cartaAjuste,0,0);
  
  PImage tmp;
  
  tmp=edgeDetection(cartaAjuste);
  // tmp=lowPassFilter(cartaAjuste);
  // tmp=highPassFilter(cartaAjuste);
  
  image(tmp,200,200);
}

PImage edgeDetection(PImage source) {
  float[][] kernel =  {{ -1, -1, -1}, 
                       { -1,  9, -1}, 
                       { -1, -1, -1}};
                       
  return convolution(source,kernel);
}
  
PImage lowPassFilter(PImage source) {
  float[][] kernel =  {{ 1/9.0, 1/9.0, 1/9.0}, 
                       { 1/9.0, 1/9.0, 1/9.0}, 
                       { 1/9.0, 1/9.0, 1/9.0}};
                       
  return convolution(source,kernel);
}

PImage highPassFilter(PImage source) {
  float[][] kernel =  {{ -1/8.0, -1/8.0, -1/8.0}, 
                       { -1/8.0,      1, -1/8.0}, 
                       { -1/8.0, -1/8.0, -1/8.0}};
                       
  return convolution(source,kernel);
}

// Ver: 
//  https://processing.org/examples/edgedetection.html
//  https://en.wikipedia.org/wiki/Kernel_(image_processing)
//
PImage convolution(PImage source, float[][] kernel) {
  source.loadPixels();

  PImage destination = createImage(source.width, source.height, RGB);

  for (int y = 1; y < source.height-1; y++) { // Skip top and bottom edges
    for (int x = 1; x < source.width-1; x++) { // Skip left and right edges
      float sum = 0; // Kernel sum for this pixel
      
      //float sumR,sumG,sumB;
      //sumR=sumG=sumB=0;
      
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*source.width + (x + kx);

          float val = brightness(source.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          sum += kernel[ky+1][kx+1] * val;
          
        //  float valR = red(source.pixels[pos]);
        //  float valG = green(source.pixels[pos]);
        //  float valB = blue(source.pixels[pos]);
          
        //  sumR += kernel[ky+1][kx+1] * valR;
        //  sumG += kernel[ky+1][kx+1] * valG;
        //  sumB += kernel[ky+1][kx+1] * valB;
        }
      }
  
      destination.pixels[y*source.width + x] = color(sum); // color(sumR,sumG,sumB);
    }
  }
 
  destination.updatePixels();
  
  return destination;
}