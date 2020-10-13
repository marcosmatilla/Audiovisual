/************************************************
 * Accediendo a los pixels de la ventana
 * Los pinta con valores aleatorios de gris
 ************************************************/

size(200,200);

// Antes de acceder a los pixels
loadPixels();

// Bucle para recorrer los pixels
for (int i = 0; i < pixels.length; i++ ) 
{ // Podemos obtener la longitud (length) del array de pixels como cualquier otro array.
  
  // Genera un número aleatorio, 0 to 255
  float rand = random(255);
  
  // Crea un gris basado en el número aleatorio
  color c = color(rand);
  
  // "Pinta" el pixel con el gris creado anteriormente
  pixels[i] = c; // Podemos acceder a los pixels individuales indexando el array pixels, como cualquier otro array.
}

// Indicamos que hemos finalizado el proceso de pixels
updatePixels();
