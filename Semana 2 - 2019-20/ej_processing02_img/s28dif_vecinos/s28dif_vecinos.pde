/*********************************************************
 * Accede a los pixels de una imagen
 * Compara cada pixel con su izquierdo, y crea un color con la diferencia
 * Filtro paso alto rudimentario para resaltar bordes
 **********************************************************/
 
PImage origen;       // origen image
PImage destino;  // destino image

void setup() {
  size(512, 640);
  origen = loadImage("lighthouse.jpg");  
  // Creamos la imagen de destino como imagen en blanco del mismo tamaño que la imagen origen.
  destino = createImage(origen.width, origen.height, RGB);
}

void draw() {  
  float umbral = 127;

  // Accedemos al array de pixels de ambas imágenes
  origen.loadPixels();
  destino.loadPixels();
  
  // Examinamos los vecinos izquierdos de cada pixel
  // Por tanto, saltamos la primera columna
  for (int x = 1; x < width; x++) {
    for (int y = 0; y < height; y++ ) {
      // Calculamos la posición del pixel correspondiente
      int loc = x + y*origen.width;
      // recuperamos el color
      color pix = origen.pixels[loc];
  
      // Calculamos la posición del pixel a la izquierda
      int leftLoc = (x-1) + y*origen.width;
      // recuperamos el color
      color leftPix = origen.pixels[leftLoc];
  
      // El nuevo color es la diferencia entre un pixel y su vecino izquierdo
      float diff = abs(brightness(pix) - brightness(leftPix));
      // cuanto más diferentes sean más claro será el gris final
      destino.pixels[loc] = color(diff);
    }
  }

  // Actualizamos los pixels en destino
  destino.updatePixels();
  // Mostramos imagen destino
  image(destino,0,0);
}
