int anteriorX, anteriorY;
int inicio, tiempoTotal;

//Declaracion de los colores
color negro = color(0, 0, 0);
color azul = color(7, 67, 240);
color rojo = color(236, 44, 44);
color amarillo = color(252, 245, 13);
color verde = color(16, 255, 0);

color colores[] = {negro, azul, rojo, amarillo, verde};

int colorDefecto;
float grosor;

//Fuentes
PFont times, arial, arialGrande;

boolean unaVez = true;

void setup() {
  inicio=millis();

  times=createFont("Times New Roman", 50);
  arial=createFont("Arial", 30);
  arialGrande=createFont("Arial", 70);

  fullScreen();

  background(255);

  fill(0);
  textFont(times);
  text("PBL Mini-paint", width/2.5, height/9); 

  fill(255); //rectangulo para el grosor
  strokeWeight(1);
  stroke(0);
  rect(100, 80, 120, 60);

  fill(0);
  strokeWeight(1);
  circle(160, 110, 1);

  fill(255); //rectangulo para el color
  strokeWeight(1);
  stroke(0);
  rect(1455, 80, 120, 60);

  colorDefecto=0;
  grosor=1;
}

void draw() {

  fill(colores[colorDefecto]); //Cartel color
  textFont(arial);
  text("Color", width/1.3, height/9);
  
  if (mousePressed && mouseButton==LEFT && (mouseY > height/7)) { 
    line(anteriorX, anteriorY, mouseX, mouseY);
  }

  anteriorX=mouseX;
  anteriorY=mouseY;

  tiempoTotal=millis()-inicio;

  if (tiempoTotal>30000) { //30 segundos
    int tiempoCierre = millis();

    fill(0);

    textFont(arialGrande);

    noStroke(); //no deja pintar mas

    if (unaVez) {
      unaVez = false;
      saveFrame("####-" + day()+year()+"_final.jpg");
    }

    text("¡Se acabó el tiempo de dibujo!", width/4, height/2);

    if (tiempoCierre > 37000) {
      exit();
    }
  }
}

void keyTyped() {
  if (key=='+') {
    grosor+=1;
    grosor=(grosor>50)?50:grosor;

    fill(255);
    strokeWeight(1);
    stroke(0);
    rect(100, 80, 120, 60);

    fill(0);
    circle(160, 110, (grosor>50)?50:grosor);
  } else if (key=='-') {
    grosor-=1;
    grosor=(grosor<1)?1:grosor;

    fill(255);
    strokeWeight(1);
    stroke(0);
    rect(100, 80, 120, 60);

    fill(0);
    circle(160, 110, (grosor<1)?1:grosor);
  }
  stroke(colores[colorDefecto]);
  strokeWeight(grosor);
}

void keyPressed() {
  if (keyCode==RIGHT) { //derecha
    if (colorDefecto>=0 && colorDefecto<colores.length-1) {
      colorDefecto++;
      stroke(colores[colorDefecto]);
    }
  } else if (keyCode==LEFT) { //izquierda
    if (colorDefecto>0 && colorDefecto<colores.length) {
      colorDefecto--;
      stroke(colores[colorDefecto]);
    }
  } else if (keyCode==CONTROL) { //guardar
    saveFrame("####-" + day()+year()+".jpg");
  }
}
