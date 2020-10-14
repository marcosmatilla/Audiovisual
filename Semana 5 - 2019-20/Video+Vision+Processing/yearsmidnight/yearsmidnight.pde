import com.hamoid.*;
import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;

Smoke smoke;
//Capture video;
Movie video;
OpenCV opencvOjos;
VideoExport videoExport;

float ratioX,ratioY;

void setup() {
  size(1280,720);

  // Nos preparamos para capturar la webcam
//  video = new Capture(this, 640, 360);
//  video.start();
  video=new Movie(this,"Poyo Rojo will always love you.mp4");
  video.loop();
  
  // Creamos el humo, las coordenadas iniciales son irrelevantes
  smoke=new Smoke(0,0,0,0);
  
  // Creamos un objeto OpenCV y le pasamos la cascada para detectar pares de ojos
  opencvOjos = new OpenCV(this,640,360);
  opencvOjos.loadCascade("haarcascade_mcs_eyepair_big.xml");//OpenCV.CASCADE_EYE);
  
  // Calculamos el ratio entre las imágenes que capturamos y las que queremos mostrar
  ratioX=width/640;
  ratioY=height/360;

  // Ponemos un frameRate de 30 (el típico para videos de internet)
  frameRate(30);
  
  // Creamos un objeto VideoExport para poder grabar la película
  videoExport = new VideoExport(this);
  videoExport.setFrameRate(30); // El mismo frameRate para VideoExport
  videoExport.startMovie();
}

void draw() {
  // Fondo negro
  background(0);
  
  // Puesto que tint aplica de manera global tenemos que indicar noTint antes de dibujar la imagen
  noTint();
  // Queremos que sea parcialmente transparente
  tint(255,128);
  // Ponemos el modo CORNER para no vernos afectados por el modo CENTER que se usa al visualizar el humo
  imageMode(CORNER);
  // La imagen se va a ver ampliada al doble de su tamaño
  image(video,0,0,1280,720);
  
  if (video.height>0 && video.width>0){  // Más eficiente que video.available()
    // Cargamos un frame de la cámara en OpenCV
    opencvOjos.loadImage(video);
    
    // Detectamos ojos (en realidad pares de ojos)
    Rectangle[] ojos = opencvOjos.detect();
    
    // Si se ha detectado algo
    if (ojos.length>0) {
      // Calculamos la altura de los ojos y la posición X de cada uno
      float heightEyes=(ojos[0].y+ojos[0].height/2.0)*ratioY;
      float leftEye=(ojos[0].x+ojos[0].width/6.0)*ratioX;
      float rightEye=(ojos[0].x+ojos[0].width-ojos[0].width/6.0)*ratioX;

      // Dibujamos el humo en la posición deseada
      smoke.draw(leftEye,heightEyes,rightEye,heightEyes);
    }
/*      
    // Por si queremos ver el bounding box para los ojos
    noFill();
    strokeWeight(3);
    stroke(0, 0, 255);

    for (int i=0; i < ojos.length; i++) {
      println(ojos[i].x + "," + ojos[i].y);
      rect(ojos[i].x*ratioX, ojos[i].y*ratioY, ojos[i].width*ratioX, ojos[i].height*ratioY);
    }
*/    
  }      
  
  // Pasamos a blanco y negro todo el canvas
  filter(GRAY); 

  // Grabamos el frame a la película
  videoExport.saveFrame();
}

void captureEvent(Capture c) {
  c.read();
}

void movieEvent(Movie m) {
  m.read();
}

void keyPressed() {
  if (key == 'q' || key == 'Q') {
    videoExport.endMovie();
    exit();
  }
}