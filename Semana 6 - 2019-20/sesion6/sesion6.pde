import processing.svg.*;

float topx, topy, botx, boty, nosey, nosex, eyex, eyey, mouth, brow1, brow2, pupilsLine;
int x, y;
void setup() {
  size(400, 300);
  //head variable
  topx = random(25, 70);
  topy = random(40, 60);
  botx = random(30, 70);
  boty = random(30, 50);
  //nose variable
  nosey = random(5, 15);
  nosex = random(5, 15);
  //eye variables
  eyex = random(10, 20);
  eyey = random(5, 10);
  //mouth variable
  mouth = random(-10, 10);
  //eyebrow variable
  brow1 = random(5, 20);
  brow2 = random(5, 20);
  //pupils variable
  pupilsLine=random(2, 5);

  y=height/2;
  x=width/2;

  beginRecord(SVG, "caras_uo258935.svg");
}

void draw() {
  background(150);
  smooth();

  //head
  fill(255);
  noStroke();
  ellipse (x, y, topx, topy);
  ellipse (x, y+15, botx, boty);
  //eyes
  stroke(1);
  strokeWeight(1);
  ellipse (x-10, y, eyex, eyey);
  ellipse (x+10, y, eyex, eyey);
  //pupils
  strokeWeight(pupilsLine);
  point(x-10, y);
  point(x+10, y);
  //mouth
  strokeWeight(1);
  beginShape();
  curveVertex(x-15, y+20);
  curveVertex(x-15, y+20);
  curveVertex(x, y+(20+mouth));
  curveVertex(x+15, y+20);
  curveVertex(x+15, y+20);
  endShape();
  //nose
  strokeWeight(1);
  beginShape();
  vertex(x, y);
  vertex(x-nosex, y+nosey);
  vertex(x+nosex, y+nosey);
  endShape(CLOSE);
  //brow
  line(x-5, y-brow1, x-20, y-brow2);
  line(x+5, y-brow1, x+20, y-brow2);
}

void keyPressed() {
  if (key=='h') {
    topx = random(25, 70);
    topy = random(40, 60);
    botx = random(30, 70);
    boty = random(30, 50);
  }
  if (key=='e') {
    eyex = random(10, 20);
    eyey = random(5, 10);
  }
  if (key=='p') {
    pupilsLine=random(2, 5);
  }
  if (key=='m') {
    mouth = random(-10, 10);
  }
  if (key=='n') {
    nosey = random(5, 15);
    nosex = random(5, 15);
  }
  if (key=='b') {
    brow1 = random(5, 20);
    brow2 = random(5, 20);
  }
  if (key=='q') {
    endRecord();
    exit();
  }
}
