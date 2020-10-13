class Pala {
  int x, y, ancho;

  Pala(int x, int y, int ancho) {
    this.x=x;
    this.y=y;
    this.ancho=ancho;
  }

  void mostrar() {
    this.x=mouseX;
    if (salioDerecha()) {
      rect(width-ancho, y-25, ancho, 25);
    } else if (salioIzquierda()) {
      rect(0, y-25, ancho, 25);
    } else {
      rect(x-ancho/2, y-25, ancho, 25);
    }
  }

  int getMinX() {
    return x-ancho/2;
  }
  int getMaxX() {
    return x+ancho/2;
  }

  int getMinY() {
    return y;
  }
  int getMaxY() {
    return y-25;
  }

  boolean salioDerecha() {
    return x+ancho/2>=width;
  }

  boolean salioIzquierda() {
    return x-ancho/2<=0;
  }
}
