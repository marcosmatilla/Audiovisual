/********************************************
 * Carga una imagen y la muestra en pantalla
 *********************************************/
 
// Declaramos una variable de tipo PImage
PImage img;

size(512,640);
// Crea una instancia de PImage para cargar el fichero de imagen
img = loadImage("lighthouse.jpg");

background(191);  
  
// Muestra la imagen en pantalla en las coordenadas (0,0)
image(img,0,0);


