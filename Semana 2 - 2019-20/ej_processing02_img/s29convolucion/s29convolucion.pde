/********************************************************
 * Programa que permite aplicar una matriz de convolución
 * a una imagen. En función de la matriz, los efectos son
 * diferentes.
 **********************************************************/
 
PImage img;
int w = 200;    // lado de la porción cuadrada que procesamos

// Es posible realizar la convolución con distintas matrices

// Filtrado paso-bajo: suavizado, eliminación de ruido
//float[][] matrix = { { 1/9.0, 1/9.0, 1/9.0 },
//                     { 1/9.0,  1/9.0, 1/9.0 },
//                     { 1/9.0, 1/9.0, 1/9.0 } }; 

// Filtrado paso-bajo: suavizado, eliminación de ruido
//float[][] matrix = { { 0, 1/8.0, 0 },
//                     { 1/8.0,  1/2.0, 1/8.0 },
//                     { 0, 1/8.0, 0 } }; 

// Filtrado direccional
//float[][] matrix = { { 1/3.0, 0, 0 },
//                     { 0,  1/3.0, 0 },
//                     { 0, 0, 1/3.0 } }; 

// Filtrado paso-alto: resalta bordes
float[][] matrix = { { -1, -1, -1 },
                     { -1,  9, -1 },
                     { -1, -1, -1 } }; 

// Filtrado paso-alto: resalta bordes -- Sobel vertical
//float[][] matrix = { { -1, -2, -1 },
//                     { 0,  0, 0 },
//                     { 1, 2, 1 } }; 

// Filtrado paso-alto: resalta bordes -- Sobel horizontal
//float[][] matrix = { { -1, 0, 1 },
//                     { -2,  0, 2 },
//                     { -1, 0, 1 } };  

void setup() {
  size(512, 640);
  frameRate(30);
  img = loadImage("lighthouse.jpg");
}

void draw() {
  // Sólo vamos a procesar una porción de la imagen
  // Así que ponemos primero toda la imagen como fondo
  image(img,0,0);
  // Área cuadrada que procesamos
  int xstart = constrain(mouseX-w/2,0,img.width);
  int ystart = constrain(mouseY-w/2,0,img.height);
  int xend = constrain(mouseX+w/2,0,img.width);
  int yend = constrain(mouseY+w/2,0,img.height);
  loadPixels();
  // Recorremos todos los pixeles del área que procesamos
  for (int x = xstart; x < xend; x++) {
    for (int y = ystart; y < yend; y++ ) {
      // Se pasa cada pixel a una función llamada convolution() que 
      // devuelve un nuevo valor de color para este pixel
      color c = convolution(x,y,matrix,img);
      int loc = x + y*img.width;
      pixels[loc] = c;
    }
  }
  updatePixels();

  stroke(0);
  noFill();
  rect(xstart,ystart,w,w);
}

/**
 * Función de convolución
 * x, y: coordenadas del pixel a tratar 
 * matrix: matriz de convolución
 * img: imagen que estamos tratando 
 */
color convolution(int x, int y, float[][] matrix, PImage img) {
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int matrixsize= matrix.length;
  int offset = matrixsize / 2;

  // Bucle que recorre la matriz de convolución
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      // pixel que estamos probando
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + img.width*yloc;
      // Nos aseguramos de que no superamos el borde del array de pixels
      loc = constrain(loc,0,img.pixels.length-1);
      // Calcula la convolución
      // Suma de todos los pixels vecinos multiplicados por los valores de la matriz de convolución
      rtotal += (red(img.pixels[loc]) * matrix[i][j]);
      gtotal += (green(img.pixels[loc]) * matrix[i][j]);
      btotal += (blue(img.pixels[loc]) * matrix[i][j]);
    }
  }

  // Nos aseguramos que el RGB está dentro del rango
  rtotal = constrain(rtotal,0,255);
  gtotal = constrain(gtotal,0,255);
  btotal = constrain(btotal,0,255);
  // Devuelve el color resultante
  return color(rtotal,gtotal,btotal);
}
