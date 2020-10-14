import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;

Capture video;
//Movie video;
OpenCV opencvCara,opencvOjos,opencvBoca;

void setup() {
  size(640, 480);
  video = new Capture(this, 640, 480);
  //video = new Movie(this,"Poyo Rojo will always love you.mp4");

  opencvCara = new OpenCV(this,640,480); // Tiene que tener la misma resolución que el vídeo
  opencvOjos = new OpenCV(this,640,480);
  opencvBoca = new OpenCV(this,640,480);
  
  opencvCara.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  opencvOjos.loadCascade(OpenCV.CASCADE_EYE);
  opencvBoca.loadCascade(OpenCV.CASCADE_MOUTH);

  video.start();
  //video.loop();
}

void draw() {
  image(video,0,0);
  
  if (video.height>0 && video.width>0){  // Más eficiente que video.available()
    opencvCara.loadImage(video);
    opencvOjos.loadImage(video);
    opencvBoca.loadImage(video);
    
    noFill();
    strokeWeight(3);
  
    Rectangle[] caras = opencvCara.detect();
    Rectangle[] ojos = opencvOjos.detect();
    Rectangle[] bocas = opencvBoca.detect();
      
    println(caras.length);
  
    stroke(0, 255, 0);
   
    // Como mucho se procesa una cara (la más grande)
    for (int i = 0; i < min(1,caras.length); i++) {
      println(caras[i].x + "," + caras[i].y);
      rect(caras[i].x, caras[i].y, caras[i].width, caras[i].height);
    }
      
    stroke(0, 0, 255);
      
    // Hay que comprobar que los ojos están dentro de alguna cara
    // Como mucho se procesan dos ojos y se buscan en una sola cara
    for (int i=0; i < min(2,ojos.length); i++) {
      for (int j=0; j < min(1,caras.length); j++) {
        if (dentroCara(ojos[i],caras[j])) {
          println(ojos[i].x + "," + ojos[i].y);
          rect(ojos[i].x, ojos[i].y, ojos[i].width, ojos[i].height);
        }
      }
    }
  
    stroke(255, 0 ,0);
      
    // Hay que comprobar que la boca está dentro de alguna cara
    // Mismo procedimiento que para los ojos
    for (int i=0; i < min(1,bocas.length); i++) {
      for (int j=0; j < min(1,caras.length); j++) {
        if (dentroCara(bocas[i],caras[j])) {
          println(bocas[i].x + "," + bocas[i].y);
          rect(bocas[i].x, bocas[i].y, bocas[i].width, bocas[i].height);
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
  int topY,bottomY,leftX,rightX;
  
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