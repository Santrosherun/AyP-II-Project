

class Projectile{
  float x, y, projectile_size, launchAngle = 45, projectile_speedX = 10, projectile_speedY = 10;
  float gravity = 0.8;
  PImage projectileImage;
  Colissions collisionBox;
  
  Projectile(float x_, float y_, float projectile_speedX_, float projectile_speedY_, float projectile_size_){
    x = x_;
    y = y_;
    projectile_size = projectile_size_;
    projectile_speedX = projectile_speedX_;
    projectile_speedY = projectile_speedY_;
    
    projectileImage = loadImage("spike_projectile.png");
    collisionBox = new Colissions(x, y, projectile_size, projectile_size);
  }
  
  void move(){
    //move projectile
    projectile_speedY = projectile_speedY + gravity;
    x = x + projectile_speedX ;
    y = y + projectile_speedY;
    
    collisionBox.x = x + backgroundX;
    collisionBox.y = y;
    collisionBox.width = 60;
    collisionBox.height = 60;
    
    if (proj != null && playerColision.intersect(collisionBox) && isVulnereable) {
        playerHealth = playerHealth - 1;
        speed = 4;
        show_loon = false;
        show_deadloon = true;
        dead_sound.unmute();
        isVulnereable = false;
        vulnerableStartTime = millis();
        f = 0;
        dead_sound.play();
    }
  }
  
  
  
  void display_projectile(){
    // display projectile
    image(projectileImage, x + backgroundX, y, projectile_size, projectile_size);
  }
}
