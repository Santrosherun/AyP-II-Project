// Clase Abanico

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
    // ^^^ Constructores ^^^

    void display() { // Mostrar una imagen u otra dependiendo de la orientación
        if (isFacingRight) {
            image(fanImageRight, x + backgroundX, y, 300, 300);
        } else {
            image(fanImageLeft, x + backgroundX, y, 300, 300);
        }
    }
    
    void applyWindEffect(float playerX, float playerY) { // efecto de empuje del Abanico
         if (isFacingRight){
           float windEffectX = x + backgroundX + 250; // Calculando el empuje
           image(gifwind[w], windEffectX, y + 50, windRange, 200); // Pintando el viento
           frames_Wind();
           if (playerX > x + backgroundX + 80 && playerX < x + backgroundX + 150 + windRange && playerY > y - 100 && playerY < y + 350){ // Verificar que el jugador esté en el área de efecto
             xpos = xpos + windForce; // Aplicarselo a la posición en el eje X
             backgroundX = backgroundX - windForce; // Mover el fondo
             windSound.play();
           } else {
             if(!windSound.isPlaying()){
                 windSound.rewind();
               }
           }
         } 
         // ^^^ Abanico mirando a la derecha ^^^
         else {
           float windEffectX = x + backgroundX - windRange;
           image(gifwind[w], windEffectX, y + 50, windRange + 50, 200);
           frames_Wind();
           if(playerX > windEffectX - 100 && playerX < windEffectX + windRange && playerY > y - 100 && playerY < y + 350){ // Verificar que el jugador esté en el área de efecto
             xpos = xpos - windForce; // Aplicarselo a la posición en el eje X
             backgroundX = backgroundX + windForce; // Mover el fondo
             windSound.play();
           } else {
             if(!windSound.isPlaying()){
               windSound.rewind();
             }
           }
         }
         // ^^^ Abanico mirando a la izquierda ^^^
      }
    
}
