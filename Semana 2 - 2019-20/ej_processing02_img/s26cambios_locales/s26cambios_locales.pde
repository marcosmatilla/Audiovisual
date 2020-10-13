/***************************************
 * Descubre la imagen :-)
 * Trabaja con los pixels de la imagen en memoria y con los pixels de la ventana. 
 * Toma como referencia la posición del ratón y ajusta el brillo de los pixels en 
 * función de la distancia a esa posición
 ****************************************/
PImage img;

void setup() {
  size(512, 640);
  img = loadImage("lighthouse.jpg");
}

void draw() {
  // Accedemos a los pixels de la ventana y de la imagen
  loadPixels(); 
  img.loadPixels(); 
  
  // Recorre el array de pixels
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int loc = x + y * img.width;
      
      // Recuperamos los tres componentes de color para dada pixel
      float r = red(img.pixels[loc]);    // float r = c >> 16 & 0xFF;  // Mismo cálculo más rápido
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);
      
      // El procesamiento de la imagen va aquí
      // Podemos cambiar los valores RGB antes de reasignarlos al array de pixels.
      // Calculate an amount to change brightness 
      // based on proximity to the mouse
      float distance = dist(x,y,mouseX,mouseY);
      float adjustBrightness = (100-distance)/100;  
      r *= adjustBrightness;
      g *= adjustBrightness;
      b *= adjustBrightness;
      // Constrain RGB to between 0-255
      r = constrain(r,0,255);
      g = constrain(g,0,255);
      b = constrain(b,0,255);
      
      // Establece el array de pixels de la ventana al valor de los pixels de la imagen
      pixels[loc] =  color(r,g,b);          
    }
  }
  updatePixels();
}
