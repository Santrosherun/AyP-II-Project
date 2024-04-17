

class Platform{
  int x, y, width, height;
  int platformColor;
  boolean loonOnPlatform;
  
  // Constructor
  Platform(int x_, int y_, int width_, int height_, int platformColor_) {
    x = x_;
    y = y_;
    width = width_;
    height = height_;
    platformColor = platformColor_;
  }
  
  // Método para dibujar la plataforma
  void drawPlatform() {
    fill(platformColor);
    rect(x, y, width, height);
  }
  
   int getX() {
        return x;
    }

    int getY() {
        return y;
    }

    int getWidth() {
        return width;
    }

    int getHeight() {
        return height;
    }
    
    int getColor(){
      return platformColor;
    }
} 
