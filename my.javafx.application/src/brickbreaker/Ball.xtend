package brickbreaker

import javafx.scene.Parent
import javafx.scene.image.ImageView

class Ball extends Parent {
    
    public static final int DEFAULT_SIZE = 2
    
    public static final int MAX_SIZE = 5
 
    int size
   
    int diameter
    ImageView imageView

    new() {
        imageView = new ImageView
        children += imageView
        setSize(DEFAULT_SIZE)
        mouseTransparent = true;
    }

    def int getSize() {
        return size
    }

    def int getDiameter() {
        return diameter
    }

    def void setSize(int newSize) {
        size = newSize
        imageView.image = Config::getImages().get(Config::IMAGE_BALL_0 + size)
        diameter = (imageView.image.width - Config::SHADOW_WIDTH) as int
    }

}