package brickbreaker

import javafx.collections.FXCollections
import javafx.scene.image.Image

import static extension javafx.util.Duration.*

class Config {

	public static val ANIMATION_TIME = 40.millis
	public static val MAX_LIVES = 9

	// Screen info
	public static val FIELD_BRICK_IN_ROW = 15

	public static val IMAGE_DIR = "images/desktop/"

	public static val WINDOW_BORDER_X = 32 // on desktop platform
	public static val WINDOW_BORDER_Y = 24 // on desktop platform
	public static val TITLE_BAR_HEIGHT = 0 // on desktop platform
	public static val SCREEN_WIDTH = 960
	public static val SCREEN_HEIGHT = 720

	public static val INFO_TEXT_SPACE = 10

	// Game field info
	public static val BRICK_WIDTH = 48
	public static val BRICK_HEIGHT = 24
	public static val SHADOW_WIDTH = 10
	public static val SHADOW_HEIGHT = 16

	public static val BALL_MIN_SPEED = 12d
	public static val double BALL_MAX_SPEED = BRICK_HEIGHT
	public static val BALL_MIN_COORD_SPEED = 2d
	public static val BALL_SPEED_INC = 0.5d

	public static val BAT_Y = SCREEN_HEIGHT - 40
	public static val BAT_SPEED = 8

	public static val BONUS_SPEED = 3

	public static val FIELD_WIDTH = FIELD_BRICK_IN_ROW * BRICK_WIDTH
	public static val FIELD_HEIGHT = FIELD_WIDTH
	public static val FIELD_Y = SCREEN_HEIGHT - FIELD_HEIGHT

	static val String[] BRICKS_IMAGES = #[
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

	static val bricksImages = FXCollections.<Image>observableArrayList

	def static getBricksImages() {
		return bricksImages
	}

	static val String[] BONUSES_IMAGES = #[
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

	static val bonusesImages = FXCollections.<Image>observableArrayList()

	def static getBonusesImages() {
		return bonusesImages
	}

	public static val IMAGE_BACKGROUND = image("background.png")
	public static val IMAGE_BAT_LEFT = image("bat/left.png")
	public static val IMAGE_BAT_CENTER = image("bat/center.png")
	public static val IMAGE_BAT_RIGHT = image("bat/right.png")
	public static val IMAGE_BALL_0 = image("ball/ball0.png")
	public static val IMAGE_BALL_1 = image("ball/ball1.png")
	public static val IMAGE_BALL_2 = image("ball/ball2.png")
	public static val IMAGE_BALL_3 = image("ball/ball3.png")
	public static val IMAGE_BALL_4 = image("ball/ball4.png")
	public static val IMAGE_BALL_5 = image("ball/ball5.png")
	public static val IMAGE_LOGO = image("logo.png")
	public static val IMAGE_SPLASH_BRICK = image("splash/brick.png")
	public static val IMAGE_SPLASH_BRICKSHADOW = image("splash/brickshadow.png")
	public static val IMAGE_SPLASH_BREAKER = image("splash/breaker.png")
	public static val IMAGE_SPLASH_BREAKERSHADOW = image("splash/breakershadow.png")
	public static val IMAGE_SPLASH_PRESSANYKEY = image("splash/pressanykey.png")
	public static val IMAGE_SPLASH_PRESSANYKEYSHADOW = image("splash/pressanykeyshadow.png")
	public static val IMAGE_SPLASH_STRIKE = image("splash/strike.png")
	public static val IMAGE_SPLASH_STRIKESHADOW = image("splash/strikeshadow.png")
	public static val IMAGE_SPLASH_SUN = image("splash/sun.png")
	public static val IMAGE_READY = image("ready.png")
	public static val IMAGE_GAMEOVER = image("gameover.png")

	private static def Image image(String imageName) {
		loadImage(IMAGE_DIR + imageName)
	}

	private static def Image loadImage(String imagePath) {
		val image = new Image(Config.getResourceAsStream(imagePath))
		if (image.error) {
			println("Image " + imagePath + " not found")
		}
		return image
	}

	def static void initialize() {
		for (String imageName : BRICKS_IMAGES) {
			bricksImages += loadImage(IMAGE_DIR + "brick/" + imageName)
		}
		for (String imageName : BONUSES_IMAGES) {
			bonusesImages += loadImage(IMAGE_DIR + "bonus/" + imageName)
		}
	}

	private new() {
	}

}
