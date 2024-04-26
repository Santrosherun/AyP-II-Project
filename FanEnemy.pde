

class FanEnemy {
    float x, y;
    PImage fanImageLeft; 
    PImage fanImageRight; 
    float windRange; 
    float windForce;
    boolean isFacingRight; 

    FanEnemy(float x_, float y_, PImage imgLeft, PImage imgRight, float windRange_, float windForce_, boolean facingRight) {
        x = x_;
        y = y_;
        fanImageLeft = imgLeft;
        fanImageRight = imgRight;
        windRange = windRange_;
        windForce = windForce_;
        isFacingRight = facingRight;
    }

    void display() {
        if (isFacingRight) {
            image(fanImageRight, x + backgroundX, y, 300, 300);
        } else {
            image(fanImageLeft, x + backgroundX, y, 300, 300);
        }
    }
    
    void applyWindEffect(float playerX, float playerY) {
         if (isFacingRight){
           rect(x + backgroundX + 250, y - 50, windRange, 350);
           if (playerX > x + backgroundX + 80 && playerX < x + backgroundX + 150 + windRange && playerY > y - 100 && playerY < y + 350){
             xpos = xpos + windForce;
             backgroundX = backgroundX - windForce;
           }
         } else {
           rect(x + backgroundX - 250, y - 50, windRange, 350);
           if(playerX > x + backgroundX - 400 && playerX < x + backgroundX - 320 + windRange && playerY > y - 100 && playerY < y + 350){
             xpos = xpos - windForce;
             backgroundX = backgroundX + windForce;
           }
         }
      }
    
}
