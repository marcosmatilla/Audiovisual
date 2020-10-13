/***********************************************
 * Modifica pixels de acuerdo a su posición 2D
 ***********************************************/

size(200,200);
loadPixels();

 // Dos bucles permiten recorrer cada columna (x) y cada fila (y).
 
// Bucle de todos los pixels de la columna
for (int x = 0; x < width; x++ ) {
  // Bucle de todos los pixels de la fila
  for (int y = 0; y < height; y++ ) {
    
    // Usa la fórmula para encontrar el pixels correspondiente en el array unidimensional
    int loc = x + y * width; 
    // La posición del pixels en el array se calcula con 
    // la formula: 1D pixel location = x + y * width
    
    // Usamos el valor de la columna (x) para determinar si el color es blanco o negro
    if (x % 2 == 0) { // Si estamos en una columna par
      pixels[loc] = color(255);
    } else { // Si estamos en una columna impar
      pixels[loc] = color(0);
    }
  
  }
}

updatePixels();
