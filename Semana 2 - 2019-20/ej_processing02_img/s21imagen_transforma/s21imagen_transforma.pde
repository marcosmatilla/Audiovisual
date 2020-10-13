/******************************************
 * Carga una imagen y permite escalarla +/-
 * desplazarla arrastrando el ratón
 *******************************************/

// Declaramos una variable de tipo PImage
PImage img;
float escala= 1.0;
int x= 0, y= 0;

void setup()
{
  // Crea una instancia de PImage para cargar el fichero de imagen
  img = loadImage("lighthouse.jpg");

  size(512,640);
  background(191);
}

void draw()
{
  background(191);  
  scale(escala);
  
  // Muestra la imagen en pantalla en las coordenadas (0,0)
  image(img,x,y);
}

//Cuando se presiona una tecla
void keyPressed() {

    if (key=='+') {
      escala= escala*2;
    }
    else if (key=='-') {
      escala= escala/2;
    }
}

//Cuando se arrastra el mouse
void mouseDragged() {
  int despx= mouseX - pmouseX;
  int despy= mouseY - pmouseY;
  x+= despx/escala;
  y+= despy/escala;
  println("x= "+x+", y= "+y+", escala= "+escala);
  
}

