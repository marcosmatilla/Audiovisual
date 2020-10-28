import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
BeatDetect beat;

boolean pausado=false;

float anteriorX,anteriorY;
float eRadius;

void setup() {
  size(500,500);
  minim=new Minim(this);
  
  player=minim.loadFile("heartbeat-speeding-up-01.mp3");
  //player=minim.loadFile("Metronom Taktell Junior.wav");
  //player=minim.loadFile("Metronom Claves.wav");

  player.loop();
  pausado=false;
  
  beat=new BeatDetect();
  beat.detectMode(BeatDetect.SOUND_ENERGY);//BeatDetect.FREQ_ENERGY);
}

void draw() {
  if (!pausado) {
    background(128);
    for (int i=0;i<player.bufferSize();i++) {
      float valor=player.mix.get(i);
      float posY=map(valor,-1,1,0,height);
      float posX=map(i,0,player.bufferSize(),0,width);
      if (i>0) line(anteriorX,anteriorY,posX,posY);
      anteriorX=posX;
      anteriorY=posY;
    }
    
    beat.detect(player.mix);
    float a = map(eRadius, 20, 80, 60, 255);
    fill(60, 255, 0, a);
    if ( beat.isOnset() ) eRadius = 80;
    ellipse(width/2, height/2, eRadius, eRadius);
    eRadius *= 0.95;
    if ( eRadius < 20 ) eRadius = 20;    
  }
}

void keyPressed() {
  if (key==' ') {
    if (pausado) {
      player.play();
      pausado=false;
    } else {
      player.pause();
      pausado=true;
    }
  }
  if (key=='r') {
    player.rewind();
    pausado=false;
    player.loop();
  }
}
