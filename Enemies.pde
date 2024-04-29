

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
  
  Enemies(float x_,float y_, int enemy_size_, float enemy_speed_, float limit_X_, float limit_Y_){
    x = x_;
    y = y_;
    enemy_size = enemy_size_;
    enemy_speed = enemy_speed_;
    limit_X = limit_X_;
    limit_Y = limit_Y_;
    
    spike_enemy = loadImage("enemy(still).png");
  }
  
  void move(){
    // Enemy movement
    x += enemy_speed;

    Y_velocity += gravity;
    y += Y_velocity;
    
    if (y >= height - enemy_size) {
      y = height - enemy_size;
      Y_velocity = 0;
    }
    
    if (x <= limit_X || x >= limit_Y) { //modificar
      enemy_speed *= -1;
    }
    
    if (random(1000) < jumpOcasionally && y >= height - enemy_size) {
      Y_velocity = -15; // Set a jump velocity
    }

  }
  
  void display_enemy(){
    // Display enemies
    image(spike_enemy, x + backgroundX, y, enemy_size, enemy_size);
  }
  
  void shootProjectile(){
    if (projectile1 == null) {
      float direction = random(-1, 1);
      float projectile_speedX = direction * random(10, 5); 
      float projectile_speedY = -20;
      float projectile_size = 80; 
      projectile1 = new Projectile(x + enemy_size / 2 , y + enemy_size / 2, projectile_speedX, projectile_speedY, projectile_size);
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
    // Mover el proyectil si existe
    if (projectile1 != null) {
      projectile1.move();
      // Eliminar el proyectil si sale de la pantalla
      if (projectile1.y > 900) {
        projectile1 = null;
      }
    } 
    if (difficulty == 2 || difficulty == 3){
       if (projectile2 != null) {
        // Mover el proyectil si existe
        projectile2.move();
       if (projectile2.y > height) {
          projectile2 = null; // Eliminar el proyectil si sale de la pantalla
       }
      } 
    }
    if (difficulty == 3){
      if (projectile3 != null) {
        // Mover el proyectil si existe
        projectile3.move();
       if (projectile3.y > height) {
          projectile3 = null; // Eliminar el proyectil si sale de la pantalla
       }
      }
      if (projectile4 != null) {
        // Mover el proyectil si existe
        projectile4.move();
       if (projectile4.y > height) {
          projectile4 = null; // Eliminar el proyectil si sale de la pantalla
       }
      }
    }
}
  
  void displayProjectile() {
    // Mostrar el proyectil si existe
    if (projectile1 != null) {
      projectile1.display_projectile();
    }
    if (difficulty == 2 || difficulty == 3){
      if (projectile2 != null){
        projectile2.display_projectile();
      }
    }
    if (difficulty == 3){
     if (projectile3 != null){
        projectile3.display_projectile();
      }
     if (projectile4 != null){
        projectile4.display_projectile();
      }
    }
  }
  
}
