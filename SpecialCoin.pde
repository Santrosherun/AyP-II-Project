// Clase Monedas Especiales

class SpecialCoin{
    float x, y, size;
    PImage sCoinImage;
    boolean collected;
    
    SpecialCoin(float x_, float y_, float size_){
        x = x_;
        y = y_;
        size = size_;
        sCoinImage = loadImage("specialCoin.png");
        collected = false;
    }
    // ^^^ Constructores ^^^
    
    void display(){
        if (!collected){ // Pintar la moneda especial si no ha sido recolectada
            image(sCoinImage, x + backgroundX, y, size + 50, size);
        }
    }
    
    boolean checkCollision(Colissions playerCollisionBox){ // Función que detecta colisiones con las monedas especiales
        //rect(x + 100 + backgroundX, y, size , size);
        return !collected && playerCollisionBox.intersect(new Colissions(x +100 + backgroundX, y, size, size));
    }
}
