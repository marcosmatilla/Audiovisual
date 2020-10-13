import ddf.minim.*;

Pala miPala;
Pelota miPelota;

Minim minim;
AudioPlayer player;
AudioSample bounce, laser, ouch;

boolean jugar = false;
boolean music;
boolean pause;

float vol;

void setup() {
  size(1000, 800);
  surface.setResizable(true);

  minim = new Minim(this);
  player = minim.loadFile("musica_ambiente.mp3");
  music=false;

  miPala=new Pala(width/2, height-10, 150);
  miPelota=new Pelota(100);
  
  vol=0;
  player.setGain(vol);
}

void draw() {
  clear();
  background(128);

  if (jugar) {
    miPala.mostrar();
    miPelota.mostrar();
    fill(255);
    textSize(40);
    text("Vol", 50, 100);
    textSize(40);
    text(int(vol), 150, 100);
    if (miPelota.getVidas()>0) {
      fill(255);
      textSize(40);
      text("Vidas", 750, 100);
      textSize(40);
      text(miPelota.getVidas(), 900, 100);
    } else {
      minim.stop();
      textSize(40);
      text("GAME OVER", width/6, height/2);
      textSize(40);
      text("¿Desea empezar de nuevo? Pulse 'j'", width/6, height/1.5);
    }
  } 
  else if(!jugar && pause){
    textSize(40);
    text("PAUSA", width/6, height/2);
    textSize(20);
    text("Pulse 'r' para continuar \nPulse 's' para pausar", width/6, height/1.5);
  }else {
    textSize(40);
    text("PONG –INFORMÁTICA AUDIOVISUAL", width/6, height/2);
    textSize(40);
    text("¿Desea empezar? Pulse 'j'", width/6, height/1.5);
  }
}

void keyTyped() {
  if (key=='j') {
    jugar = true;
    player.play();
    miPelota=new Pelota(100);
  }
  if (key=='s') {
    jugar=false;
    pause=true;
  }
  if (key=='r') {
    jugar=true;
    pause=false;
  }
}

void keyPressed() {
  if (key=='+') {
    if (vol >= -20 && vol < 20)
      player.setGain(vol+=1);
  }
  if (key=='-') {
    if (vol > -20 && vol <= 20)
      player.setGain(vol-=1);
  }
}
