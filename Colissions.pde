

class Colissions{
   float x, y, width, height;
   
   Colissions(float x_, float y_, float width_, float height_) {
    x = x_;
    y = y_;
    width = width_;
    height = height_;
  }
  
  boolean intersect(Colissions another){
    return x < another.x + another.width && x + another.width > another.x && y < another.y + another.height && y + another.height > another.y;
  }
  
  void showRect() {
    rect(x, y, width, height);
  }
}
