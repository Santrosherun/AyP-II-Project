// Clase Coin

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
    // ^^^ Constructores ^^^
    
    void drawCoin() { // Dibujar la moneda
        if (!isCollected) { // Verificar que no haya sido recolectada
            image(coinImage, x + backgroundX, y, width, height); // Pintar la moneda
        }
    }
    
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
}
