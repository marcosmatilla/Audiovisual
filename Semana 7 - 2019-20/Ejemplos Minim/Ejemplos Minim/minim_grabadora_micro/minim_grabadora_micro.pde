import ddf.minim.*;

Minim minim;
AudioInput entrada;
AudioRecorder grabadora;
 
void setup() {
  fullScreen();
  minim = new Minim(this);
  entrada=minim.getLineIn();
  grabadora=minim.createRecorder(entrada,"grabacion.wav");
}
 
void draw() {
  background(0);
  stroke(255);
  
  float ancho=entrada.bufferSize();
  float ratio=width/ancho;
  
  for(int i = 0; i < entrada.bufferSize() - 1; i++)
  {
    line( i*ratio, 50 + entrada.left.get(i)*50, (i+1)*ratio, 50 + entrada.left.get(i+1)*50 );
    line( i*ratio, 150 + entrada.right.get(i)*50, (i+1)*ratio, 150 + entrada.right.get(i+1)*50 );
  }
}
    
void keyPressed() {
  switch (key) {
    case 's':case 'S':
      if (!grabadora.isRecording())
        grabadora.beginRecord();
      else
        grabadora.endRecord();
      break;
    case 'x':case 'X':
      grabadora.endRecord();
      grabadora.save();
      println("Grabado.");
      exit();
  }
}
 
