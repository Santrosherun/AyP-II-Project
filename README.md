# AyP-II-Project
All the important files related to Poploon game
Any support is well recived 

Now Im Gonna add all the main Functions of PopLoon, along with a brief description!!

Main Sketch
1. Manejo de los gifs:
   gif = new PImage[numberOffFrames_loon];
  
  while (i < numberOffFrames_loon){
    gif[i] = loadImage("frame_"+i+"_delay-0.15s.gif");
    i++;
  }
  
  void frames_loon(){ // Controlar las imagenes del gif
  if(frameCount % 3 == 0){
    f++;
  }
  if(f == numberOffFrames_loon){
    f = 0;
  } 
}
--Manejo de todos los gifs de "Poploon" a travez de un conjunto de imagenes que se van reproduciendo iterativamente controladas por la subrutina frames_loon()

2. Manejo de la pantalla que se le muestra al jugador:
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
  --Un dependiendo en conjunto con una variable "mode" controlan el estado de la pantalla en todo momento

   3. Creación de la barra de volumen:
      if (mouseX > 750 && mouseX < 1050 && mouseY > 450 && mouseY < 490 && mousePressed) {
      volume = map(mouseX, 750, 1050, -50, 50);
      volume = constrain(volume, -50, 50); 
      song.setGain(volume); 
    }
    fill(#ff0a54);
    rect(750, 450, 300, 40); 
    fill(0, 255, 0);
    rect(750, 450, map(volume, -50, 50, 0, 300), 40); // Mapea los valores a valores que la función .Gain acepte 
  // ^^^ Crear la barra de volumen ^^^
    --Un condicional controla la posición del mouse sobre la barra de volumen, posteriormente se mapean los valores en el eje X del mismo a valores aceptados por el método ".setGain" de la libreria "Minim" y se      usa un "constrain" para evitar que los valores se salgan del rango permitido, finalmente se le asigna a .setGain la variable volumen, controlando así el nivel de la música y terminando por pintar un              rectangulo de un color distinto para representar el cambio de volumen
      
  4.  Control de la selección de la dificultad:
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
    -- Se usa una variable para que, si se hace click en la dificultad, se alteren las variables relacionadas con la misma (Cantidad de proyectiles por enemigo, cantidad de monedas para recuperar una vida, cantidad de escudos iniciales)
      
   5. Control del temporizador:
      if(!isPaused){
      timePast = millis() - startTime; // Empezar a contar el tiempo 
    }
    minutes = int(timePast / (1000 * 60));
    seconds = int((timePast / 1000) % 60);
    milliseconds = timePast % 1000; 
    // ^^^ Dividiendo el tiempo en minutos, segundos y milisegundos ^^^
    if (seconds % increaseTime == 0) { // Parpadear cada increaseTime (15000) milisegundos
        isRed = !isRed;
        if (isRed) {
            fill(255, 0, 0);
        } else {
            fill(255); 
        }
    }
        // ^^^ Parpadear en rojo ^^^
    textSize(50);
    text(nf(minutes, 2) + ":" + nf(seconds, 2) + ":" + nf(milliseconds, 3), width - 260, 70); // nf() se utiliza para formatear los números y asegurarse de que tengan el número adecuado de dígitos
    // ^^^ Pintar el temporizador en pantalla formateado a 2 decimales ^^^
    --Se realiza el manejo del tiempo principalmente usando "millis()" y la variable booleana "isPaused". Desde que inicia el juego se empieza a contar el tiempo en milisegundos, se divide en minutos, segundos    y milisegundos para poder imprimir el temporizador correctamente

  6. Control de aumento de la velocidad y muerte del jugador transcurrido cierto tiempo:
     if (timePast >= lastIncreaseTime + increaseTime_m && !speedIncreased) { // Verificar que se debe incrementar la velocidad, solo una vez
        speed += 0.5;
        lastIncreaseTime = timePast;
        speedIncreased = true;
    } else if (timePast < lastIncreaseTime + increaseTime_m) {
        speedIncreased = false;
    }
    // ^^^ Lógica para incrementar la velocidad ^^^
    if (minutes == 1 && seconds >= 40){
          playerHealth = 0;
    }
    --Se usa la variable "speedIncreased" para controlar que el incremento ocurra una sola vez, se usan las variables "lastIncreaseTime" e "increaseTime_m" para verificar que se haga cada cierto tiempo, en este caso, 15000 milisegundos

     7. Conteo de monedas, incremento de vida (Ligado a la dificultad):
        if (coinCounter >= 10 && maxPlayerHealth != playerHealth){
        playerHealth = playerHealth + 1;
        vidaExtra.play();
        vidaExtra.rewind();
        coinCounter = coinCounter - 10;
        }
        for (co = 1; co < coins.length; co++) {
        Coin coin = coins[co];
        if (!coin.isCollected) {
            coin.drawCoin(); // Dibujar la moneda si no ha sido recolectada
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
        fill(255);
        textSize(35);
        text("Monedas: " + coinCounter, 250, 70);
        // ^^^ Pintar la cantidad de monedas en pantalla ^^^
        --Se cuenta la cantidad de monedas, y si llega a cieto valor, se restan del total y se suma una vida, asímismo, se pinta la vida y las monedas en pantalla

        8. Implementación de mejora de rendimiento:
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
           --Se pintan los enemigos solo si la distancia entre el jugador y el enemigo es menor a 2000 pixeles, haciendo que siempre sean visibles pero que si no están en pantalla no se pinten

           Clases
           1. Detección de la mayoría de colisiones:
                boolean intersect(Colissions another){ // Función principal para manejar colisiones
                    return x < another.x + another.width && x + another.width > another.x && y < another.y + another.height && y + another.height > another.y; // Retorna true si ambos objetos colisionan
                }
              --Función más importante de detección de colisiones entre 2 objetos, toma los valores en X y Y de ambos objetos y compara que se estén sobreponiendo, devuelve true si pasa esto mismo, de lo                      contrario, devuelve false

           2. Detección de colisiones monedas jugador:
              boolean checkCollision(float playerX, float playerY, float playerSize) { // Función que detecta colisión entre el jugador y la moneda
                 if (!isCollected) {
                        float distance = dist(x + backgroundX + width / 2, y + height / 2, playerX + 70, playerY + 70); // Calcular la distancia entre el centro del jugador y el centro de la moneda
                        float minDistance = (playerSize + width) / 2; // Calcular la suma de los radios del jugador y la moneda
                        if (distance < minDistance) { // Verificar si la distancia es menor que la suma de los radios
                            isCollected = true; // Detectar la recolección de la moneda
                            return true;
                        }
                    }
                    return false;
              }
              --Sigue la misma lógica que la detección de colisiones entre 2 objetos, pero en esta la caja se calcula de acuerdo al centro del jugador y el centro de la moneda, además de que recibe como parámetros la posición en X y Y y el tamaño del jugador
              
           3. lanzamiento de proyectil:
              void shootProjectile() // Lanzar poryectiles
                if (projectile1 == null) { // Lanzar solo si no hay un proyectil ya
                  float direction = random(-1, 1); // Dirección aleatoria
                  float projectile_speedX = direction * random(10, 5); // Fuerza Variable en X
                  float projectile_speedY = -20; // Fuerza de tiro en Y
                  float projectile_size = 80; // Tamaño del proyectil
                  projectile1 = new Projectile(x + enemy_size / 2 , y + enemy_size / 2, projectile_speedX, projectile_speedY, projectile_size); // Creación del proyectil
                }
              --Se crea el objeto proyectil, se le da una dirección y una fuerza en X Aleatoria
           4. Lógica para mover y mostrar el proyectil:
              void move(){
                projectile_speedY = projectile_speedY + gravity;
                x = x + projectile_speedX ;
                y = y + projectile_speedY;
                // ^^^ Mover el proyectil, aplicarle gravedad y actualizar su posición ^^^
                collisionBox.x = x + backgroundX; // Actualizar la posición de la caja en el eje X relativo al fondo
                collisionBox.y = y; // Actualizar la posicón de la caja en el eje Y
                collisionBox.width = 60; // Fijar el tamaño de la caja
                collisionBox.height = 60; // Fijar el tamaño de la caja
                
                if (proj != null && playerColision.intersect(collisionBox) && isVulnereable) { // Detección de colisiones con el proyectil
                    playerHealth = playerHealth - 1;
                    speed = 8;
                    show_loon = false;
                    show_deadloon = true;
                    dead_sound.unmute();
                    isVulnereable = false;
                    vulnerableStartTime = millis();
                    f = 0;
                    dead_sound.play();
                }
              }
              void display_projectile(){ // display projectile
                image(projectileImage, x + backgroundX, y, projectile_size, projectile_size);
              }
              --Se usa la función colisiones para determinar las colisiones entre la caja de los proyectiles y la del jugador, asímismo se pinta el proyectil y se calcula su movimiento, a la vez que se        acutualiza la posición de la caja de colisiones

              5. Lógica para mover al enemigo y hacerlo saltar:
                 void move(){
                   x += enemy_speed; // Movimiento en el eje X
               
                   Y_velocity += gravity; // Aplicarles la gravedad
                   if(enemy_speed != 0){
                     y += Y_velocity; // Sumarle la velocidad a la posición en Y del enemigo
                   } 
                   if (y >= height - enemy_size) {
                     y = height - enemy_size;
                     Y_velocity = 0;
                   }
                   // ^^^ Enemigo en el piso ^^^
                   
                   if (x <= limit_X || x >= limit_Y) { // limites del enemigo
                     enemy_speed *= -1; // Cambio de dirección
                   }
                   
                   if (random(1000) < jumpOcasionally && y >= height - enemy_size) { // Salto aleatorio
                     Y_velocity = -15; // Fuerza de salto
                   }
               
                 }
                 --Se le asigna una velocidad en X, y unos límites al enemigo, cuando llega a estos (Que se le pasan como parámetros) su velocidad se multiplica por -1, haciendo que cambie de dirección.
                 Para el salto se usó la misma lógica que con el jugador, sumandole la gravedad a su velocidad en Y y posteriormente, a su posición, pero se hizo que esto sucediera de acuerdo a un intervalo de                   tiempo aleatorio

              6. Efecto de Empuje del Abanico (Depende de a dónde esté mirando):
                 void applyWindEffect(float playerX, float playerY) { // efecto de empuje del Abanico
                     if (isFacingRight){
                       float windEffectX = x + backgroundX + 250; // Calculando el empuje
                       image(gifwind[w], windEffectX, y + 50, windRange, 200); // Pintando el viento
                       frames_Wind();
                       if (playerX > x + backgroundX + 80 && playerX < x + backgroundX + 150 + windRange && playerY > y - 100 && playerY < y + 350){ // Verificar que el jugador esté en el área de efecto
                         xpos = xpos + windForce; // Aplicarselo a la posición en el eje X
                         backgroundX = backgroundX - windForce; // Mover el fondo
                         windSound.play();
                       } else {
                         if(!windSound.isPlaying()){
                             windSound.rewind();
                           }
                       }
                     } 
                     // ^^^ Abanico mirando a la derecha ^^^
                    -- Se le asignó una fuerza de empuje que se pasa como parámetro al crear el objeto. Este proceso recibe como parámetro la posición del jugador, y posteriormente calcula si está en el área de afección, si lo está, lo desplaza "windForce" unidades hacia una dirección u otra, dependiendo de dónde esté mirando el abanico, también desplaza un poco el fondo para aumentar el efecto de empuje.
              7. Escudo (Flecha hacia abajo):
                 boolean isActivated(){
                   if (active && millis() - activationTime >= duration) { // Verificar que no haya pasado el tiempo del escudo
                     active = false;
                   }
                   return active;
                 }
                 --Verifica que el escudo dure 5 segundos y que se desactive

                 void drawShield(float playerX, float playerY){
                   int shieldSize = 100;
                   pushStyle(); // aislar estilos
                   tint(255, 150);
                   image(shieldImage, playerX - shieldSize / 2 + 100, playerY - 120 / 2 + 90, 100, shieldSize);
                   popStyle(); // restaurar estilos
                   isVulnereable = false;
                 }
                 --Pinta el escudo de forma semitransparente

                 void activate(){
                   if (count < tShield) { // Verificar que no se haya alcanzado el límite de activaciones
                     active = true;
                     activationTime = millis(); // Temporizador de escudo
                     count = count + 1; // Incrementar el conteo de activaciones
                   }
                 }
                 --Se encarga de activar el escudo solo "tShield" cantidad de veces
              8. Detección de colisiones Monedas Especiales:
                 boolean checkCollision(Colissions playerCollisionBox){ // Función que detecta colisiones con las monedas especiales
                    //rect(x + 100 + backgroundX, y, size , size);
                    return !collected && playerCollisionBox.intersect(new Colissions(x +100 + backgroundX, y, size, size));
                }
                 --Usa la función de detección de colisiones para recolectar las monedas
