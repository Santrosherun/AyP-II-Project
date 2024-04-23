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
float speed = 5;
int sizex = 1800, sizey = 900;
int loon_size = 200;
float volume = 0;
boolean derecha = false;
boolean izquierda = false;
int playerHealth = 3, maxPlayerHealth = 3, heartWidth = 200;
boolean isVulnereable = true, show_loon = true, show_deadloon = false;
int vulnerableStartTime, vulnerableMaxDuration = 2000;

PImage backgroundImage_game, backgroundImage_menu, resume_options, settings_options, play_options;
PImage[] gif;
PImage[] gif1;
PImage[] gifdead_loon;
PImage heartFull, hearthit, heart2hit, heartEmpty;

int numberOffFrames_loon, numberOffFrames_tittle, numberOffFrames_deadloon; 
int f;
int i = 0;
int p;
int e;
int c;
int im;

float backgroundX = 0;
int startTime, elapsedTime, minutes, seconds, milliseconds, timePast, timePause;
boolean isPaused = false;  

Minim minim;
AudioPlayer song;
AudioPlayer dead_sound;

Colissions playerColision;
Colissions[] enemyColisions;
Platform[] platforms;
Enemies[] enemies;

void setup(){
  minim = new Minim(this);
  song = minim.loadFile("song.mp3");
  dead_sound = minim.loadFile("dead_sound.mp3");
  size (1800, 900);
  
  backgroundImage_menu = loadImage("menu2.jpeg");
  backgroundImage_game = loadImage("prueba_fondo.png");
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
  i = 0;
  numberOffFrames_deadloon = 8;
  gifdead_loon = new PImage[numberOffFrames_deadloon];
  
  while(i < numberOffFrames_deadloon){
    gifdead_loon[i] = loadImage("deadloon_"+i+".png");
    i++;
  }
  
  
  heartFull = loadImage("heart(full).png");
  hearthit = loadImage("heart(hit).png");
  heart2hit = loadImage("heart(2hit).png");
  heartEmpty = loadImage("heart(empty).png");
  
  platforms = new Platform[3];
  platforms[1] = new Platform(300, height - 200, 200, 20, 255);
  platforms[2] = new Platform(700, height - 300, 150, 20, 255);
  
  
  enemies = new Enemies[3];
  enemies[1] = new Enemies(900, height-400, 300, 5, 0, 1800);
  enemies[2] = new Enemies(1900, height-400, 300, 5, 1800, 3200);
  
  playerColision = new Colissions(xpos, ypos, loon_size * realColissionBoxMult, loon_size * realColissionBoxMult);
  enemyColisions = new Colissions[enemies.length + 1];
  for (c = 1; c < enemies.length; c++) {
    enemyColisions[c] = new Colissions(enemies[c].x, enemies[c].y, enemies[c].enemy_size * realColissionBoxMult, enemies[c].enemy_size * realColissionBoxMult);
  }
}


void draw(){
  //song.play();
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
    case 3:
      drawFailScreen();
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
      startTime = millis();
      f=0;
    }
  } else if (mode == 1) {
     
  } else if (mode == 2) {
    if(mouseX > 775 && mouseX < 1025 && mouseY > 300 && mouseY < 400){
      isPaused = !isPaused;
      startTime = timePause - timePast; // Se le resta el tiempo en pausa al tiempo total 
      mode = 1;
    }
    if (mouseX > 775 && mouseX < 1075 && mouseY > 450 && mouseY < 490 && mousePressed) {
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
    if(!isPaused){
      timePast = millis() - startTime; 
    }
    minutes = int(timePast / (1000 * 60));
    seconds = int((timePast / 1000) % 60);
    milliseconds = timePast % 1000; 
    image(backgroundImage_game, backgroundX, 0);
    moveBackground();
    fill(255);
    textSize(50);
    text(nf(minutes, 2) + ":" + nf(seconds, 2) + ":" + nf(milliseconds, 3), width - 260, 70); // nf() se utiliza para formatear los números y asegurarse de que tengan el número adecuado de dígitos
    if(show_loon){
      image(gif[f], xpos, ypos, loon_size, loon_size);   
    frames_loon();
    }
    if(show_deadloon){
      image(gifdead_loon[f], xpos, ypos, loon_size, loon_size);
      frames_deadloon();
    }
    movement();
    applyJumpForce();
    applyGravity();
    moveRect();
    
    if (maxPlayerHealth == playerHealth){
      image (heartFull, 0, -30, 200, 200);
    } else if (playerHealth == 2){
      image(hearthit, 0, -30, 200, 200);
    } else if (playerHealth == 1){
      image(heart2hit, 0, -30, 200, 200);
    } else {
      image(heartEmpty, 0, -30, 200, 200);
      mode = 3;
    }
       
    for (p = 1; p < platforms.length; p++) {
      Platform plat = platforms[p];
      plat.drawPlatform();
       
      if (ypos + loon_size >= plat.getY() && ypos + loon_size <= plat.getY() + plat.getHeight() && xpos - backgroundX + 100 >= plat.getX() && xpos - backgroundX + 90 <= plat.getX() + plat.getWidth()) {
          ypos = plat.getY() - 200; 
          Y_velocity = 0; 
          isJumping = false; 
      }
    }
    
    if (proj == null) {
        // Crea el proyectil en la posición inicial y con la velocidad adecuada
        proj = new Projectile(1000, 0, 10, 10, 70);
    }
    
    playerColision.x = xpos + 85;
    playerColision.y = ypos + 70;
     
    for (e = 1; e < enemies.length; e++) {
      Enemies enemy = enemies[e];
      enemy.display_enemy();
      enemy.move();
      enemy.shootProjectile(); // Lanza el proyectil
      enemy.moveProjectile(); // Mueve el proyectil
      enemy.displayProjectile(); // Muestra el proyectil
      enemyColisions[e].x = enemy.x + backgroundX + 125;
      enemyColisions[e].y = enemy.y + 120;
      
      if (playerColision.intersect(enemyColisions[e]) && isVulnereable) {
        playerHealth = playerHealth - 1;
        show_loon = false;
        show_deadloon = true;
        dead_sound.unmute();
        isVulnereable = false;
        vulnerableStartTime = millis();
        f = 0;
        dead_sound.play();
      }
    }
    if (!isVulnereable && millis() - vulnerableStartTime >= vulnerableMaxDuration) {
      show_loon = true;
      show_deadloon = false;
      dead_sound.rewind();
      isVulnereable = true;
  }

    
}


void drawOptions(){
  timePause = millis();
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
  rect(775, 450, 300, 40); 
  fill(0, 255, 0);
  rect(775, 450, map(volume, -50, 50, 0, 300), 40); 
}

void drawFailScreen(){
  
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
     isPaused = !isPaused;
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

void frames_deadloon(){
  if(frameCount % 18 == 0){
    f++;
  }
  if(f == numberOffFrames_deadloon){
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

void moveBackground() {

    if (derecha) {
        backgroundX -= speed * 2;
    } else if (izquierda) {
        backgroundX += speed * 2;
    }
    backgroundX = constrain(backgroundX, -(backgroundImage_game.width - width), 0);
    image(backgroundImage_game, backgroundX, 0);
    
}
