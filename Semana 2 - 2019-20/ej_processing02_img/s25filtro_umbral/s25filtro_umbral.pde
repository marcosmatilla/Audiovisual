/*****************************************************
 Aplica un filtro en la imagen con el efecto umbral
 *****************************************************/

PImage img;       // imagen origen

size(512, 640);
img = loadImage("lighthouse.jpg");  
// Dibuja la imagen
image(img,0,0);
// Función filter THRESHOLD
// 0.5 significa que el umbral es el 50% del brillo
filter(THRESHOLD,0.5);

// Otros filtros
//filter(GRAY);
//filter(INVERT);
//filter(POSTERIZE, 2);

