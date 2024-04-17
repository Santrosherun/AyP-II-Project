
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

int white = 255, black = 0;  
int hover = black;

int mode = 0;

int xpos = 0, ypos = 0, speed = 10;
int sizex = 1800, sizey = 900;
int loon_size = 150;
float volume = 10;
boolean derecha = false, abajo = false;
boolean izquierda = false, arriba = false;

PImage backgroundImage_game, backgroundImage_menu, resume_options, settings_options, play_options;
PImage[] gif;
PImage[] gif1;
int numberOffFrames_loon, numberOffFrames_tittle;
int f;
int i = 0;

Minim minim;
AudioPlayer song;

void setup(){
  minim = new Minim(this);
  song = minim.loadFile("song.mp3");
  size (1800, 900);
  
  backgroundImage_menu = loadImage("menu2.jpeg");
  backgroundImage_game = loadImage("2871269_6846 (1) (1).jpg");
  resume_options = loadImage("pause.png");
  play_options = loadImage("play.png");
  
  numberOffFrames_loon = 9;
  gif = new PImage[numberOffFrames_loon];
  
  while (i < numberOffFrames_loon){
    gif[i] = loadImage("frame_"+i+"_delay-0.15s.gif");
    i++;
  }
  i = 0;
  numberOffFrames_tittle = 25;
  gif1 = new PImage[numberOffFrames_tittle];
  
  while(i < numberOffFrames_tittle){
    gif1[i] = loadImage("frame_"+i+"_delay-0.04s.gif");
    i++;
  }
  
  
}


void draw(){
  song.play();
  switch(mode){
    case 0:
      drawMainMenu(); 
      break;
    case 1:
      drawGame();
      break;
    case 2:
      drawOptions();
      break;
     default:
       println("No deberias ver esto");
       break;
  }
  
  
}
void mousePressed() {
  // Detecta clics del mouse y realiza acciones según el estado del juego
  if (mode == 0) {
    if(mouseX > 45 && mouseX < 345 && mouseY > 500 && mouseY < 600){
      mode = 1;
      f=0;
    }
  } else if (mode == 1) {
    // Lógica del juego
  } else if (mode == 2) {
    if(mouseX > 775 && mouseX < 1025 && mouseY > 300 && mouseY < 400){
      mode = 1;
    }
    if (mouseX > 775 && mouseX < 1075 && mouseY > 450 && mouseY < 470 && mousePressed) {
      volume = map(mouseX, 775, 1075, -50, 50); // Mapea la posición del mouse al volumen
      volume = constrain(volume, -50, 50); // Asegura que el volumen esté dentro del rango permitido
      song.setGain(volume); // Ajusta el volumen de la música
    }
    if(volume < -45){
      song.mute();
    }else{
      song.unmute();
    }
    
  }
  
}


void drawMainMenu(){
  background(backgroundImage_menu);
  image(gif1[f], 700, 0, 800, 400);
  frames_tittle();
  
  fill(250);
  textSize(100);
  text("Menú Principal", 70, 475);  
  fill(hover);
  if(mouseX > 45 && mouseX < 345 && mouseY > 500 && mouseY < 600){
    stroke(white);
    strokeWeight(5);
  } else {
    stroke(black);
    strokeWeight(5);
  }
  rect(45, 500, 300, 100);
  fill(255);
  text("Jugar", 70, 575);
  
  
  fill(255);
  text("Opciones", 70, 675);
}

void drawGame(){
    background (backgroundImage_game);
    image(gif[f], xpos, ypos, 200, 200);   
    frames_loon();
    movement();
    moveRect();
}


void drawOptions(){
  background(#3a86ff);
  fill(0, 150);
  rect(0, 0, width, height);
  fill(255);
  rect(width/4, height/4, width/2, height/2);
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Menú de Opciones", width/2, height/4 + 30);
  textSize(26);
  image(resume_options, 400, 200, 120,100);
  image(play_options, 775, 300, 250, 100);
  fill(#ff0a54);
  rect(775, 450, 300, 20); // Barra
  fill(0, 255, 0);
  rect(775, 450, map(volume, -50, 50, 0, 300), 20); // Indicador de volumen
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
  if(mode == 1 && keyCode == TAB){
     mode = 2;
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

void frames_loon(){
  if(frameCount % 3 == 0){
    f++;
  }
  if(f == numberOffFrames_loon){
    f = 0;
  }
  
  
}
void frames_tittle(){
  if(frameCount % 3 == 0){
    f++;
  }
  if(f == numberOffFrames_tittle){
    f = 0;
  }
  
  
}
