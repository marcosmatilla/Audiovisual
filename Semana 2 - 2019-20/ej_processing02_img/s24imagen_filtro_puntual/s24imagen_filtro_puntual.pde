/**************************************************
 * Carga imagen de fondo
 * Aplica efectos de color que se mezclan con una segunda imagen
 * Muestra esta imagen modificada
 *************************************************/
 
// Declaramos una variable de tipo PImage
PImage img, imgFondo;	

size(512,640);
// Crea una instancia de PImage para cargar el fichero de imagen
img = loadImage("lighthouse.jpg");
imgFondo= loadImage("landscape3.jpg");

background(imgFondo);
// Operación puntual sobre cada pixel de img
// tint(255);  // mantiene valores de los pixels
// tint(100);  // imagen más oscura
// tint(255,127);  // incorpora un canal alfa con 50% de transparencia
tint(255,0,0);  // modifica cada unos de los canales RGB
// tint(255,180);  // transparencia
// Muestra la imagen en pantalla en las coordenadas (0,0)
image(img,0,0);