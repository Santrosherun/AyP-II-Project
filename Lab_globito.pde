Platform plat; 
Enemies enemy;
Projectile proj;
Colissions coli;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

int white = 255, black = 0;  
int hover = black;

float gravity = 1.2, jumpForce = -10, Y_velocity = 0;
boolean spacePressed = false;
int jumpHoldTime = 0;
int maxJumpHoldTime = 10; 
int maxJumpForce = -20; 
boolean isJumping = false;
float realColissionBoxMult = 0.2;
int mode = 0;

float xpos = 0, ypos = 0;
float speed = 10;
int sizex = 1800, sizey = 900;
int loon_size = 200;
float volume = 0;
boolean derecha = false;
boolean izquierda = false;

PImage backgroundImage_game, backgroundImage_menu, resume_options, settings_options, play_options;
PImage[] gif;
PImage[] gif1;
int numberOffFrames_loon, numberOffFrames_tittle;
int f;
int i = 0;
int p;
int e;
int c;

Minim minim;
AudioPlayer song;


Colissions playerColision;
Colissions[] enemyColisions;
Platform[] platforms;
Enemies[] enemies;

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
  
  platforms = new Platform[3];
  platforms[1] = new Platform(300, height - 200, 200, 20, 255);
  platforms[2] = new Platform(700, height - 300, 150, 20, 255);
  
  
  enemies = new Enemies[2];
  enemies[1] = new Enemies(900, height-400, 300, 5);
  
  playerColision = new Colissions(xpos, ypos, loon_size * realColissionBoxMult, loon_size * realColissionBoxMult);
  enemyColisions = new Colissions[enemies.length + 1];
  for (c = 1; c < enemies.length; c++) {
    enemyColisions[c] = new Colissions(enemies[c].x, enemies[c].y, enemies[c].enemy_size * realColissionBoxMult, enemies[c].enemy_size * realColissionBoxMult);
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
     
  } else if (mode == 2) {
    if(mouseX > 775 && mouseX < 1025 && mouseY > 300 && mouseY < 400){
      mode = 1;
    }
    if (mouseX > 775 && mouseX < 1075 && mouseY > 450 && mouseY < 470 && mousePressed) {
      volume = map(mouseX, 775, 1075, -50, 50);
      volume = constrain(volume, -50, 50); 
      song.setGain(volume); 
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
    image(gif[f], xpos, ypos, loon_size, loon_size);   
    frames_loon();
    movement();
    applyJumpForce();
    applyGravity();
    moveRect();
    
    for (p = 1; p < platforms.length; p++) {
      Platform plat = platforms[p];
      plat.drawPlatform();
       
      if (ypos + 200 >= plat.getY() && ypos + 200 <= plat.getY() + plat.getHeight() && xpos + 150 >= plat.getX() && xpos <= plat.getX() + plat.getWidth()) {
          ypos = plat.getY() - 200; 
          Y_velocity = 0; 
          isJumping = false; 
      }
    }
    
    playerColision.x = xpos + 85;
    playerColision.y = ypos + 70;
    for (e = 1; e < enemies.length; e++) {
      Enemies enemy = enemies[e];
      enemy.display_enemy();
      enemy.move();
      enemyColisions[e].x = enemy.x + 125;
      enemyColisions[e].y = enemy.y + 120;
      if (playerColision.intersect(enemyColisions[e])) {
        text("¡Colisión con enemigo!", 100, 100);
      }
    }
    
    
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
  rect(775, 450, 300, 20); 
  fill(0, 255, 0);
  rect(775, 450, map(volume, -50, 50, 0, 300), 20); 
}

void keyPressed(){
  if(keyCode == LEFT) {
    izquierda = true;
  } 
  if(keyCode == RIGHT) {
    derecha = true;
  }
  if(key == ' ' && Y_velocity == 0) { 
    spacePressed = true;
    isJumping = true; 
    jumpHoldTime = 0;
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
  if (key == ' ') {
    spacePressed = false;
  }
  
  
}

void movement(){
  if(izquierda) {
    xpos -= speed;
  }
  if(derecha) {
    xpos += speed;
  }
  
  
}

void moveRect(){
  xpos = constrain(xpos, 0, sizex-loon_size);
  ypos = constrain(ypos, 0, sizey-loon_size-100);
  if (ypos >= sizey - loon_size-100) {
        ypos = sizey - loon_size-100; 
        Y_velocity = 0; 
        isJumping = false; 
    }
  
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

void applyJumpForce() {
  if (isJumping) {
    Y_velocity = jumpForce;
    isJumping = false;
  } else if (spacePressed && jumpHoldTime < maxJumpHoldTime) {
    jumpHoldTime++;
    Y_velocity = map(jumpHoldTime, 0, maxJumpHoldTime, jumpForce, maxJumpForce);
  }
}

void applyGravity(){
  if (!isJumping && ypos >= sizey - loon_size) { 
        isJumping = false; 
        Y_velocity = 0; 
    } else {
        Y_velocity += gravity; 
    }
    ypos += Y_velocity; 
}
