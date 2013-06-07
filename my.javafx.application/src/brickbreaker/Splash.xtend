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

    static final int SUN_AMPLITUDE_X = Config.SCREEN_WIDTH * 2 / 3
    static final int SUN_AMPLITUDE_Y = Config.SCREEN_WIDTH / 2
    
    ImageView background 
    ImageView brick
    ImageView brickShadow
    ImageView breaker
    ImageView breakerShadow
    Timeline timeline
    int state
    int stateArg
    ImageView strike
    ImageView strikeShadow
    ImageView pressanykey
    ImageView pressanykeyShadow
    ImageView sun
    ImageView[] NODES
    ImageView[] NODES_SHADOWS

    def private void initTimeline() {
        timeline = new Timeline
        timeline.cycleCount = Timeline.INDEFINITE
        val kf = new KeyFrame(Config.ANIMATION_TIME, [
        	if (state == STATE_SHOW_TITLE) {
                    stateArg = stateArg + 1
                    val center = Config.SCREEN_WIDTH / 2
                    val offset = (Math.cos(stateArg / 4.0) * (40 - stateArg) / 40 * center) as int
                    brick.translateX = center - brick.image.width / 2 + offset
                    breaker.translateX = center - breaker.image.width / 2 - offset
                    if (stateArg == 40) {
                        stateArg = 0
                        state = STATE_SHOW_STRIKE
                    }
                    return
                }
                if (state == STATE_SHOW_STRIKE) {
                    if (stateArg == 0) {
                        strike.translateX = breaker.translateX + brick.image.width
                        strike.scaleX = 0
                        strike.scaleY = 0
                        strike.visible = true
                    }
                    stateArg = stateArg + 1
                    val coef = stateArg / 30f
                    brick.translateX = breaker.translateX +
                        (breaker.image.width - brick.image.width) / 2f * (1 - coef)
                    strike.scaleX = coef
                    strike.scaleY = coef
                    strike.rotate = (30 - stateArg) * 2
                    if (stateArg == 30) {
                        stateArg = 0
                        state = STATE_SUN
                    }
                    return
                }
                // Here state == STATE_SUN
                if (pressanykey.opacity < 1) {
                    pressanykey.opacity = pressanykey.opacity + 0.05f
                }
                stateArg = stateArg - 1
                val x = SUN_AMPLITUDE_X * Math.cos(stateArg / 100.0)
                val y = SUN_AMPLITUDE_Y * Math.sin(stateArg / 100.0)
                if (y < 0) {
                    for ( node : NODES_SHADOWS) {
                        // Workaround RT-1976
                        node.translateX = -1000
                    }
                    return
                }
                val sunX = Config.SCREEN_WIDTH / 2 + x
                val sunY = Config.SCREEN_HEIGHT / 2 - y
                sun.translateX = sunX - sun.image.width / 2
                sun.translateY = sunY - sun.image.height / 2
                sun.rotate = -stateArg
                for (i : 0 ..< NODES.length) {
                    NODES_SHADOWS.get(i).opacity = y / SUN_AMPLITUDE_Y / 2
                    NODES_SHADOWS.get(i).translateX = NODES.get(i).translateX +
                        (NODES.get(i).translateX + NODES.get(i).image.width / 2 - sunX) / 20
                    NODES_SHADOWS.get(i).translateY = NODES.get(i).translateY +
                        (NODES.get(i).translateY + NODES.get(i).image.height / 2 - sunY) / 20
                }
        ])
        timeline.keyFrames += kf
    }
    
    def void start() {
        background.requestFocus
        timeline.play
    }

    def void stop() {
        timeline.stop
    }

    new() {
        state = STATE_SHOW_TITLE
        stateArg = 0
        initTimeline
        background = new ImageView => [
	        focusTraversable = true
	        image = Config.getImages().get(Config.IMAGE_BACKGROUND)
	        fitWidth = Config.SCREEN_WIDTH
	        fitHeight = Config.SCREEN_HEIGHT
	        onMousePressed = [
	        	Main.getMainFrame().startGame()
	        	
	        ]
	        onKeyPressed = [
	        	Main.getMainFrame().startGame()
	        ] 
        ]
        
        brick = new ImageView => [
	        image  = Config.getImages().get(Config.IMAGE_SPLASH_BRICK)
	        translateX = -1000
	        translateY = image.height
        ]
        
        brickShadow = new ImageView => [
	        image = Config.getImages().get(Config.IMAGE_SPLASH_BRICKSHADOW)
	        translateX = -1000        	
        ]
        
        
        breaker = new ImageView => [
	        image = Config.getImages().get(Config.IMAGE_SPLASH_BREAKER)
	        translateX = -1000
	        translateY = brick.translateY + brick.image.height * 5 / 4        	
        ]
        
        breakerShadow = new ImageView => [
	        image = Config.getImages().get(Config.IMAGE_SPLASH_BREAKERSHADOW)
	        translateX = -1000	
        ]
        
        strike = new ImageView => [
	        image = Config.getImages().get(Config.IMAGE_SPLASH_STRIKE)
	        translateY = brick.translateY -
	            (image.height - brick.image.height) / 2
	        visible = false        	
        ]
        
        val y = breaker.translateY + breaker.image.height
        
        pressanykey = new ImageView => [
	        image = Config.getImages().get(Config.IMAGE_SPLASH_PRESSANYKEY)
	        translateX = (Config.SCREEN_WIDTH - image.width) / 2
	        translateY = y + (Config.SCREEN_HEIGHT - y) / 2
        	opacity = 0
        ]
        
        strikeShadow = new ImageView => [
	        image = Config.getImages().get(Config.IMAGE_SPLASH_STRIKESHADOW)
	        translateX = -1000	
        ]
        
        pressanykeyShadow = new ImageView => [
	        image = Config.getImages().get(Config.IMAGE_SPLASH_PRESSANYKEYSHADOW)
	        translateX = -1000	
        ]
        
        sun = new ImageView => [
	        image = Config.getImages().get(Config.IMAGE_SPLASH_SUN)
	        translateX = -1000        	
        ]
        
        NODES = #[brick, breaker, strike, pressanykey]
        NODES_SHADOWS = # [brickShadow, breakerShadow, strikeShadow, pressanykeyShadow]
        val group = new Group => [
        	children += background
        	getChildren().addAll(NODES_SHADOWS)
        	getChildren().addAll(NODES)
        	children += sun
        ]
        children += group
    }
}