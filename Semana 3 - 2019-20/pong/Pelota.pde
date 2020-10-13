class Pelota {
  int x, y, diametro;
  int velY=2;
  int velX=2;
  int contadorRebotes;

  Pelota(int x, int y, int diametro) {
    this.x=x;
    this.y=y;
    this.diametro=diametro;
    contadorRebotes=0;
  }

  void mostrar() { 
    if (tocoAbajo()) {
      velY=-velY;
    }
    if (tocoArriba()) {
      velY=-velY;
    }
    if(tocoDerecha()){
      velX=-velX;
    }
    if(tocoIzquierda()){
      velX=-velX;
    }

    y+=velY;
    x+=velX;

    ellipse(x, y, diametro, diametro);
  }

  boolean tocoArriba() {
    return y-diametro/2.0<=0;
  }

  boolean tocoAbajo() {
    int minX=miPala.getMinX();
    int maxX=miPala.getMaxX();

    println("x: "+x+"\t"+"y: "+y+"\tminX: "+minX+"\tmaxX: "+maxX);

    if (y+diametro/2.0>=miPala.getMaxY()) {
      if (x>=minX && x<=maxX) {
        if (contadorRebotes < 5) {
          contadorRebotes++;
        } else {
          velY+=5;
          contadorRebotes=0;
        }
        return true;
      } else {
        return false;
      }
    } else 
    return false;
  }
  
  boolean tocoDerecha(){
    return x-diametro/2.0<=0;
  }
  
  boolean tocoIzquierda(){
     return x+diametro/2.0>=width;
  }
}
