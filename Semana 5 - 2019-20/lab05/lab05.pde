import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;


Capture video;
OpenCV opencvCara, opencvOjos, opencvBoca;

PShape gorra_chef, gorro_fiesta, gorra_santa;
PShape gafas1, gafas2;
PShape[] lista_gorras=new PShape[3];

boolean gorra = false, gafas = false;
int actual=0;

void setup() {
  size(640, 360);

  
  opencvCara = new OpenCV(this, 640, 360); // Tiene que tener la misma resolución que el vídeo
  opencvOjos = new OpenCV(this, 640, 360);
  opencvBoca = new OpenCV(this, 640, 360);

  loadShapes();

  video = new Capture(this, 640, 360);

  opencvCara.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  opencvOjos.loadCascade(OpenCV.CASCADE_EYE);
  opencvBoca.loadCascade(OpenCV.CASCADE_MOUTH);

  video.start();
}

void loadShapes() {
  gorra_santa=loadShape("santa.svg");
  gorra_chef=loadShape("cocinero.svg");
  gorro_fiesta=loadShape("fiesta.svg");

  gafas1=loadShape("gafas2.svg");

  lista_gorras[0]=gorra_santa;
  lista_gorras[1]=gorro_fiesta;
  lista_gorras[2]=gorra_chef;
}

void draw() {
  image(video, 0, 0);

  if (video.height>0 && video.width>0) {  // Más eficiente que video.available()
    opencvCara.loadImage(video);
    opencvOjos.loadImage(video);
    opencvBoca.loadImage(video);

    noFill();
    strokeWeight(3);

    Rectangle[] caras = opencvCara.detect();
    Rectangle[] ojos = opencvOjos.detect();
    Rectangle[] bocas = opencvBoca.detect();

    stroke(0, 255, 0);

    // Como mucho se procesa una cara (la más grande)
    for (int i = 0; i < min(1, caras.length); i++) {
      //println(caras[i].x + "," + caras[i].y);
      //rect(caras[i].x, caras[i].y, caras[i].width, caras[i].height);
      //print(lista_gorras[actual]);
      if (gorra) {
        shape(lista_gorras[actual], caras[i].x, caras[i].y-caras[i].height/2, caras[i].width, caras[i].height/2);
      }
    }

    stroke(0, 0, 255);

    // Hay que comprobar que los ojos están dentro de alguna cara
    // Como mucho se procesan dos ojos y se buscan en una sola cara
    for (int i=0; i < min(2, ojos.length); i++) {
      for (int j=0; j < min(1, caras.length); j++) {
        if (dentroCara(ojos[i], caras[j])) {
          //println(ojos[i].x + "," + ojos[i].y);
          //rect(ojos[i].x, ojos[i].y, ojos[i].width, ojos[i].height);
          if (gafas) {
            shape(gafas1, caras[j].x, ojos[j].y-ojos[j].height/2, caras[j].width, caras[j].height/2);
          }
        }
      }
    }

    stroke(255, 0, 0);

    // Hay que comprobar que la boca está dentro de alguna cara
    // Mismo procedimiento que para los ojos
    for (int i=0; i < min(1, bocas.length); i++) {
      for (int j=0; j < min(1, caras.length); j++) {
        if (dentroCara(bocas[i], caras[j])) {
          //println(bocas[i].x + "," + bocas[i].y);
          //rect(bocas[i].x, bocas[i].y, bocas[i].width, bocas[i].height);
        }
      }
    }
  }
  //noLoop();
}


void movieEvent(Movie movie) {
  movie.read();
}

void captureEvent(Capture c) {
  c.read();
}

boolean dentroCara(Rectangle detalle, Rectangle cara) {
  int topY, bottomY, leftX, rightX;

  topY=cara.y;
  bottomY=topY+cara.height;
  leftX=cara.x;
  rightX=leftX+cara.width;

  boolean result=true;

  if (detalle.x<leftX) result=false;
  if (detalle.y<topY) result=false;
  if (detalle.x+detalle.width>rightX) result=false;
  if (detalle.y+detalle.height>bottomY) result=false;

  return result;
}

void keyPressed() {

  if (key==CODED && keyCode == RIGHT) {
    if (actual >= 0 && actual <lista_gorras.length-1) {
      actual++;
    }
  } else if (key==CODED && keyCode == LEFT) {
    if (actual > 0 && actual <lista_gorras.length) {
      actual--;
    }
  }
  if (key=='s') {
    gorra = gorra ? false : true;
  }
  if (key=='g') {
    gafas = gafas ? false : true;
  }

}
