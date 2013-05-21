package brickbreaker

import javafx.scene.Parent
import javafx.scene.image.ImageView

class Ball extends Parent {
    
    public static final int DEFAULT_SIZE = 2;
    
    public static final int MAX_SIZE = 5;
 
    int size;

    int diameter;
    ImageView imageView;

    new() {
        imageView = new ImageView();
        getChildren().add(imageView);
        changeSize(DEFAULT_SIZE);
        setMouseTransparent(true);
    }

    def int getSize() {
        return size;
    }

    def int getDiameter() {
        return diameter;
    }

    def void changeSize(int newSize) {
        size = newSize;
        imageView.setImage(Config::getImages().get(Config::IMAGE_BALL_0 + size));
        diameter = (imageView.getImage().getWidth() - Config::SHADOW_WIDTH) as int;
    }

}