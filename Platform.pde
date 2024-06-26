// SKETCH PRINCIPAL

Platform plat;  
Enemies enemy;
Projectile proj;
Colissions coli;
FanEnemy fan;
SpecialCoin sCoin;
Shield shields;

// ^^^ Importando todas las clases en archivos a parte ^^^

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// ^^^ Importando la librería minim (Audio y música) ^^^

import processing.video.*;

int nofill = #00FF0000; // Color transparente

float gravity = 1.2, jumpForce = -10, Y_velocity = 0;
boolean spacePressed = false;
int jumpHoldTime = 0;
int maxJumpHoldTime = 10; 
int maxJumpForce = -20; 
boolean isJumping = false;
// ^^^ VELOCIDAD DE SALTO y GRAVEDAD ^^^
float realColissionBoxMult = 0.2;
int mode = 0; // Controla el modo de juego actual

float xpos = 0, ypos = 0;
float speed = 8;
// ^^^ Posición actual del jugador y velocidad ^^^
int sizex = 1800, sizey = 900; // Tamaño del lienzo
int loon_size = 200; // Tamaño del globo
float volume = 0; // Aumento de la ganancia del volumen

boolean derecha = false;
boolean izquierda = false;
// ^^^ Control de movimiento lateral ^^^
int playerHealth = 3, maxPlayerHealth = 3, heartWidth = 200;
boolean isVulnereable = true, show_loon = true, show_deadloon = false;
int vulnerableStartTime, vulnerableMaxDuration = 2000;
// ^^^ Control de cantiadad máxima de vida, tamaño de la imagen de los corazones, estado de vulnearabilidad y duración del mismo ^^^

int difficulty = 1; // Dificultad actual del videojuego

PImage backgroundImage_game, backgroundImage_menu, optionsMainMenu, optionsSelector, optionTitle, howToPlay, htpLeft, htpRight, htpJump, htpCollect,
htpPause, htpVolume, pauseQuitGame, goBack, gameOver, betterLNT, retryImage, difficultyTitle, difficultEasy, difficultNormal, difficultHard, arrowsImage, resume_options, settings_options,
play_options, statsImage, retryWinImage, exitImage, congratulationImage, endDecoration, moveRight, moveDown, moveLeft, moveUp, spaceBar, tabButton, shieldImage, winBackground, projectileImage;
// ^^^ Todas las imagenes usadas ^^^

PImage[] gif;
PImage[] gif1;
PImage[] gifdead_loon;
PImage[] gifwind;
// ^^^ Creación de los arreglos que controlarán los gifs ^^^

PImage heartFull, hearthit, heart2hit, heartEmpty;
PImage fanLeftImage, fanRightImage;
PImage specialCoin, specialCoin_noCollected;
// ^^^ Monedas y corazones ^^^

int numberOffFrames_loon, numberOffFrames_tittle, numberOffFrames_deadloon, numberOffFrames_Wind; // Controladores del frame actual de los gifs

int f;
int i = 0;
int p;
int e;
int c;
int co , numeroDeMonedas = 51, coinCounter = 0, tShield; // Contador de monedas, monedas totales y cantidad de escudos
int im;
int w;
int fa;
int sc;
// ^^^ Contadores ^^^

float backgroundX = 0; // Controla el movimiento del fondo, crea la ilusión de movimiento

int startTime, elapsedTime, minutes, seconds, milliseconds, timePast, timePause;
int increaseTime = 15, increaseTime_m = 15000, lastIncreaseTime; 
boolean isRed = false;
boolean isPaused = false; 
// ^^^ Control del temporizador ^^^
boolean speedIncreased = false; // Incremento de la velocidad
boolean pressedDif = false, playingVideo = false;

int jumpNumber = 0;
float speedStat = speed;

Minim minim;
AudioPlayer song;
AudioPlayer dead_sound;
AudioPlayer jumping_sound;
AudioPlayer normalCoin;
AudioPlayer special_Coin;
AudioPlayer windSound;
AudioPlayer vidaExtra;
AudioPlayer gameOverSound;
AudioPlayer powerUp;
AudioPlayer winSound;
// ^^^ Declarando variables de sonido ^^^

Movie credits;

Colissions playerColision;
Colissions[] enemyColisions;
Platform[] platforms;
Enemies[] enemies;
Coin[] coins;
FanEnemy[] fanenemies;
SpecialCoin[] specialCoins;
// ^^^ Instanciando objetos ^^^

void setup(){
  minim = new Minim(this); // Instanciando Minim
  song = minim.loadFile("song.mp3");
  dead_sound = minim.loadFile("dead_sound.mp3");
  jumping_sound = minim.loadFile("jumping sound.mp3");
  normalCoin = minim.loadFile("normal_coin_sound.mp3");
  special_Coin = minim.loadFile("specialCoinSound.mp3");
  windSound = minim.loadFile("windSound.mp3");
  vidaExtra = minim.loadFile("vidaExtra.mp3");
  gameOverSound = minim.loadFile("gameOverSound.mp3");
  powerUp = minim.loadFile("powerUp.mp3");
  winSound = minim.loadFile("winSound.mp3");
  
  credits = new Movie(this, "creditsVideo.mp4");
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
  htpJump = loadImage("holdJump.png");
  htpCollect = loadImage("htpCollectHelium.png");
  htpPause = loadImage("htpPause.png");
  htpVolume = loadImage("htpVolume.png");
  pauseQuitGame = loadImage("quitGame.png");
  gameOver = loadImage("gameOver.png");
  betterLNT = loadImage("betterLNT.png");
  retryImage = loadImage("retry.png");
  arrowsImage = loadImage("arrows.png");
  fanLeftImage = loadImage("fan_Left.png");
  fanRightImage = loadImage("fan_Right.png");
  specialCoin = loadImage("specialCoin.png");
  specialCoin_noCollected = loadImage("specialCoin_noCollected.png");
  difficultyTitle =loadImage("diffiultyTitle.png");
  difficultEasy = loadImage("difficultyEasy.png");
  difficultNormal = loadImage("difficultyNormal.png");
  difficultHard = loadImage("difficultyDifficult.png");
  winBackground = loadImage("winbackground.jpg");
  statsImage = loadImage("statsImage.png");
  retryWinImage = loadImage("retryImage.png");
  exitImage = loadImage("exitImage.png");
  projectileImage = loadImage("spike_projectile.png");
  congratulationImage = loadImage("congratulationImage.png");
  endDecoration = loadImage("endDecoration.png");
  moveRight = loadImage("moveRight.png");
  moveLeft = loadImage("moveLeft.png");
  moveUp = loadImage("moveUp.png");
  moveDown = loadImage("moveDown.png");
  spaceBar = loadImage("spaceBar.png");
  tabButton = loadImage("tabButton.png");
  shieldImage = loadImage("shield.png");
  
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
  i = 0;
  numberOffFrames_Wind = 2;
  gifwind = new PImage[numberOffFrames_Wind];
  
  while(i < numberOffFrames_Wind){
    gifwind[i] = loadImage("wind_"+i+".png");
    i++;
  }
  
  
  heartFull = loadImage("heart(full).png");
  hearthit = loadImage("heart(hit).png");
  heart2hit = loadImage("heart(2hit).png");
  heartEmpty = loadImage("heart(empty).png");
  
  platforms = new Platform[61];
  platforms[1] = new Platform(390, height - 300, 250, 20, nofill);
  platforms[2] = new Platform(716, height - 390, 158, 20, nofill);
  platforms[3] = new Platform(1016, height - 300, 80, 20, nofill);
  platforms[4] = new Platform(1955, height - 270, 80, 20, nofill);
  platforms[5] = new Platform(2063, height - 365, 80, 20, nofill);
  platforms[6] = new Platform(2177, height - 440, 80, 20, nofill);
  platforms[7] = new Platform(2291, height - 508, 80, 20, nofill);
  platforms[8] = new Platform(2521, height - 304, 245, 20, nofill);
  platforms[9] = new Platform(3903, height - 270, 80, 20, nofill);
  platforms[10] = new Platform(4123, height - 400, 408, 20, nofill);
  platforms[11] = new Platform(4641, height - 270, 80, 20, nofill);
  platforms[12] = new Platform(6430, height - 346, 240, 20, nofill);
  platforms[13] = new Platform(6783, height - 460, 80, 20, nofill);
  platforms[14] = new Platform(6955, height - 347, 80, 20, nofill);
  platforms[15] = new Platform(7095, height - 257, 80, 20, nofill);
  platforms[16] = new Platform(8255, height - 350, 80, 20, nofill);
  platforms[17] = new Platform(8724, height - 350, 80, 20, nofill);
  platforms[18] = new Platform(10011, height - 330, 80, 20, nofill);
  platforms[19] = new Platform(10194, height - 450, 330, 20, nofill);
  platforms[20] = new Platform(10621, height - 330, 80, 20, nofill);
  platforms[21] = new Platform(12508, height - 330, 80, 20, nofill);
  platforms[22] = new Platform(12687, height - 415, 80, 20, nofill);
  platforms[23] = new Platform(12860, height - 505, 80, 20, nofill);
  platforms[24] = new Platform(13765, height - 350, 80, 20, nofill);
  platforms[25] = new Platform(14322, height - 350, 80, 20, nofill);
  platforms[26] = new Platform(14804, height - 340, 80, 20, nofill);
  platforms[27] = new Platform(14990, height - 450, 330, 20, nofill);
  platforms[28] = new Platform(15415, height - 340, 80, 20, nofill);
  platforms[29] = new Platform(16155, height - 320, 660, 20, nofill);
  platforms[30] = new Platform(18927, height - 340, 80, 20, nofill);
  platforms[31] = new Platform(19055, height - 435, 80, 20, nofill);
  platforms[32] = new Platform(19191, height - 540, 80, 20, nofill);
  platforms[33] = new Platform(19366, height - 445, 80, 20, nofill);
  platforms[34] = new Platform(19533, height - 340, 80, 20, nofill);
  platforms[35] = new Platform(20222, height - 325, 410, 20, nofill);
  platforms[36] = new Platform(20732, height - 445, 80, 20, nofill);
  platforms[37] = new Platform(20894, height - 530, 80, 20, nofill);
  platforms[38] = new Platform(21053, height - 425, 80, 20, nofill);
  platforms[39] = new Platform(21244, height - 400, 80, 20, nofill);
  platforms[40] = new Platform(21419, height - 475, 80, 20, nofill);
  platforms[41] = new Platform(21588, height - 595, 410, 20, nofill);
  platforms[42] = new Platform(24848, height - 355, 155, 20, nofill);
  platforms[43] = new Platform(25170, height - 365, 80, 20, nofill);
  platforms[44] = new Platform(25295, height - 445, 80, 20, nofill);
  platforms[45] = new Platform(25434, height - 330, 80, 20, nofill);
  platforms[46] = new Platform(25631, height - 445, 80, 20, nofill);
  platforms[47] = new Platform(25765, height - 535, 80, 20, nofill);
  platforms[48] = new Platform(25890, height - 610, 320, 20, nofill);
  platforms[49] = new Platform(26236, height - 500, 80, 20, nofill);
  platforms[50] = new Platform(26346, height - 400, 80, 20, nofill);
  platforms[51] = new Platform(26468, height - 300, 80, 20, nofill);
  platforms[52] = new Platform(27560, height - 300, 80, 20, nofill);
  platforms[53] = new Platform(27710, height - 410, 650, 20, nofill);
  platforms[54] = new Platform(28460, height - 365, 80, 20, nofill);
  platforms[55] = new Platform(29417, height - 290, 80, 20, nofill);
  platforms[56] = new Platform(29531, height - 380, 80, 20, nofill);
  platforms[57] = new Platform(29885, height - 380, 80, 20, nofill);
  platforms[58] = new Platform(30185, height - 380, 80, 20, nofill);
  platforms[59] = new Platform(30340, height - 280, 80, 20, nofill);
  platforms[60] = new Platform(211291, height - 330, 80, 20, 255);
  // ^^^ Ubicando todas las plataformas ^^^
  
  enemies = new Enemies[27];
  enemies[1] = new Enemies(2293, 500, 300, 0, 2393, 2393);
  enemies[2] = new Enemies(3800, height-400, 300, speed, 3800, 4504);
  enemies[3] = new Enemies(6667, height-400, 300, 0, 2393, 2393);
  enemies[4] = new Enemies(7900, height-400, 300, 0, 2393, 2393);
  enemies[5] = new Enemies(8375, height-400, 300, 0, 2393, 2393);
  enemies[6] = new Enemies(8843, height-400, 300, 0, 2393, 2393);
  enemies[7] = new Enemies(9922, height-400, 300, speed, 9922, 10490);
  enemies[8] = new Enemies(11506, height-400, 300, 0, 2393, 2393);
  enemies[9] = new Enemies(12667, height-400, 300, 0, 2393, 2393);
  enemies[10] = new Enemies(13938, height-400, 300, 0, 2393, 2393);
  enemies[11] = new Enemies(14710, height-400, 300, speed, 14710, 15281);
  enemies[12] = new Enemies(16310, 330, 300, 0, 2393, 2393);
  enemies[13] = new Enemies(17050, height - 400, 300, speed, 17050, 17994);
  enemies[14] = new Enemies(18010, height - 400, 300, speed, 18010, 18663);
  enemies[15] = new Enemies(20560, height - 400, 300, 0, 2393, 2393);
  enemies[16] = new Enemies(20900, height - 400, 300, 0, 2393, 2393);
  enemies[17] = new Enemies(21270, height - 400, 300, 0, 2393, 2393);
  enemies[18] = new Enemies(21665, height - 400, 300, 0, 2393, 2393);
  enemies[19] = new Enemies(24900, height - 400, 300, 0, 2393, 2393);
  enemies[20] = new Enemies(25530, height - 400, 300, speed, 25530, 26230);
  enemies[21] = new Enemies(27570, height - 400, 300, speed, 27570, 28260);
  enemies[22] = new Enemies(29420, height - 400, 300, 0, 2393, 2393);
  enemies[23] = new Enemies(29640, height - 400, 300, 0, 2393, 2393);
  enemies[24] = new Enemies(29888, height - 400, 300, 0, 2393, 2393);
  enemies[25] = new Enemies(30100, height - 400, 300, 0, 2393, 2393);
  enemies[26] = new Enemies(30760, height - 400, 300, speed, 30760, 31450);
  // ^^^ Ubicando todos los enemigos ^^^
  
  playerColision = new Colissions(xpos, ypos, loon_size * realColissionBoxMult, loon_size * realColissionBoxMult);
  enemyColisions = new Colissions[enemies.length + 1];
  /// ^^^ Instanciando los objetos colisiones ^^^
  
  fanenemies = new FanEnemy[12];
  fanenemies[1] = new FanEnemy(1708, 500, fanLeftImage, fanRightImage, 450, 3, false);
  fanenemies[2] = new FanEnemy(6100, 500, fanLeftImage, fanRightImage, 650, 3, false);
  fanenemies[3] = new FanEnemy(7100, 500, fanLeftImage, fanRightImage, 350, 3, true);
  fanenemies[4] = new FanEnemy(11345, 500, fanLeftImage, fanRightImage, 500, 3, false);
  fanenemies[5] = new FanEnemy(13647, 500, fanLeftImage, fanRightImage, 400, 3, false);
  fanenemies[6] = new FanEnemy(15400, 500, fanLeftImage, fanRightImage, 400, 3, true);
  fanenemies[7] = new FanEnemy(22500, 500, fanLeftImage, fanRightImage, 800, 3, true);
  fanenemies[8] = new FanEnemy(23900, 500, fanLeftImage, fanRightImage, 650, 3, true);
  fanenemies[9] = new FanEnemy(27155, 500, fanLeftImage, fanRightImage, 600, 3, false);
  fanenemies[10] = new FanEnemy(28115, 200, fanLeftImage, fanRightImage, 350, 3, false);
  fanenemies[11] = new FanEnemy(280115, 200, fanLeftImage, fanRightImage, 350, 3, false);
  // ^^^ Ubicando los abanicos ^^^
  
  specialCoins = new SpecialCoin[9];
  specialCoins[1] = new SpecialCoin(4250, 625, 120);
  specialCoins[2] = new SpecialCoin(6590, 620, 120);
  specialCoins[3] = new SpecialCoin(9518, 50, 120);
  specialCoins[4] = new SpecialCoin(15070, 50, 120);
  specialCoins[5] = new SpecialCoin(17385, 75, 120);
  specialCoins[6] = new SpecialCoin(21160, 610, 120);
  specialCoins[7] = new SpecialCoin(25965, 380, 120);
  specialCoins[8] = new SpecialCoin(29875, 60, 120);
  // ^^^ Ubicando monedas especiales ^^^
   
  switch(difficulty){
    case 1:
      tShield = 3;
      break;
    case 2:
      tShield = 2;
      break;
    case 3:
      tShield = 1;
      break;
    default:
      tShield = 3;
      break;
  }
  shields = new Shield(5000);
  // ^^^ Declarando los escudos dependiendo de la dificultad ^^^
   
  for (c = 1; c < enemies.length; c++) {
    enemyColisions[c] = new Colissions(enemies[c].x, enemies[c].y, enemies[c].enemy_size * realColissionBoxMult, enemies[c].enemy_size * realColissionBoxMult);
  }
  // ^^^ Instanciando colisiones ^^^
  
  coins = new Coin[numeroDeMonedas];
  for (co = 1; co < numeroDeMonedas; co++) {
        float x = random(600, 32000);
        float y = random(500, 700);
        coins[co] = new Coin(x, y, 100, 100);
    }
  // ^^^ Instanciando y ubicando monedas ^^^
   
}


void draw(){
  song.play();
  println("X"+mouseX + "Y"+mouseY);
  println("back"+abs(backgroundX));
  println(speed);
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
    case 6:
      drawWinScreen();
      break;
    case 7:
      drawStatistics();
      break;
    case 8:
      drawCredits();
      break;
     default:
       println("No deberias ver esto");
       break;
  }
  
  
}
void mousePressed() {
  // Detecta clics del mouse y realiza acciones según el estado del juego
  if (mode == 0) { // Menu principal
    if(mouseX > 85 && mouseX < 405 && mouseY > 380 && mouseY < 490){ // Jugar
      mode = 1;
      startTime = millis();
      f=0;
    }
    if(mouseX > 85 && mouseX < 630 && mouseY > 545 && mouseY < 650){
      mode = 4;
    }
    if(mouseX > 85 && mouseX < 625 && mouseY > 705 && mouseY < 820){
      mode = 8;
      playingVideo = !playingVideo;
    }
  } else if (mode == 1) { // Juego principal
     
  } else if (mode == 2) { // Menu de pausa
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
      isPaused = !isPaused;
      resetGame();
      mode = 0;
    }
    if(volume < -45){
      song.mute();
    }else{
      song.unmute();
    }
    
  } else if (mode == 4) { // menu de opciones
    if(mouseX > 630 && mouseX < 1170 && mouseY > 720 && mouseY < 845){
      mode = 0;
    }
    if(mouseX > 440 && mouseX < 1360 && mouseY > 215 && mouseY < 390){
      mode = 5;
    }
    if(mouseX > 75 && mouseX < 440 && mouseY > 410 && mouseY < 490){
      pressedDif = !pressedDif;
    }
    if(pressedDif){
      if(mouseX > 75 && mouseX < 290 && mouseY > 495 && mouseY < 600){ // Facil
        image(optionsSelector, 290, 500, 150 ,75);
        difficulty = 1; // Cambio de dificultad
      }else if(mouseX > 75 && mouseX < 310 && mouseY > 580 && mouseY < 655){ // Normal
        image(optionsSelector, 310, 590, 150 ,75);
        difficulty = 2; // Cambio de dificultad
      }else if(mouseX > 75 && mouseX < 320 && mouseY > 670 && mouseY < 745){ // Dificil
        image(optionsSelector, 315, 680, 150 ,75);
        difficulty = 3; // Cambio de dificultad
      }
    } 

  } else if (mode == 5) { // menu How to Play
    if(mouseX > 1320 && mouseX < 1780 && mouseY > 0 && mouseY < 100){
      mode = 4;
    }
  } else if (mode == 3){ // menu fail screen
    if (mouseX > 25 && mouseX < 520 && mouseY > 738 && mouseY < 890){
      resetGame();
      mode = 0;
    }
    if(mouseX > 1320 && mouseX < 1780 && mouseY > 738 && mouseY < 890){
      resetGame();  
      mode = 1;
    }
     
  } else if (mode == 6){ // Pantalla de victoria
    if(mouseX > 215 && mouseX < 675 && mouseY > 275 && mouseY < 420){ // Estadisticas
      mode = 7;
    }
    if(mouseX > 220 && mouseX < 675 && mouseY > 475 && mouseY < 620){ // Volver a jugar
      resetGame();
      mode = 1;
    }
    if(mouseX > 220 && mouseX < 680 && mouseY > 675 && mouseY < 825){ // Salir al menu principal
      resetGame();
      mode = 0;
    }
  } else if(mode == 7){ // Estadisticas
    if(mouseX > 65 && mouseX < 335 && mouseY > 760 && mouseY < 835){ // Volver a jugar
      resetGame();
      mode = 1;
    }
    if(mouseX > 395 && mouseX < 665 && mouseY > 760 && mouseY < 835){ // Salir al menu principal
      resetGame();
      mode = 0;
    }
  } else if(mode == 8){
    if(mouseX > 75 && mouseX < 220 && mouseY > 75 && mouseY < 220){
      credits.pause();
      credits.jump(0);
      playingVideo = !playingVideo;
      mode = 0;
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
      timePast = millis() - startTime; // Empezar a contar el tiempo 
    }
    minutes = int(timePast / (1000 * 60));
    seconds = int((timePast / 1000) % 60);
    milliseconds = timePast % 1000; 
    // ^^^ Dividiendo el tiempo en minutos, segundos y milisegundos ^^^
    image(backgroundImage_game, backgroundX, 0);
    moveBackground(); // Mover el background en el eje X
   
    if (seconds % increaseTime == 0) { // Parpadear cada increaseTime (15000) milisegundos
        isRed = !isRed;
        if (isRed) {
            fill(255, 0, 0);
        } else {
            fill(255); 
        }
    }
    // ^^^ Parpadear en rojo ^^^
    
    if (timePast >= lastIncreaseTime + increaseTime_m && !speedIncreased) { // Verificar que se debe incrementar la velocidad, solo una vez
        speed = speed + 0.5;
        lastIncreaseTime = timePast;
        speedIncreased = true;
        if (speedStat < speed){ // Comprobar cuál fue la velocidad más alta alcanzada
          speedStat = speed;
        }
    } else if (timePast < lastIncreaseTime + increaseTime_m) {
        speedIncreased = false;
    }
    // ^^^ Lógica para incrementar la velocidad ^^^
    
    if (minutes == 1 && seconds >= 40){
      playerHealth = 0;
    }
    // ^^^ Eliminar al jugador si excede el minuto cuarenta ^^^
    
    if(xpos + abs(backgroundX) >= 31950){
      mode = 6;
      winSound.play();
    }
    // ^^^ Darle la victoria al jugador ^^^
    textSize(50);
    text(nf(minutes, 2) + ":" + nf(seconds, 2) + ":" + nf(milliseconds, 3), width - 260, 70); // nf() se utiliza para formatear los números y asegurarse de que tengan el número adecuado de dígitos
    // ^^^ Pintar el temporizador en pantalla formateado a 2 decimales ^^^
    if(show_loon){
      image(gif[f], xpos, ypos, loon_size, loon_size); // Jugador normal
    frames_loon(); // Llevar el conteo de los frames del gif
    }
    if(show_deadloon){
      image(gifdead_loon[f], xpos, ypos, loon_size, loon_size); // Jugador dañado
      frames_deadloon(); // Llevar el conteo de los frames del gif
    }
    movement(); // Movimiento en el eje X
    applyJumpForce(); // Movimiento en el eje Y (Fuerza de salto)
    applyGravity(); // Gravedad para que vuelva al piso
    moveRect(); // Evitar que el jugador exceda los límites de la pantalla
    
    for (fa = 1; fa < fanenemies.length; fa++){
      fanenemies[fa].display();
      fanenemies[fa].applyWindEffect(xpos, ypos);
    }
    // ^^^ Dibujar y accionar abanicos ^^^
    
    switch(difficulty){
    case 1:
      if (coinCounter >= 10 && maxPlayerHealth != playerHealth){
        playerHealth = playerHealth + 1;
        vidaExtra.play();
        vidaExtra.rewind();
        coinCounter = coinCounter - 10;
      }
      break;
    case 2:
      if (coinCounter >= 20 && maxPlayerHealth != playerHealth){
        playerHealth = playerHealth + 1;
        vidaExtra.play();
        vidaExtra.rewind();
        coinCounter = coinCounter - 20;
    }
      break;
    case 3:
      if (coinCounter >= 30 && maxPlayerHealth != playerHealth){
        playerHealth = playerHealth + 1;
        vidaExtra.play();
        vidaExtra.rewind();
        coinCounter = coinCounter - 30;
    }
      break;
    default:
      if (coinCounter >= 10 && maxPlayerHealth != playerHealth){
        playerHealth = playerHealth + 1;
        vidaExtra.play();
        vidaExtra.rewind();
        coinCounter = coinCounter - 10;
    }
      break;
    }
    // ^^^ Crear cantidad de monedas dependiendo de la dificultad ^^^
    
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
    // ^^^ Pintar los corazones en pantalla ^^^
       
    for (co = 1; co < coins.length; co++) {
        Coin coin = coins[co];
        if (!coin.isCollected) {
            coin.drawCoin(); // Dibujar la moneda si no ha sido recolectada
        }        
    }
    if (keyPressed && keyCode == UP) {
      for (co = 1; co < coins.length; co++) {
          Coin coin = coins[co]; // Creación de las monedas
          if (!coin.isCollected && coin.checkCollision(xpos, ypos, loon_size * 0.4)) { // Se ha detectado una colisión con la moneda
              coin.isCollected = true; // No pintar la moneda
              coinCounter = coinCounter + 1; // Incrementar el contador de monedas recolectadas
              normalCoin.play(); // Sonido de recoleccion
              normalCoin.rewind();
          }
      }
    }
    fill(255);
    textSize(35);
    text("Monedas: " + coinCounter, 250, 70);
    // ^^^ Pintar la cantidad de monedas en pantalla ^^^
    
    for (p = 1; p < platforms.length; p++) {
      Platform plat = platforms[p]; // Creación de las plataformas
      plat.drawPlatform(); // Pintar las plataformas
       
      if (ypos + loon_size >= plat.getY() && ypos + loon_size - 10 <= plat.getY() + plat.getHeight() && xpos - backgroundX + 100 >= plat.getX() && xpos - backgroundX + 90 <= plat.getX() + plat.getWidth()) {
          ypos = plat.getY() - loon_size; 
          Y_velocity = 0; 
          isJumping = false; 
      }
    }
    // ^^^ Detectando la colisión sobre la plataforma ^^^
    
    if (proj == null) {
        // Crea el proyectil en la posición inicial y con la velocidad adecuada
        proj = new Projectile(1000, 0, 10, 10, 70);
    }
    
     for (sc = 1; sc < specialCoins.length; sc++) {
        specialCoins[sc].display(); // Pintando las monedas especiales
        if (specialCoins[sc].checkCollision(playerColision)) { // Detectando la colisión con las monedas especiales
            specialCoins[sc].collected = true; // Se ha detectado la colisión
            special_Coin.play(); // Sonido de recolección
            special_Coin.rewind();
        }
     }
     // ^^^ Creación de las monedas especiales ^^^
     
    if (shields.isActivated()) {
      shields.drawShield(xpos, ypos);
    }
    // ^^^ Pintando el escudo si está activo ^^^
    
    playerColision.x = xpos + 85;
    playerColision.y = ypos + 70;
    // ^^^ Actualizando la caja de colisiones del jugador ^^^
    
    float playerPosition = xpos - backgroundX; // Posición del jugador relativa al fondo

    for (e = 1; e < enemies.length; e++) {
      Enemies enemy = enemies[e]; // Creación de los enemigos
      float distanceToPlayer = abs(playerPosition - enemy.x); // Calculando la distancia del jugador a los enemigos
      if (distanceToPlayer < 2000) { // Distancia relativa de 2000 pixeles
        enemy.display_enemy(); // Dibujar enemigo
        enemy.move(); // Mover al enemigo tanto en X como los saltos en Y
        enemy.shootProjectile(); // Lanza el proyectil
        enemy.moveProjectile(); // Mueve el proyectil
        enemy.displayProjectile(); // Muestra el proyectil
        // ^^^ Pintar enemigos, lanzar y controlar el movimiento de los mismos^^^
      }
      // ^^^ Pintar enemigos que estén cerca del jugador ^^^
      
      enemyColisions[e].x = enemy.x + backgroundX + 125;
      enemyColisions[e].y = enemy.y + 120;
      // ^^^ Actualizar la caja de colisiones en todo momento ^^^
      
      if (playerColision.intersect(enemyColisions[e]) && isVulnereable) { // Detectar las colisiones del jugador con los enemigos
        playerHealth = playerHealth - 1; // Restar vida si colisiona
        show_loon = false;
        show_deadloon = true;
        dead_sound.unmute();
        speed = 6;
        isVulnereable = false;
        vulnerableStartTime = millis(); // iniciar el contador de tiempo de invulnerabilidad 
        f = 0; // Reiniciar el estado de la animación del globo
        dead_sound.play();
      }
    }
    if (!isVulnereable && millis() - vulnerableStartTime >= vulnerableMaxDuration) { // Verificar si ya pasó el tiempo de invulnereabilidad
      show_loon = true;
      show_deadloon = false;
      dead_sound.rewind();
      isVulnereable = true;
  }
    
}

void drawOptions(){ 
  background(backgroundImage_menu);
  image(optionTitle, 300, 0, 1200, 250);
  image(howToPlay, 400, 150, 1000, 300);
  if(mouseX > 440 && mouseX < 1360 && mouseY > 215 && mouseY < 390){
    image(optionsSelector, 1360, 220, 250 ,150);
  }
  image(goBack, 600, 680, 600, 200);
  if(mouseX > 630 && mouseX < 1170 && mouseY > 720 && mouseY < 845){
    image(optionsSelector, 1180, 700, 250 ,150);
  }
  image(difficultyTitle, 60, 380, 400, 150);
  if((mouseX > 75 && mouseX < 440 && mouseY > 410 && mouseY < 490) || pressedDif){
    image(difficultEasy, 60, 480, 250, 100);
    image(difficultNormal, 70, 570, 250, 100);
    image(difficultHard, 75, 660, 250, 100);
    image(optionsSelector, 445, 415, 150 ,75);
  }
}


void drawPause(){
  timePause = millis(); // Contador de tiempo en pausa
  background(backgroundImage_menu);
  
  fill(0, 150);
  rect(0, 0, width, height); // Crear un rectangulo que cree la ilusión de transparencia
  
  image(goBack, 1300, 0, 500, 100);
  image(htpPause, 600, 50, 600, 200);
  image(htpVolume, 700, 300, 400, 150);
  
  fill(#ff0a54);
  rect(750, 450, 300, 40); 
  fill(0, 255, 0);
  rect(750, 450, map(volume, -50, 50, 0, 300), 40); // Mapea los valores a valores que la función .Gain acepte 
  // ^^^ Crear la barra de volumen ^^^

  image(pauseQuitGame, 700, 700, 400, 150);
  //image(resume_options, 400, 200, 120,100);
  //image(play_options, 775, 300, 250, 100);
  
  if (specialCoins[1].collected == true) {
    image(specialCoin, 200, 100, 300, 200);
  } else {
    image(specialCoin_noCollected, 200, 100, 300, 200);
  }
  if (specialCoins[2].collected == true){
    image(specialCoin, 200, 250, 300, 200);
  } else {
    image(specialCoin_noCollected, 200, 250, 300, 200);
  }
  if (specialCoins[3].collected == true){
    image(specialCoin, 200, 400, 300, 200);
  } else {
    image(specialCoin_noCollected, 200, 400, 300, 200);
  }
  if (specialCoins[4].collected == true){
    image(specialCoin, 200, 550, 300, 200);
  } else {
    image(specialCoin_noCollected, 200, 550, 300, 200);
  }
  if (specialCoins[5].collected == true){
    image(specialCoin, 1300, 100, 300, 200);
  } else {
    image(specialCoin_noCollected, 1300, 100, 300, 200);
  }
  if (specialCoins[6].collected == true){
    image(specialCoin, 1300, 250, 300, 200);
  } else {
    image(specialCoin_noCollected, 1300, 250, 300, 200);
  }
  if (specialCoins[7].collected == true){
    image(specialCoin, 1300, 400, 300, 200);
  } else {
    image(specialCoin_noCollected, 1300, 400, 300, 200);
  }
  if (specialCoins[8].collected == true){
    image(specialCoin, 1300, 550, 300, 200);
  } else {
    image(specialCoin_noCollected, 1300, 550, 300, 200);
  }
  // ^^^ Creando y ubicando todas las monedas especiales ^^^
}

void drawWinScreen(){
  background(winBackground);
  image(congratulationImage, 100, 0, 1600, 300);
  image(endDecoration, 1000, 250, 600, 700);
  image(statsImage, 200, 250, 500, 200);
  image(projectileImage, 80, 290, 150, 150);
  image(retryWinImage, 200, 450, 500, 200);
  image(projectileImage, 80, 480, 150, 150);
  image(exitImage, 200, 650, 500, 200);
  image(projectileImage, 80, 690, 150, 150);
}

void drawStatistics(){
  background(winBackground);
  image(projectileImage, 440, 80, 200, 200);
  image(statsImage, 600, 0, 600, 300);
  image(projectileImage, 1160, 80, 200, 200);
  image(retryWinImage, 50, 750, 300, 100);
  image(exitImage, 380, 745, 300, 100);
  fill(#0766D8);
  textSize(65);
  text("Saltos:", 50, 350);
  text(jumpNumber, 270, 350);
  text("Velocidad máxima:" , 50, 450);
  text(nf(speedStat, 0, 1), 580, 450);
  image(endDecoration, 1000, 250, 600, 700);
  
}

void resetGame() { // Todo lo que debe ser reiniciado después de una ejecucción del videojuego
  song.rewind();
  winSound.rewind();
  xpos = 0;
  ypos = 0;
  backgroundX = 0;
  speed = 8;
  Y_velocity = 0;
  playerHealth = maxPlayerHealth;
  startTime = millis();
  
  for (int co = 1; co < numeroDeMonedas; co++) {
    float x = random(600, 32000);
    float y = random(500, 700);
    coins[co] = new Coin(x, y, 100, 100);
  }
  
  coinCounter = 0;
  for (sc = 1; sc < specialCoins.length; sc++) {
        specialCoins[sc].collected = false;
    }
  gameOverSound.rewind();
  switch(difficulty){
    case 1:
      tShield = 3;
      break;
    case 2:
      tShield = 2;
      break;
    case 3:
      tShield = 1;
      break;
    default:
      tShield = 3;
      break;
  }
  shields = new Shield(5000);
  jumpNumber = 0;
  speedStat = 0;
}

void drawCredits(){
  if(playingVideo){
    image(credits, 0, 0, width, height);
    credits.play();
  }
  
  image(moveLeft, 0, 0, 300, 300);
}

void drawHowToPlay() {
  background(backgroundImage_menu);
  image(howToPlay, 370, 40, 1100, 300);
  image(goBack, 1300, 0, 500, 100);
  image(moveUp, 0, 250, 200, 200);
  image(htpCollect, 150, 300, 800, 100);
  image(moveLeft, 0, 400, 200, 200);
  image(htpLeft, 150, 450, 400, 100);
  image(moveRight, 0, 550, 200, 200);
  image(htpRight, 150, 600, 400, 100);
  image(moveDown, 0, 700, 200, 200);
  image(shieldImage, 150, 750, 400, 100);
  image(spaceBar, 1350, 600, 400, 150);
  image(htpJump, 1350, 750, 400, 100);
  image(htpPause, 900, 750, 400, 150);
  image(tabButton, 1000, 580, 200, 200);

}

void drawFailScreen(){
  gameOverSound.setGain(50);
  gameOverSound.play();
  //gameOverSound.rewind();
  background(backgroundImage_menu);
  image(gameOver, 370, 200, 1100, 250);
  image(betterLNT, 420, 350, 1000, 250);
  image(pauseQuitGame, 0, 690, 550, 250);
  image(retryImage, 1300, 700, 500, 200);
}

void keyPressed(){
  if(keyCode == LEFT) {
    izquierda = true;
  } 
  if(keyCode == RIGHT) {
    derecha = true;
  }
  if(key == ' ' && Y_velocity == 0) { // Saltar con el espacio si está en el piso
    jumpNumber = jumpNumber + 1;
    spacePressed = true;
    isJumping = true; 
    jumpHoldTime = 0;
    if(mode == 1){ 
      jumping_sound.play();
      jumping_sound.rewind();
    }
    //^^^ Lógica de salto ^^^
  }
  if(mode == 1 && keyCode == TAB){ // Botón de pausa
     mode = 2;
     isPaused = !isPaused; // Cambiar el estado de pausa
  }
  if (keyCode == DOWN && shields.isActivated() == false) { // Botón del escudo 
    shields.activate();
    powerUp.setGain(-8);
    powerUp.play();
    powerUp.rewind();
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

void movement(){ // Movimiento en el eje X
  if(izquierda) {
    xpos -= speed;
  }
  if(derecha) {
    xpos += speed;
  }
  
  
}

void movieEvent(Movie credits) { // Reproduce el video
  credits.read();
}

void moveRect(){ // Evitar que el globo salga de la pantalla
  xpos = constrain(xpos, 300, sizex-loon_size - 600);
  ypos = constrain(ypos, 0, sizey-loon_size-100);
  if (ypos >= sizey - loon_size-100) {
        ypos = sizey - loon_size-100; 
        Y_velocity = 0; 
        isJumping = false; 
    }
  
}

void frames_loon(){ // Controlar las imagenes del gif
  if(frameCount % 3 == 0){
    f++;
  }
  if(f == numberOffFrames_loon){
    f = 0;
  }
  
  
}
void frames_tittle(){ // Controlar las imagenes del gif
  if(frameCount % 2 == 0){
    f++;
  }
  if(f == numberOffFrames_tittle){
    f = 0;
  }
  
  
}

void frames_deadloon(){ // Controlar las imagenes del gif
  if(frameCount % 18 == 0){
    f++;
  }
  if(f == numberOffFrames_deadloon){
    f = 0;
  }
  
  
}

void frames_Wind(){ // Controlar las imagenes del gif
  if(frameCount % 3 == 0){
    w++;
  }
  if(w == numberOffFrames_Wind){
    w = 0;
  }
  
  
}

void applyJumpForce() {
  if (isJumping) { // Verificar si está en el aire
    Y_velocity = jumpForce; // Asignar a la velocidad en Y la fuerza de salto
    isJumping = false;
  } else if (spacePressed && jumpHoldTime < maxJumpHoldTime) { // Fuerza máxima de salto
    jumpHoldTime++; // Sumando al tiempo de fuerza máxima
    Y_velocity = map(jumpHoldTime, 0, maxJumpHoldTime, jumpForce, maxJumpForce); // mapeando el tiempo de salto actual a los valores del tiempo máximo de salto
  }
}

void applyGravity(){ // Aplicando el efecto de gravedad
  if (!isJumping && ypos >= sizey - loon_size) { // Verificar que no esté saltando y que esté tocando el piso
        isJumping = false; 
        Y_velocity = 0; 
    } else {
        Y_velocity += gravity; // Sumandole la gravedad a la velocidad para hacerlo caer
    }
    ypos += Y_velocity; // Ssumandole la velocidad en Y a la cordenada del eje Y
}

void moveBackground() { // Mover el fondo

    if (derecha) {
        backgroundX -= speed * 2;
    } else if (izquierda) {
        backgroundX += speed * 2;
    }
    backgroundX = constrain(backgroundX, -(backgroundImage_game.width - width), 0); // Verificar que el fondo no se salga de los límites de la pantalla
    image(backgroundImage_game, backgroundX, 0);
    
}
