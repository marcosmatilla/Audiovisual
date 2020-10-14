import processing.video.*;

Capture camara;

void setup() {
  fullScreen();
  camara=new Capture(this,640,480); // La cámara admite otras resoluciones obviamente
  camara.start();
}

void draw() {
//  image(camara,0,0,width,height);
//  tint(255,128);
  image(camara,width/2-camara.width/2,height/2-camara.height/2);
//noLoop();
}

void captureEvent(Capture c) {
  c.read();
}