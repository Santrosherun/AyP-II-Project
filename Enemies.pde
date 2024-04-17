

class Enemies{
  float x, y, enemy_speed;
  int enemy_size;
  PImage spike_enemy;
  float gravity = 0.8;
  float Y_velocity = 0;
  int jumpOcasionally = 1000;
  
  Enemies(float x_,float y_, int enemy_size_, float enemy_speed_){
    x = x_;
    y = y_;
    enemy_size = enemy_size_;
    enemy_speed = enemy_speed_;
    
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
    
    if (x <= 0 || x >= width - enemy_size) {
      enemy_speed *= -1;
    }
    
    if (random(1000) < jumpOcasionally && y >= height - enemy_size) {
      Y_velocity = -15; // Set a jump velocity
    }

  }
  
  void display_enemy(){
    // Display enemies
    image(spike_enemy, x, y, enemy_size, enemy_size);
  }
  
  void shootProjectile(){
    // shoot projectile 
  }
}
