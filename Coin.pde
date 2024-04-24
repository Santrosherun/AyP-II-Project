

class Coin{
    float x, y, width, height;
    boolean isCollected;
    PImage coinImage;
    
    Coin(float x_, float y_, float width_, float height_) {
        x = x_;
        y = y_;
        width = width_;
        height = height_;
        isCollected = false;
        
        coinImage = loadImage("coin_image.png");
    }
    
    void drawCoin() {
        if (!isCollected) {
            image(coinImage, x + backgroundX, y, width, height);
        }
    }
    
    boolean checkCollision(float playerX, float playerY, float playerSize) {
       if (!isCollected) {
              // Calcular la distancia entre el centro del jugador y el centro de la moneda
              float distance = dist(x + backgroundX + width / 2, y + height / 2, playerX + 70, playerY + 70);
              // Calcular la suma de los radios del jugador y la moneda
              float minDistance = (playerSize + width) / 2;
              // Verificar si la distancia es menor que la suma de los radios
              if (distance < minDistance) {
                  isCollected = true;
                  return true;
              }
          }
          return false;
    }
}
