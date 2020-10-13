import ddf.minim.*;

class Pelota {
  int x, y, diametro, vidas, i;
  int velX, velY;
  int contadorRebotes;
  AudioSample bounce, laser, ouch;

  color negro = color(0, 0, 0);
  color azul = color(7, 67, 240);
  color rojo = color(236, 44, 44);
  color amarillo = color(252, 245, 13);
  color verde = color(16, 255, 0);

  color colores[] = {negro, azul, rojo, amarillo, verde};

  boolean bajando;

  Pelota(int diametro) {
    this.x=(int)random(0+100, width-100);
    this.y=(int)random(0+50, height-100);
    this.velY=(int)random(2, 5);
    this.velX=(int)random(2, 5);
    this.diametro=diametro;

    contadorRebotes=0;

    setVidas(5);

    laser=minim.loadSample("laser.wav");
    ouch=minim.loadSample("ouch.wav");

    i = 0;

    bajando=true;
  }

  void mostrar() { 
    if (getVidas()>0) {
      if (tocoAbajo()) {
        velY=-velY;
      }
      if (tocoArriba()) {
        velY=-velY;
      }
      if (tocoDerecha()) {
        velX=-velX;
      }
      if (tocoIzquierda()) {
        velX=-velX;
      }
      if (calcularVidas()) {
        x=(int)random(0+100, width-100);
        y=(int)random(0+50, height-100);
        velY=(int)random(2, 5);
        velX=(int)random(2, 5);
      }

      y+=velY;
      x+=velX;


      if (i==colores.length) {
        i=0;
      }
      fill(colores[i]);
      ellipse(x, y, diametro, diametro);
    }
  }

  boolean tocoArriba() {
    bajando=true;
    return y-diametro/2.0<=0;
  }

  boolean tocoAbajo() {
    if (bajando) {
      int minX=miPala.getMinX();
      int maxX=miPala.getMaxX();  

      //println("x: "+x+"\t"+"y: "+y+"\tminX: "+minX+"\tmaxX: "+maxX);

      if (y+diametro/2.0>=miPala.getMaxY()) {
        if (x>=minX && x<=maxX) {
          if (contadorRebotes < 5) {
            laser.trigger();
            contadorRebotes++;
          } else {
            laser.trigger();
            velY+=5;
            contadorRebotes=0;
          }
          bajando=false;
          i++;
          return true;
        } else {
          return false;
        }
      } else 
      return false;
    } else {
      return false;
    }
  }

  boolean tocoDerecha() {
    return x-diametro/2.0<=0;
  }

  boolean tocoIzquierda() {
    return x+diametro/2.0>=width;
  }

  boolean calcularVidas() {
    if (y-diametro/2.0 > miPala.getMaxY()) {
      ouch.trigger();
      vidas--;
      return true;
    }
    return false;
  }

  int getVidas() {
    return vidas;
  }

  void setVidas(int vidas) {
    this.vidas = vidas;
  }
}
