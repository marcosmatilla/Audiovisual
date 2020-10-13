Pala miPala;
Pelota miPelota;

void setup() {
  //fullScreen();
  size(500,500);
  
  miPala=new Pala(width/2,height-10,150);
  miPelota=new Pelota(width/2,height/2,100);
}

void draw() {
  clear();
  background(128);
  miPala.mostrar();
  miPelota.mostrar();
}
