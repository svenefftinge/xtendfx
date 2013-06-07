package brickbreaker

import javafx.scene.Parent
import javafx.scene.image.Image
import javafx.scene.image.ImageView
import javafx.geometry.Rectangle2D
import javafx.scene.Group

class Bat extends Parent { 

    public static final int DEFAULT_SIZE = 2

    public static final int MAX_SIZE = 7

    static final Image LEFT = Config.getImages().get(Config.IMAGE_BAT_LEFT)
    static final Image CENTER = Config.getImages().get(Config.IMAGE_BAT_CENTER)
    static final Image RIGHT = Config.getImages().get(Config.IMAGE_BAT_RIGHT)

    int size
    int width
    int height

    ImageView leftImageView
    ImageView centerImageView
    ImageView rightImageView

    def int getSize() {
        return size
    }

    def int getWidth() {
        return width
    }

    def int getHeight() {
        return height
    }

    def void setSize(int newSize) {
        this.size = newSize
        width = size * 12 + 45
        val rightWidth = RIGHT.width - Config.SHADOW_WIDTH
        val centerWidth = width - LEFT.width - rightWidth
        centerImageView.viewport = new Rectangle2D((CENTER.width - centerWidth) / 2, 0, centerWidth, CENTER.height)
        rightImageView.translateX = width - rightWidth
    }

    new() {
        height = (CENTER.height - Config.SHADOW_HEIGHT) as int 
        val group = new Group => [
        	children += leftImageView = new ImageView => [
        		image = LEFT
        	]
        	children += centerImageView = new ImageView => [
        		image=CENTER
        		translateX = LEFT.width
        	]
        	children += rightImageView = new ImageView => [
        		image = RIGHT
        	] 	 
        ]
        
        setSize(DEFAULT_SIZE)
        children+=group
        mouseTransparent = true
    }
}