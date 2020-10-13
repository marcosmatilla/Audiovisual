PImage origen;       // origen image
PImage destino;  // destino image

int tiempoInicial=-1;
int tiempoEspera= 2500; // milisegundos

void setup() {
  size(512, 640);
  origen = loadImage("lighthouse.jpg");  
  // Creamos la imagen de destino como imagen en blanco del mismo tamaño que la imagen origen.
  destino = createImage(origen.width, origen.height, RGB);
}

void draw() {  
  float umbral = 127;

  // Manejamos los arrays de pixels de imagen origen y destino
  origen.loadPixels();
  destino.loadPixels();
  
  for (int x = 0; x < origen.width; x++) {
    for (int y = 0; y < origen.height; y++ ) {
      int loc = x + y*origen.width;
      // Compara el brillo con el umbral
      if (brightness(origen.pixels[loc]) > umbral) {
        destino.pixels[loc]  = color(255);  // Blanco
      }  else {
        destino.pixels[loc]  = color(0);    // negro
      }
    }
  }

  // Actualizamos los pixels en destino
  destino.updatePixels();
  // Mostramos imagen destino
  image(destino,0,0);

  if (tiempoInicial==-1)
    tiempoInicial= millis();
  if (millis()>tiempoInicial+tiempoEspera)
  {
    // muestra imagen original
    image(origen,0,0);
  }
}
