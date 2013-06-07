package brickbreaker

import javafx.util.Duration
import javafx.collections.ObservableList
import javafx.scene.image.Image
import javafx.collections.FXCollections

class Config {
	
    public static final Duration ANIMATION_TIME = Duration.millis(40)
    public static final int MAX_LIVES = 9
    // Screen info
    public static final int FIELD_BRICK_IN_ROW = 15

    public static final String IMAGE_DIR = "images/desktop/"

    public static final int WINDOW_BORDER_X = 32 // on desktop platform
    public static final int WINDOW_BORDER_Y = 24 // on desktop platform
    public static final int TITLE_BAR_HEIGHT = 0 // on desktop platform
    public static final int SCREEN_WIDTH = 960
    public static final int SCREEN_HEIGHT = 720

    public static final int INFO_TEXT_SPACE = 10

    // Game field info
    public static final int BRICK_WIDTH = 48
    public static final int BRICK_HEIGHT = 24
    public static final int SHADOW_WIDTH = 10
    public static final int SHADOW_HEIGHT = 16

    public static final double BALL_MIN_SPEED = 6
    public static final double BALL_MAX_SPEED = BRICK_HEIGHT
    public static final double BALL_MIN_COORD_SPEED = 2
    public static final double BALL_SPEED_INC = 0.5f

    public static final int BAT_Y = SCREEN_HEIGHT - 40
    public static final int BAT_SPEED = 8

    public static final int BONUS_SPEED = 3

    public static final int FIELD_WIDTH = FIELD_BRICK_IN_ROW * BRICK_WIDTH
    public static final int FIELD_HEIGHT = FIELD_WIDTH
    public static final int FIELD_Y = SCREEN_HEIGHT - FIELD_HEIGHT

    static final String[] BRICKS_IMAGES = #[
        "blue.png",
        "broken1.png",
        "broken2.png",
        "brown.png",
        "cyan.png",
        "green.png",
        "grey.png",
        "magenta.png",
        "orange.png",
        "red.png",
        "violet.png",
        "white.png",
        "yellow.png"
    ]

    static ObservableList<Image> bricksImages = FXCollections.<Image>observableArrayList()

    def static ObservableList<Image> getBricksImages() {
        return bricksImages
    }

    static final String[] BONUSES_IMAGES = #[
        "ballslow.png",
        "ballfast.png",
        "catch.png",
        "batgrow.png",
        "batreduce.png",
        "ballgrow.png",
        "ballreduce.png",
        "strike.png",
        "extralife.png"
    ]

    static ObservableList<Image> bonusesImages = FXCollections.<Image>observableArrayList()

    def static ObservableList<Image> getBonusesImages() {
        return bonusesImages
    }

    public static final int IMAGE_BACKGROUND = 0
    public static final int IMAGE_BAT_LEFT = 1
    public static final int IMAGE_BAT_CENTER = 2
    public static final int IMAGE_BAT_RIGHT = 3
    public static final int IMAGE_BALL_0 = 4
    public static final int IMAGE_BALL_1 = 5
    public static final int IMAGE_BALL_2 = 6
    public static final int IMAGE_BALL_3 = 7
    public static final int IMAGE_BALL_4 = 8
    public static final int IMAGE_BALL_5 = 9
    public static final int IMAGE_LOGO = 10
    public static final int IMAGE_SPLASH_BRICK = 11
    public static final int IMAGE_SPLASH_BRICKSHADOW = 12
    public static final int IMAGE_SPLASH_BREAKER = 13
    public static final int IMAGE_SPLASH_BREAKERSHADOW = 14
    public static final int IMAGE_SPLASH_PRESSANYKEY = 15
    public static final int IMAGE_SPLASH_PRESSANYKEYSHADOW = 16
    public static final int IMAGE_SPLASH_STRIKE = 17
    public static final int IMAGE_SPLASH_STRIKESHADOW = 18
    public static final int IMAGE_SPLASH_SUN = 19
    public static final int IMAGE_READY = 20
    public static final int IMAGE_GAMEOVER = 21

    private static final String[] IMAGES_NAMES = #[
        "background.png",
        "bat/left.png",
        "bat/center.png",
        "bat/right.png",
        "ball/ball0.png",
        "ball/ball1.png",
        "ball/ball2.png",
        "ball/ball3.png",
        "ball/ball4.png",
        "ball/ball5.png",
        "logo.png",
        "splash/brick.png",
        "splash/brickshadow.png",
        "splash/breaker.png",
        "splash/breakershadow.png",
        "splash/pressanykey.png",
        "splash/pressanykeyshadow.png",
        "splash/strike.png",
        "splash/strikeshadow.png",
        "splash/sun.png",
        "ready.png",
        "gameover.png"
    ]

    static ObservableList<Image> images = FXCollections.<Image>observableArrayList()

    def static ObservableList<Image> getImages() {
        return images
    }

    def static void initialize() {
        for (String imageName : IMAGES_NAMES) {
            val image = new Image(Config.getResourceAsStream(IMAGE_DIR+imageName))
            if (image.error) {
                println("Image "+imageName+" not found")
            }
            images += image
        }
        for (String imageName : BRICKS_IMAGES) {
            val url = IMAGE_DIR+"brick/"+imageName
            val image = new Image(Config.getResourceAsStream(url))
            if (image.isError()) {
                println("Image "+url+" not found")
            }
            bricksImages += image
        }
        for (String imageName : BONUSES_IMAGES) {
            val url = IMAGE_DIR+"bonus/"+imageName
            val image = new Image(Config.getResourceAsStream(url))
            if (image.error) {
                println("Image "+url+" not found")
            }
            bonusesImages+=image
        }
    }

    private new() {
        
    }
	
}