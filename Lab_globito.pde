import processing.video.*;

Movie movie;
int xpos = 0, ypos = 0, speed = 10;
int sizex = 1800, sizey = 900;
int loon_size = 150;
boolean derecha = false, abajo = false;
boolean izquierda = false, arriba = false;

PImage backgroundImage;

void setup(){
  size (1800, 900);
  background(0);
  backgroundImage = loadImage("C:\\Users\\sddva\\OneDrive\\Documentos\\Processing\\sketch_240321a\\data\\2871269_6846 (1) (1).jpg");
  movie = new Movie(this, "C:\\Users\\sddva\\OneDrive\\Documentos\\Processing\\sketch_240321a\\data\\Prueba globito.mp4");
  movie.loop();


}

void movieEvent(Movie m) {
  m.read();
}

void draw(){
  background (backgroundImage);
  
  if (movie.available() == true) {
    movie.read(); 
  }
  image(movie, xpos, ypos, 150, 200);
  
  movement();
  moveRect();
  
  
}

void keyPressed(){
  if(keyCode == LEFT) {
    izquierda = true;
  } 
  if(keyCode == RIGHT) {
    derecha = true;
  } 
  if(keyCode == UP) {
    arriba = true;
  } 
  if(keyCode == DOWN) {
    abajo = true;
  }
  
  
}

void keyReleased() {
  if(keyCode == LEFT) {
    izquierda = false;
  } 
  if(keyCode == RIGHT) {
    derecha = false;
  }
  if(keyCode == UP) {
    arriba = false;
  } 
  if(keyCode == DOWN) {
    abajo = false;
  }
  
  
}

void movement(){
  if(izquierda) {
    xpos -= speed;
  }
  if(derecha) {
    xpos += speed;
  }
  if(arriba) {
    ypos -= speed;
  }
  if(abajo) {
    ypos += speed;
  }
  
  
}

void moveRect(){
  xpos = constrain(xpos, 0, sizex-loon_size);
  ypos = constrain(ypos, 0, sizey-loon_size);
  
  
}
