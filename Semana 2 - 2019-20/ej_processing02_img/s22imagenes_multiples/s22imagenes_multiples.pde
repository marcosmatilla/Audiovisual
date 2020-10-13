/******************************************************
 * Muestra todas las imágenes en el directorio data
 ******************************************************/
 
// Declaramos una variable de tipo PImage
PImage[] listaImg;
int indiceImg= 0;
float escala= 1.0;
int x= 0, y= 0;
float radianes= 0;

void setup()
{
  //String path= "C:\\Users\\jrpp\\Pictures\\img_processing";
  String path= dataPath("");
  File[] files = listFiles(path);

  print("Dir. data: "+path+"\n"); 
  print("Num. imágenes: "+files.length+"\n"); //Cuantas imágenes
  println();

  listaImg= new PImage[files.length];
  // Crea un array de PImage para cargar cada uno de los ficheros de imagen
  for(int i=0;i<files.length;i++) {
    println("Fichero "+i+": "+files[i]); 
    listaImg[i] = loadImage(files[i].getAbsolutePath());
  }

  size(512,640);
  background(191);
}

void draw()
{
  size(listaImg[indiceImg].width,listaImg[indiceImg].height);

  background(191);  
  scale(escala);
  
  // Muestra la imagen en pantalla en las coordenadas (0,0)
  image(listaImg[indiceImg],x,y);
}

//Cuando se presiona una tecla
void keyPressed() {
  if (key==CODED) {
    if (keyCode==LEFT && indiceImg>0) {
      indiceImg--;      
    }
    else if (keyCode==RIGHT && indiceImg<listaImg.length-1) {
      indiceImg++;
    }
  } 
  else {

    if (key=='+') {
      escala= escala*2;
    }
    else if (key=='-') {
      escala= escala/2;
    }
          
  }
}

//Cuando se arrastra el mouse
void mouseDragged() {
  int despx= mouseX - pmouseX;
  int despy= mouseY - pmouseY;
  x+= despx/escala;
  y+= despy/escala;
  println("x= "+x+", y= "+y+", escala= "+escala);
  
}

//taken from http://processing.org/learning/topics/directorylist.html
File[] listFiles(String dir) {
 File file = new File(dir);
 if (file.isDirectory()) {
   File[] files = file.listFiles();
   return files;
 } else {
   // If it's not a directory
   return null;
 }
}
