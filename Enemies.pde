// Clase Enemigos

class Enemies{
  float limit_X, limit_Y;
  float x, y, enemy_speed;
  int enemy_size;
  PImage spike_enemy;
  float gravity = 0.8;
  float Y_velocity = 0;
  int jumpOcasionally = 50;
  Projectile projectile1;
  Projectile projectile2;
  Projectile projectile3;
  Projectile projectile4;
  
  Enemies(float x_, float y_, int enemy_size_, float enemy_speed_, float limit_X_, float limit_Y_){
    x = x_;
    y = y_;
    enemy_size = enemy_size_;
    enemy_speed = enemy_speed_;
    limit_X = limit_X_;
    limit_Y = limit_Y_;
    
    spike_enemy = loadImage("enemy(still).png");
  }
  // ^^^ Constructores ^^^
  
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
  
  void display_enemy(){
    image(spike_enemy, x + backgroundX, y, enemy_size, enemy_size); // Pintar el enemigo
  }
  
  void shootProjectile(){ // Lanzar poryectiles
    if (projectile1 == null) { // Lanzar solo si no hay un proyectil ya
      float direction = random(-1, 1); // Dirección aleatoria
      float projectile_speedX = direction * random(10, 5); // Fuerza Variable en X
      float projectile_speedY = -20; // Fuerza de tiro en Y
      float projectile_size = 80; // Tamaño del proyectil
      projectile1 = new Projectile(x + enemy_size / 2 , y + enemy_size / 2, projectile_speedX, projectile_speedY, projectile_size); // Creación del proyectil
    }
    if (projectile2 == null) {
      float direction = random(-1, 1);
      float projectile_speedX = direction * random(10, 5); 
      float projectile_speedY = -20;
      float projectile_size = 80; 
      projectile2 = new Projectile(x + enemy_size / 2 , y + enemy_size / 2, projectile_speedX, projectile_speedY, projectile_size);
    }
    if (projectile3 == null) {
      float direction = random(-1, 1);
      float projectile_speedX = direction * random(10, 5); 
      float projectile_speedY = -20;
      float projectile_size = 80; 
      projectile3 = new Projectile(x + enemy_size / 2 , y + enemy_size / 2, projectile_speedX, projectile_speedY, projectile_size);
    }
    if (projectile4 == null) {
      float direction = random(-1, 1);
      float projectile_speedX = direction * random(10, 5); 
      float projectile_speedY = -20;
      float projectile_size = 80; 
      projectile4 = new Projectile(x + enemy_size / 2 , y + enemy_size / 2, projectile_speedX, projectile_speedY, projectile_size);
    }
    
 
  }
  
  void moveProjectile() {
    if (projectile1 != null) { // Mover el proyectil si existe
      projectile1.move();
      if (projectile1.y > height) { // Eliminar el proyectil si sale de la pantalla
        projectile1 = null; // Si sale de la pantalla, eliminar el proyectil
      }
    } 
    if (difficulty == 2 || difficulty == 3){ // Pintar más proyectiles dependiendo de la dificultad
       if (projectile2 != null) {
        projectile2.move(); // Mover el proyectil si existe
       if (projectile2.y > height) {
          projectile2 = null; // Eliminar el proyectil si sale de la pantalla
       }
      } 
    }
    if (difficulty == 3){
      if (projectile3 != null) {
        projectile3.move(); // Mover el proyectil si existe
       if (projectile3.y > height) {
          projectile3 = null; // Eliminar el proyectil si sale de la pantalla
       }
      }
      if (projectile4 != null) {
        projectile4.move(); // Mover el proyectil si existe
       if (projectile4.y > height) {
          projectile4 = null; // Eliminar el proyectil si sale de la pantalla
       }
      }
    }
}
  
  void displayProjectile() {
    if (projectile1 != null) { 
      projectile1.display_projectile(); // Mostrar el proyectil si existe
    }
    if (difficulty == 2 || difficulty == 3){ // Mostrar más proyectiles dependiendo de la dificultad
      if (projectile2 != null){
        projectile2.display_projectile();
      }
    }
    if (difficulty == 3){
     if (projectile3 != null){
        projectile3.display_projectile(); // Mostrar el proyectil
      }
     if (projectile4 != null){
        projectile4.display_projectile(); // Mostrar el proyectil
      }
    }
  }
  
}
