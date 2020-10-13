PImage imagen;

void setup () {
  //imagen=loadImage("imagen.jpg");
  imagen=loadImage("grid.jpg");
  println(imagen.width);
  println(imagen.height);
  fullScreen();
  scale(1);
  image(imagen,0,0);
  
  PImage nueva=cambiarTamano(imagen,1/3.0);
  
  image(nueva,0,0);
}

PImage cambiarTamano(PImage source, float escala) {
  source.loadPixels();
  int ancho,alto;
  
  ancho=(int)(source.width*escala);
  alto=(int)(source.height*escala);
  
  PImage destination = createImage(ancho,alto,RGB);
  
  int sourceX,sourceY;
  
  for (int y=0;y<alto;y++) {
    for (int x=0;x<ancho;x++) {
      sourceX=(int)(x/escala);
      sourceY=(int)(y/escala);
      
      // Aquí haríamos la interpolación
      
      int pos=sourceY*source.width+sourceX;
      
      color pixel=source.pixels[pos];
      
      destination.pixels[y*ancho+x]=pixel;
    }
  }

  destination.updatePixels();
  
  return destination;
}