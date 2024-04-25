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

PImage backgroundImage_game, backgroundImage_menu, optionsMainMenu, optionsSelector, optionTitle, howToPlay, htpLeft, htpRight, htpJump, htpCollect,
htpPause, htpVolume, pauseQuitGame, goBack, resume_options, settings_options, play_options;
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
int co , numeroDeMonedas = 13, coinCounter = 0;
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
Coin[] coins;

void setup(){
  minim = new Minim(this);
  song = minim.loadFile("song.mp3");
  dead_sound = minim.loadFile("dead_sound.mp3");
  size (1800, 900);
  
  backgroundImage_menu = loadImage("Main_menu.png");
  backgroundImage_game = loadImage("Fondo.png");
  resume_options = loadImage("pause.png");
  play_options = loadImage("play.png");
  optionsMainMenu = loadImage("Main_menuOptions.png");
  optionsSelector = loadImage("selector.png");
  optionTitle = loadImage("optionsTitle.png");
  howToPlay = loadImage("howToPlay.png");
  goBack = loadImage("goback.png");
  htpLeft = loadImage("htpMoveLeft.png");
  htpRight = loadImage("htpMoveRight.png");
  htpJump = loadImage("htpJump.png");
  htpCollect = loadImage("htpCollectHelium.png");
  htpPause = loadImage("htpPause.png");
  htpVolume = loadImage("htpVolume.png");
  pauseQuitGame = loadImage("quitGame.png");
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
  coins = new Coin[numeroDeMonedas];
  for (co = 1; co < numeroDeMonedas; co++) {
        float x = random(200, 8000);
        float y = random(500, 700);
        coins[co] = new Coin(x, y, 100, 100);
    }
}


void draw(){
  song.play();
  println("X"+mouseX + "Y"+mouseY);
  switch(mode){
    case 0:
      drawMainMenu(); 
      break;
    case 1:
      drawGame();
      break;
    case 2:
      drawPause();
      break;
    case 3:
      drawFailScreen();
      break;
    case 4:
      drawOptions();
      break;
    case 5:
      drawHowToPlay();
      break;
     default:
       println("No deberias ver esto");
       break;
  }
  
  
}
void mousePressed() {
  // Detecta clics del mouse y realiza acciones según el estado del juego
  if (mode == 0) {
    if(mouseX > 85 && mouseX < 405 && mouseY > 380 && mouseY < 490){
      mode = 1;
      startTime = millis();
      f=0;
    }
    if(mouseX > 85 && mouseX < 630 && mouseY > 545 && mouseY < 650){
      mode = 4;
    }
  } else if (mode == 1) {
     
  } else if (mode == 2) {
    if(mouseX > 1320 && mouseX < 1780 && mouseY > 0 && mouseY < 100){
      isPaused = !isPaused;
      startTime = timePause - timePast; // Se le resta el tiempo en pausa al tiempo total 
      mode = 1;
    }
    if (mouseX > 750 && mouseX < 1050 && mouseY > 450 && mouseY < 490 && mousePressed) {
      volume = map(mouseX, 750, 1050, -50, 50);
      volume = constrain(volume, -50, 50); 
      song.setGain(volume); 
    }
    if (mouseX > 715 && mouseX < 1080 && mouseY > 725 && mouseY < 820 && mousePressed) {
      resetGame();
      mode = 0;
    }
    if(volume < -45){
      song.mute();
    }else{
      song.unmute();
    }
    
  } else if (mode == 4) {
    if(mouseX > 630 && mouseX < 1170 && mouseY > 720 && mouseY < 845){
      mode = 0;
    }
    if(mouseX > 440 && mouseX < 1360 && mouseY > 415 && mouseY < 590){
      mode = 5;
    }
  } else if (mode == 5) {
    if(mouseX > 1320 && mouseX < 1780 && mouseY > 0 && mouseY < 100){
      mode = 4;
    }
  }
  
}


void drawMainMenu(){
  background(backgroundImage_menu);
  image(gif1[f], 100, 0, 1600, 400);
  frames_tittle();
  image(gif[1], 1100, 250, 500, 600);
  image(optionsMainMenu, 60, 350, 600, 500);
  
  if(mouseX > 85 && mouseX < 405 && mouseY > 380 && mouseY < 490){
    image(optionsSelector, 400, 365, 250 ,150);
  }
  if(mouseX > 85 && mouseX < 630 && mouseY > 545 && mouseY < 650){
    image(optionsSelector, 630, 525, 250 ,150);
  }
  if(mouseX > 85 && mouseX < 625 && mouseY > 705 && mouseY < 820){
    image(optionsSelector, 630, 685, 250 ,150);
  }
  
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
       
    for (co = 1; co < coins.length; co++) {
        Coin coin = coins[co];
        if (!coin.isCollected) {
            coin.drawCoin(); // Dibujar la moneda si no ha sido recolectada
        }        
    }
    if (keyPressed && keyCode == UP) {
      for (co = 1; co < coins.length; co++) {
          Coin coin = coins[co];
          if (!coin.isCollected && coin.checkCollision(xpos, ypos, loon_size * 0.4)) {
              // Se ha detectado una colisión con la moneda, recolectarla
              coin.isCollected = true;
              // Incrementar el contador de monedas recolectadas
              coinCounter = coinCounter + 1;
          }
      }
    }
    fill(255);
    textSize(35);
    text("Monedas: " + coinCounter, 250, 70);
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
  background(backgroundImage_menu);
  image(optionTitle, 300, 60, 1200, 250);
  image(howToPlay, 400, 350, 1000, 300);
  if(mouseX > 440 && mouseX < 1360 && mouseY > 415 && mouseY < 590){
    image(optionsSelector, 1360, 420, 250 ,150);
  }
  image(goBack, 600, 680, 600, 200);
  if(mouseX > 630 && mouseX < 1170 && mouseY > 720 && mouseY < 845){
    image(optionsSelector, 1180, 700, 250 ,150);
  }
}


void drawPause(){
  timePause = millis();
  background(backgroundImage_menu);
  
  fill(0, 150);
  rect(0, 0, width, height); // Blur baclground image
  
  image(goBack, 1300, 0, 500, 100);
  image(htpPause, 600, 50, 600, 200);
  image(htpVolume, 700, 300, 400, 150);
  
  fill(#ff0a54);
  rect(750, 450, 300, 40); 
  fill(0, 255, 0);
  rect(750, 450, map(volume, -50, 50, 0, 300), 40); 

  image(pauseQuitGame, 700, 700, 400, 150);
  //image(resume_options, 400, 200, 120,100);
  //image(play_options, 775, 300, 250, 100);

}

void resetGame() {
  xpos = 0;
  ypos = 0;
  backgroundX = 0;
  speed = 5;
  Y_velocity = 0;
  playerHealth = maxPlayerHealth;
  startTime = millis();
  isPaused = !isPaused;
  
  for (int co = 1; co < numeroDeMonedas; co++) {
    float x = random(200, 1800);
    float y = random(500, 700);
    coins[co] = new Coin(x, y, 100, 100);
  }
  
  coinCounter = 0;
  
}

void drawHowToPlay() {
  background(backgroundImage_menu);
  image(howToPlay, 370, 40, 1100, 300);
  image(goBack, 1300, 0, 500, 100);
  image(htpCollect, 500, 300, 800, 150);
  image(htpLeft, 100, 500, 400, 150);
  image(htpRight, 1300, 490, 400, 150);
  image(htpJump, 400, 750, 400, 150);
  image(htpPause, 1000, 750, 400, 150);

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
  if(frameCount % 2 == 0){
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
