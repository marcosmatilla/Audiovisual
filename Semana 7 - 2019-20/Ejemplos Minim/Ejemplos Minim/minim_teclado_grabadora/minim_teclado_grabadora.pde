import ddf.minim.*;

Minim minim;
AudioOutput salida;
AudioRecorder grabadora;

float anteriorX,anteriorY;

float volume;

boolean mostrarPartitura=false;

void setup() {
  size(500,500);
  
  minim=new Minim(this);
  salida=minim.getLineOut();
  grabadora=minim.createRecorder(salida,"grabacion.wav");
  grabadora.beginRecord();
}

void draw() {
  background(128);
  color(255);
  stroke(255);
  if (mostrarPartitura) {
    textMode(CORNER);
    textSize(17);
    text("q-r-y---y-t-r---t-r-w-r\nq-r-y---y-y-Y-y-t\nq-r-y---y-t-r---t-y-Y\nw-Q-q---r-r-y---t-t-r\nq-r-y---y-t-r---t-r-w-r\nq-r-y---y-y-Y-y-t\nq-r-y---y-t-r---t-y-Y\nw-Q-q---r-r-y---t-t-r",10,20);
  }
  for (int i=0;i<salida.bufferSize();i++) {
    float valor=salida.mix.get(i);
    float posY=map(valor,-1,1,0,height);
    float posX=map(i,0,salida.bufferSize(),0,width);
    if (i>0) line(anteriorX,anteriorY,posX,posY);
    anteriorX=posX;
    anteriorY=posY;
  }
}

void keyPressed() {
//  volume=salida.getVolume();
  switch (key) {
    /*
    case '+':
      salida.setVolume(volume+1);
      break;
    case '-':
      salida.setVolume(volume-1);
      break;
    */
    case 'q':
      salida.playNote("Do");
      break;
    case 'Q':
      salida.playNote("Do#");
      break;
    case 'w':
      salida.playNote("Re");
      break;
    case 'W':
      salida.playNote("Re#");
      break;
    case 'e':
      salida.playNote("Mi");
      break;
    case 'E':
      salida.playNote("Mi#");
      break;
    case 'r':
      salida.playNote("Fa");
      break;
    case 'R':
      salida.playNote("Fa#");
      break;
    case 't':
      salida.playNote("Sol");
      break;
    case 'T':
      salida.playNote("Sol#");
      break;
    case 'y':
      salida.playNote("La");
      break;
    case 'Y':
      salida.playNote("La#");
      break;
    case 'u':
      salida.playNote("Si");
      break;
    case 'U':
      salida.playNote("Si#");
      break;
    case 'x':case 'X':
      grabadora.endRecord();
      grabadora.save();
      exit();
      break;
    case ' ':
      mostrarPartitura=!mostrarPartitura;
      break;
  }

}
