class Smoke {
  ParticleSystem ojoizquierdo,ojoderecho;

  Smoke(int leftX,int leftY,int rightX,int rightY) {
    PImage img = loadImage("smoke_PNG55239.png");//"texture.png");
    img.resize(90,90);
    ojoizquierdo = new ParticleSystem(0, new PVector(leftX,leftY), img);
    ojoderecho = new ParticleSystem(0, new PVector(rightX,rightY), img);
  }

  void draw(float leftX,float leftY,float rightX,float rightY) {
    ojoizquierdo.setOrigin(new PVector(leftX,leftY));
    ojoderecho.setOrigin(new PVector(rightX,rightY));
    
    ojoizquierdo.run();
    ojoderecho.run();
    for (int i = 0; i < 2; i++) {
      ojoizquierdo.addParticle();
      ojoderecho.addParticle();
    }
  }
}