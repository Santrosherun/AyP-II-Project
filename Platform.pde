// Clase Plataformas

class Platform{
  float x, y, width, height;
  int platformColor;
  boolean loonOnPlatform;

  Platform(float x_, float y_, float width_, float height_, int platformColor_) {
    x = x_;
    y = y_;
    width = width_;
    height = height_;
    platformColor = platformColor_;
  }
  // ^^^ Constructores ^^^

  
  void drawPlatform() { // Método para dibujar la plataforma
    noStroke();
    fill(platformColor);
    rect(x + backgroundX, y, width, height); // Moverla relativa al fondo
  }

   float getX() {
        return x;
    }

    float getY() {
        return y;
    }

    float getWidth() {
        return width;
    }

    float getHeight() {
        return height;
    }

    int getColor(){
      return platformColor;
    }
    // ^^^ Retornar la posición y el color de la plataforma ^^^
} 
