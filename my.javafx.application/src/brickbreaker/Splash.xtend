package brickbreaker

import javafx.scene.Parent
import javafx.scene.image.ImageView
import javafx.animation.Timeline
import javafx.animation.KeyFrame
import javafx.scene.Group

class Splash extends Parent {

    static final int STATE_SHOW_TITLE = 0
    static final int STATE_SHOW_STRIKE = 1
    static final int STATE_SUN = 2

    static final int SUN_AMPLITUDE_X = Config::SCREEN_WIDTH * 2 / 3
    static final int SUN_AMPLITUDE_Y = Config::SCREEN_WIDTH / 2
    
    ImageView background 
    private ImageView brick
    private ImageView brickShadow
    private ImageView breaker
    private ImageView breakerShadow
    private Timeline timeline
    private int state
    private int stateArg
    private ImageView strike
    private ImageView strikeShadow
    private ImageView pressanykey
    private ImageView pressanykeyShadow
    private ImageView sun
    private ImageView[] NODES
    private ImageView[] NODES_SHADOWS

    def private void initTimeline() {
        timeline = new Timeline()
        timeline.setCycleCount(Timeline::INDEFINITE)
        val kf = new KeyFrame(Config::ANIMATION_TIME, [
        	if (state == STATE_SHOW_TITLE) {
                    stateArg = stateArg + 1
                    val center = Config::SCREEN_WIDTH / 2
                    val offset = (Math::cos(stateArg / 4.0) * (40 - stateArg) / 40 * center) as int
                    brick.setTranslateX(center - brick.getImage().getWidth() / 2 + offset)
                    breaker.setTranslateX(center - breaker.getImage().getWidth() / 2 - offset)
                    if (stateArg == 40) {
                        stateArg = 0
                        state = STATE_SHOW_STRIKE
                    }
                    return
                }
                if (state == STATE_SHOW_STRIKE) {
                    if (stateArg == 0) {
                        strike.setTranslateX(breaker.getTranslateX() + brick.getImage().getWidth())
                        strike.setScaleX(0)
                        strike.setScaleY(0)
                        strike.setVisible(true)
                    }
                    stateArg = stateArg + 1
                    val coef = stateArg / 30f
                    brick.setTranslateX(breaker.getTranslateX() +
                        (breaker.getImage().getWidth() - brick.getImage().getWidth()) / 2f * (1 - coef))
                    strike.setScaleX(coef)
                    strike.setScaleY(coef)
                    strike.setRotate((30 - stateArg) * 2)
                    if (stateArg == 30) {
                        stateArg = 0
                        state = STATE_SUN
                    }
                    return
                }
                // Here state == STATE_SUN
                if (pressanykey.getOpacity() < 1) {
                    pressanykey.setOpacity(pressanykey.getOpacity() + 0.05f)
                }
                stateArg = stateArg - 1
                val x = SUN_AMPLITUDE_X * Math::cos(stateArg / 100.0)
                val y = SUN_AMPLITUDE_Y * Math::sin(stateArg / 100.0)
                if (y < 0) {
                    for ( node : NODES_SHADOWS) {
                        // Workaround RT-1976
                        node.setTranslateX(-1000)
                    }
                    return
                }
                val sunX = Config::SCREEN_WIDTH / 2 + x
                val sunY = Config::SCREEN_HEIGHT / 2 - y
                sun.setTranslateX(sunX - sun.getImage().getWidth() / 2)
                sun.setTranslateY(sunY - sun.getImage().getHeight() / 2)
                sun.setRotate(-stateArg)
                for (i : 0 ..< NODES.length) {
                    NODES_SHADOWS.get(i).setOpacity(y / SUN_AMPLITUDE_Y / 2)
                    NODES_SHADOWS.get(i).setTranslateX(NODES.get(i).getTranslateX() +
                        (NODES.get(i).getTranslateX() + NODES.get(i).getImage().getWidth() / 2 - sunX) / 20)
                    NODES_SHADOWS.get(i).setTranslateY(NODES.get(i).getTranslateY() +
                        (NODES.get(i).getTranslateY() + NODES.get(i).getImage().getHeight() / 2 - sunY) / 20)
                }
        ])
        timeline.getKeyFrames().add(kf)
    }
    
    def void start() {
        background.requestFocus()
        timeline.play()
    }

    def void stop() {
        timeline.stop()
    }

    new() {
        state = STATE_SHOW_TITLE
        stateArg = 0
        initTimeline()
        background = new ImageView()
        background.setFocusTraversable(true)
        background.setImage(Config::getImages().get(Config::IMAGE_BACKGROUND))
        background.setFitWidth(Config::SCREEN_WIDTH)
        background.setFitHeight(Config::SCREEN_HEIGHT)
        background.setOnMousePressed([
        	Main::getMainFrame().startGame()
        	
        ])
        background.setOnKeyPressed( [
        	Main::getMainFrame().startGame()
        ])
        brick = new ImageView()
        brick.setImage(Config::getImages().get(Config::IMAGE_SPLASH_BRICK))
        brick.setTranslateX(-1000)
        brick.setTranslateY(brick.getImage().getHeight())
        brickShadow = new ImageView()
        brickShadow.setImage(Config::getImages().get(Config::IMAGE_SPLASH_BRICKSHADOW))
        brickShadow.setTranslateX(-1000)
        breaker = new ImageView()
        breaker.setImage(Config::getImages().get(Config::IMAGE_SPLASH_BREAKER))
        breaker.setTranslateX(-1000)
        breaker.setTranslateY(brick.getTranslateY() + brick.getImage().getHeight() * 5 / 4)
        breakerShadow = new ImageView()
        breakerShadow.setImage(Config::getImages().get(Config::IMAGE_SPLASH_BREAKERSHADOW))
        breakerShadow.setTranslateX(-1000)
        strike = new ImageView()
        strike.setImage(Config::getImages().get(Config::IMAGE_SPLASH_STRIKE))
        strike.setTranslateY(brick.getTranslateY() -
            (strike.getImage().getHeight() - brick.getImage().getHeight()) / 2)
        strike.setVisible(false)
        pressanykey = new ImageView()
        pressanykey.setImage(Config::getImages().get(Config::IMAGE_SPLASH_PRESSANYKEY))
        pressanykey.setTranslateX((Config::SCREEN_WIDTH - pressanykey.getImage().getWidth()) / 2)
        val y = breaker.getTranslateY() + breaker.getImage().getHeight()
        pressanykey.setTranslateY(y + (Config::SCREEN_HEIGHT - y) / 2)
        pressanykey.setOpacity(0)
        strikeShadow = new ImageView()
        strikeShadow.setImage(Config::getImages().get(Config::IMAGE_SPLASH_STRIKESHADOW))
        strikeShadow.setTranslateX(-1000)
        pressanykeyShadow = new ImageView()
        pressanykeyShadow.setImage(Config::getImages().get(Config::IMAGE_SPLASH_PRESSANYKEYSHADOW))
        pressanykeyShadow.setTranslateX(-1000)
        sun = new ImageView()
        sun.setImage(Config::getImages().get(Config::IMAGE_SPLASH_SUN))
        sun.setTranslateX(-1000)
        NODES = #[brick, breaker, strike, pressanykey]
        NODES_SHADOWS = # [brickShadow, breakerShadow, strikeShadow, pressanykeyShadow]
        val group = new Group()
        group.getChildren().add(background)
        group.getChildren().addAll(NODES_SHADOWS)
        group.getChildren().addAll(NODES)
        group.getChildren().add(sun)
        getChildren().add(group)
    }
}