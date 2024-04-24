

class Coin{
    float x, y;
    boolean isCollected;
    PImage coinImage;
    
    Coin(float x_, float y_) {
        x = x_;
        y = y_;
        isCollected = false;
        
        coinImage = loadImage("coin_image.png");
    }
    
}
