PImage rejilla, malabarista, ajuste;

fullScreen();


rejilla=loadImage("grid.jpg");
malabarista=loadImage("imagen.jpg");
ajuste=loadImage("carta-ajuste.jpg");

//image(ajuste,0,0);
/*
for (int ancho=displayWidth;ancho>=500;ancho-=250) {
  int alto=malabarista.height*ancho/malabarista.width;
  image(malabarista,0,0,ancho,malabarista.height);//alto);
}
*/
/*
for (int escala=100;escala>=10;escala-=10) {
  float escala2=escala/100.0;
  scale(escala2);
  image(malabarista,0,0);
}
filter(GRAY);
scale(1000);
image(malabarista,0,0);

//image(rejilla,0,0);

println(malabarista.width+"x"+malabarista.height);
println(displayWidth+"x"+displayHeight);
*/
/*
image(malabarista,0,0);
image(rejilla,0,0);
//filter(THRESHOLD);
//filter(GRAY);
//filter(INVERT);
//filter(POSTERIZE,2);
//filter(BLUR,10);
//filter(ERODE);
//filter(DILATE);
*/


/*
ajuste.loadPixels();

color colorActual;
for (int i=0;i<ajuste.pixels.length;i++) {
  colorActual=ajuste.pixels[i];
//  ajuste.pixels[i]=color((red(colorActual)+green(colorActual)+blue(colorActual))/3);
}
*/

/*
ajuste.loadPixels();

color colorActual;

int i;

int izquierda=250;
int derecha=ajuste.width-250;
int arriba=250;
int abajo=ajuste.height-250;

for (int y=0;y<ajuste.height;y++) {
  for (int x=0;x<ajuste.width;x++) {
    if (x>=izquierda && x<=derecha && y>=arriba && y<=abajo) {
      i=x+y*ajuste.width;
      colorActual=ajuste.pixels[i];
      //ajuste.pixels[i]=color(255-red(colorActual),255-green(colorActual),255-blue(colorActual));
      if (brightness(colorActual)>128) {
        ajuste.pixels[i]=color(255);
      } else
        ajuste.pixels[i]=color(0);
    }
  }
}
ajuste.updatePixels();

image(ajuste,0,0);
*/

image(malabarista,0,0,displayWidth,displayHeight);
println(malabarista.width+"x"+malabarista.height);
malabarista.resize(malabarista.width/20,malabarista.height/20);

image(malabarista,0,0,displayWidth,displayHeight);
println(malabarista.width+"x"+malabarista.height);
