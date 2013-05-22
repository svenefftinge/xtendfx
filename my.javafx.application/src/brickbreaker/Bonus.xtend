package brickbreaker

import javafx.scene.Parent
import javafx.scene.image.ImageView

class Bonus extends Parent { 

    public static final int TYPE_SLOW = 0
    public static final int TYPE_FAST = 1
    public static final int TYPE_CATCH = 2
    public static final int TYPE_GROW_BAT = 3
    public static final int TYPE_REDUCE_BAT = 4
    public static final int TYPE_GROW_BALL = 5
    public static final int TYPE_REDUCE_BALL = 6
    public static final int TYPE_STRIKE = 7
    public static final int TYPE_LIFE = 8

    public static final int COUNT = 9

    public static final String[] NAMES = #[
        "SLOW",
        "FAST",
        "CATCH",
        "GROW BAT",
        "REDUCE BAT",
        "GROW BALL",
        "REDUCE BALL",
        "STRIKE",
        "LIFE"
    ]

    int type
    int width
    int height
    ImageView content

    def int getHeight() {
        return height
    }

    def int getWidth() {
        return width
    }

    def int getType() {
        return type
    }

    new (int type) {
        content = new ImageView()
        getChildren().add(content)
        this.type = type
        val image = Config::getBonusesImages().get(type)
        width = (image.getWidth() - Config::SHADOW_WIDTH) as int
        height = (image.getHeight() - Config::SHADOW_HEIGHT) as int
        content.setImage(image)
        setMouseTransparent(true)
    }

}