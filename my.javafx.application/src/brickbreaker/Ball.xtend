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
        imageView.image = switch newSize {
        	case 1 : Config.IMAGE_BALL_1
        	case 2 : Config.IMAGE_BALL_2
        	case 3 : Config.IMAGE_BALL_3
        	case 4 : Config.IMAGE_BALL_4
        	case 5 : Config.IMAGE_BALL_5
        	default : Config.IMAGE_BALL_0
        }
        diameter = (imageView.image.width - Config.SHADOW_WIDTH) as int
    }

}