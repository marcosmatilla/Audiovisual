import ddf.minim.*;

Minim minim;
AudioPlayer player;
AudioSample bounce,laser,ouch;

boolean playing;

void setup() {
  fullScreen();
  
  minim = new Minim(this);
  
  player = minim.loadFile("cancion.mp3");
  playing=false;
  
  //bounce=minim.loadSample("bounce.wav");
  laser=minim.loadSample("laser.wav");
  ouch=minim.loadSample("ouch.wav");
}

void draw() {
  if (playing) {
    background(color(255));
    for(int i = 0; i < player.bufferSize() - 1; i++)
    {
      float x1 = map( i, 0, player.bufferSize(), 0, width );
      float x2 = map( i+1, 0, player.bufferSize(), 0, width );
      line( x1, 50 + player.left.get(i)*50, x2, 50 + player.left.get(i+1)*50 );
      line( x1, 150 + player.right.get(i)*50, x2, 150 + player.right.get(i+1)*50 );
    }
  }
}

void keyPressed() {
  if (key==' ') {
    if (playing) {
      playing=false;
      player.pause();
    } else {
      playing=true;
      player.play();
    }
  }
  if (keyCode==LEFT) {
    laser.trigger();
  }
  if (keyCode==RIGHT) {
    ouch.trigger();
  }
}
