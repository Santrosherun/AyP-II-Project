

class Shield{
  boolean active;
  int duration; 
  float activationTime;
  int count;
  PImage shieldImage;
  
  Shield(int duration_){
    active = false;
    duration = duration_;
    count = 0;
    shieldImage = loadImage("shieldImage.png");
  }  
  
  void activate(){
    if (count < 3) { // Verificar que no se haya alcanzado el límite de activaciones
      active = true;
      activationTime = millis();
      count = count + 1; // Incrementar el conteo de activaciones
    }
  }
  
  boolean isActivated(){
    if (active && millis() - activationTime >= duration) {
      active = false;
    }
    return active;
  }
  
  void drawShield(float playerX, float playerY){
    int shieldSize = 100;
    pushStyle(); // aislar estilos
    tint(255, 150);
    image(shieldImage, playerX - shieldSize / 2 + 100, playerY - 120 / 2 + 90, 100, shieldSize);
    popStyle(); // restaurar estilos
    isVulnereable = false;
  }
  
}
