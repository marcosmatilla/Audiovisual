PImage img;

void setup() {
  size(512, 640);
  img = loadImage("lighthouse.jpg");
  //image(img,0,0);
}

void draw() {
  // Accedemos a los pixels de la ventana y de la imagen
  //loadPixels(); 
  img.loadPixels(); 
  
  // Recorre el array de pixels
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int loc = x + y * img.width;
      
      // Recuperamos los tres componentes de color para dada pixel
      //float r = red(img.pixels[loc]);
      int r= (int)(img.pixels[loc] >> 16 & 0xFF);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);
      
      // El procesamiento de la imagen iría aquí
      // Podemos cambiar los valores RGB antes de reasignarlos al array de pixels.
      //r= (byte)255 & (byte)r;
      println(r);
      
      // Establece el array de pixels de la ventana al valor de los pixels de la imagen
      img.pixels[loc] =  color(r,g,b);          
    }
  }
  img.updatePixels();
  image(img,0,0);
}