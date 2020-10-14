import processing.video.*; 

Movie movie; 

void setup() {  
  fullScreen();
  movie = new Movie(this, "file_example_MOV_480_700kB.mov");//"DELTA.MPG");  
  movie.loop();
  movie.speed(10);//0.25); // Se puede acelerar o decelerar la velocidad de reproducción
}

// Cualquier procesamiento sobre la película debería hacerse aquí
// Dependiendo de lo que tarde el procesamiento puede haber "glitches" en la reproducción
void movieEvent(Movie movie) {
  movie.read();
  //movie.filter(THRESHOLD,0.5);
  //movie.filter(GRAY);
  movie.filter(INVERT);
  //movie.filter(BLUR,6);
}

void draw() {
  image(movie,0,0,width,height); // No es buena idea cambiar en tiempo real la resolución de la película
}