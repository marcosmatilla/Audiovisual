PImage[] listaImg;

int indiceImg= 0;
float escala= 1.0;
File dir; 
File [] files;

boolean imagesOK = false;
boolean presentacion = false;
boolean filtro = false;

boolean derecha = false;
boolean izquierda = false;

int x;
int opacity=255;

void setup() {
  size(800, 800);
  selectFolder("Elige un directorio:", "folderSelected");
  x=width/2;
}


void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());

    dir= new File(dataPath(selection.getAbsolutePath()));
    files= dir.listFiles();
    listaImg= new PImage[files.length];

    for (int i = 0; i <= files.length - 1; i++) {
      String path = files[i].getAbsolutePath();
      if (path.toLowerCase().endsWith(".jpg")) {
        listaImg[i] = loadImage(files[i].getAbsolutePath());
        print(listaImg[i] + "\n");
      }
    }
    imagesOK = true;
  }
}

void draw() {
  imageMode(CENTER); 
  background(0);

  if (imagesOK && listaImg.length > 0) {
    calcularEscala();
    if (presentacion) {
      modoPresentacion();
    }

    if (derecha) {
      moverDerecha();
    } else if (izquierda) {
      moverIzquierda();
    } else {
      image(listaImg[indiceImg], 800/2, 800/2);
    }



    if (filtro) {
      filtro();
    }
  }
}



void calcularEscala() {
  listaImg[indiceImg].resize(700, 0);
  //image(listaImg[indiceImg], 800/2, 800/2);
}

void modoPresentacion() {
  if (indiceImg <= listaImg.length) {
    image(listaImg[indiceImg], 800/2, 800/2);
    delay(1000);
    indiceImg++;
    if (indiceImg == listaImg.length) {
      indiceImg=0;
    }
  }
}

void filtro() {
  filter(GRAY);
}

void noFiltro() {
  tint(255, 255, 255);
}

void moverDerecha() {
  if (x < width) {
    image(listaImg[indiceImg-1], x, 800/2);
    x++;
  } else {
    derecha=false;
    x=width/2;
    opacity=255;
  }
  if (opacity > 0) {
    tint(255, 255, 255, opacity);
    opacity--;
  }
}

void moverIzquierda() {
  if (x > 0) {
    image(listaImg[indiceImg+1], x, 800/2);
    x--;
  } else {
    izquierda=false;
    x=width/2;
    opacity=255;
  }
  /*if (opacity > 0) {
   tint(255, 255, 255, opacity);
   opacity--;
   }*/
}

void keyPressed() {
  if (key==CODED) {
    if (keyCode==LEFT && indiceImg>0) {
      indiceImg--;
      izquierda=true;
    } else if (keyCode==RIGHT && indiceImg<listaImg.length-1) {
      indiceImg++;
      derecha=true;
    }
  }
}

void keyTyped() {
  if (key=='c') {
    presentacion=true;
    println("Arranca el modo presentación");
  } else if (key=='s') {
    presentacion=false;
    indiceImg=0;
    println("Se para el modo presentación");
  } else if (key=='a') {
    filtro = true;
    println("Se ha activado un filtro");
  } else if (key=='d') {
    filtro = false;
    println("Se ha desactivado un filtro");
  }
}
