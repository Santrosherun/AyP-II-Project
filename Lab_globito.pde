
int xpos = 0, ypos = 0, speed = 10;
int sizex = 1800, sizey = 900;
int loon_size = 150;
boolean derecha = false, abajo = false;
boolean izquierda = false, arriba = false;

PImage backgroundImage;
PImage[] gif;
int numberOffFrames;
int f;

void setup(){
  size (1800, 900);
  background(0);
  backgroundImage = loadImage("2871269_6846 (1) (1).jpg");
  numberOffFrames = 9;
  gif = new PImage[numberOffFrames];
  int i = 0;
  while (i < numberOffFrames){
    gif[i] = loadImage("frame_"+i+"_delay-0.15s.gif");
    i++;
  }
  
}


void draw(){
  background (backgroundImage);
  image(gif[f], xpos, ypos, 200, 200);   
  frames();
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

void frames(){
  if(frameCount % 3 == 0){
    f++;
  }
  if(f == numberOffFrames){
    f = 0;
  }
  
  
}
