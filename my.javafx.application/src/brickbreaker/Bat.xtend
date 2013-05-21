package brickbreaker

import javafx.scene.Parent
import javafx.scene.image.Image
import javafx.scene.image.ImageView
import javafx.geometry.Rectangle2D
import javafx.scene.Group

class Bat extends Parent { 

    public static final int DEFAULT_SIZE = 2;

    public static final int MAX_SIZE = 7;

    private static final Image LEFT = Config::getImages().get(Config::IMAGE_BAT_LEFT);
    private static final Image CENTER = Config::getImages().get(Config::IMAGE_BAT_CENTER);
    private static final Image RIGHT = Config::getImages().get(Config::IMAGE_BAT_RIGHT);

    private int size;
    private int width;
    private int height;

    private ImageView leftImageView;
    private ImageView centerImageView;
    private ImageView rightImageView;

    def int getSize() {
        return size;
    }

    def int getWidth() {
        return width;
    }

    def int getHeight() {
        return height;
    }

    def void changeSize(int newSize) {
        this.size = newSize;
        width = size * 12 + 45;
        val rightWidth = RIGHT.getWidth() - Config::SHADOW_WIDTH;
        val centerWidth = width - LEFT.getWidth() - rightWidth;
        centerImageView.setViewport(new Rectangle2D(
            (CENTER.getWidth() - centerWidth) / 2, 0, centerWidth, CENTER.getHeight()));
        rightImageView.setTranslateX(width - rightWidth);
    }

    new() {
        height = (CENTER.getHeight() - Config::SHADOW_HEIGHT) as int; 
        val group = new Group();
        leftImageView = new ImageView();
        leftImageView.setImage(LEFT);
        centerImageView = new ImageView();
        centerImageView.setImage(CENTER);
        centerImageView.setTranslateX(LEFT.getWidth());
        rightImageView = new ImageView();
        rightImageView.setImage(RIGHT);
        changeSize(DEFAULT_SIZE);
        group.getChildren().addAll(leftImageView, centerImageView, rightImageView);
        getChildren().add(group);
        setMouseTransparent(true);
    }
}