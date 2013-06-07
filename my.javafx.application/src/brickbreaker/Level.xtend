package brickbreaker

import java.util.ArrayList
import javafx.animation.KeyValue
import javafx.animation.Timeline
import javafx.application.Platform
import javafx.scene.Group
import javafx.scene.Parent
import javafx.scene.image.Image
import javafx.scene.image.ImageView
import javafx.scene.input.KeyCode
import javafx.scene.paint.Color
import javafx.scene.shape.Rectangle

import static brickbreaker.Main.*

import static extension xtendfx.animation.TimelineExtensions.*
import static extension xtendfx.util.DurationExtensions.*

class Level extends Parent {

	static val MOB_SCALING = 1.5f

    ArrayList<Brick> bricks 
    private int brickCount
    private ArrayList<Brick> fadeBricks
    private ArrayList<Bonus> bonuses 
    private Group group
    private ArrayList<Bonus> lives
    private int catchedBonus

    // States
    // 0 - starting level
    // 1 - ball is catched
    // 2 - playing
    // 3 - game over
    static val STARTING_LEVEL = 0
    static val BALL_CATCHED = 1
    static val PLAYING = 2
    static val GAME_OVER = 3

    int state
    int batDirection
    double ballDirX
    double ballDirY
    int levelNumber
    Bat bat
    Ball ball
//    Text roundCaption
//    Text round
//    Text scoreCaption
//    Text score
//    Text livesCaption
    ImageView message
    Timeline startingTimeline
    Timeline timeline
    Group infoPanel

    new(int levelNumber) {
        children += group = new Group 
        initContent(levelNumber)
    }
	
	private def void initStartingTimeline() {
		startingTimeline = Timeline [
			at (500.millis, [
				message.visible = true
	            state = STARTING_LEVEL
	            bat.visible = false
	            ball.visible = false
			], new KeyValue(message.opacityProperty, 0))
			
			at (1500.millis, new KeyValue(message.opacityProperty, 1))
			at (3000.millis, new KeyValue(message.opacityProperty, 1))
			at (4000.millis, [ 
	        	message.visible = false
	            bat.translateX = (Config.FIELD_WIDTH - bat.width) / 2.0
	            ball.translateX = (Config.FIELD_WIDTH - ball.diameter) / 2.0
	            ball.translateY = Config.BAT_Y - ball.diameter
	            ballDirX = (Utils.random(2) * 2 - 1) * Config.BALL_MIN_COORD_SPEED
	            ballDirY = -Config.BALL_MIN_SPEED
	
	            bat.visible = true
	            ball.visible = true
	            state = BALL_CATCHED
	        ], new KeyValue(message.opacityProperty, 0))
		]
	}

    private def void initTimeline() {
        timeline = Timeline [
        	cycleCount = Timeline.INDEFINITE
        	at (Config.ANIMATION_TIME, [
        		// Process fadeBricks
                val brickIterator = fadeBricks.iterator()
                while (brickIterator.hasNext) {
                    val brick = brickIterator.next
                    brick.opacity = brick.opacity - 0.1
                    if (brick.opacity <= 0) {
                        brick.visible = false
                        brickIterator.remove
                    }
                }
                // Move bat if needed
                if (batDirection != 0 && state != STARTING_LEVEL) {
                    moveBat(bat.translateX + batDirection)
                }
                // Process bonuses
                val bonusIterator = bonuses.iterator
                while (bonusIterator.hasNext) {
                    val bonus = bonusIterator.next
                    if (bonus.getTranslateY() > Config.SCREEN_HEIGHT) {
                        bonus.visible = false
                        bonusIterator.remove()
                        group.getChildren().remove(bonus)
                    } else {
                        bonus.setTranslateY(bonus.getTranslateY() + Config.BONUS_SPEED)
                        if (bonus.getTranslateX() + bonus.getWidth() > bat.getTranslateX() &&
                                bonus.getTranslateX() < bat.getTranslateX() + bat.getWidth() &&
                                bonus.getTranslateY() + bonus.getHeight() > bat.getTranslateY() &&
                                bonus.getTranslateY() < bat.getTranslateY() + bat.getHeight()) {
                            // Bonus is catched
                            updateScore(100)
                            catchedBonus = bonus.getType()
                            bonus.visible = false
                            bonusIterator.remove()
                            group.getChildren().remove(bonus)
                            if (bonus.getType() == Bonus.TYPE_SLOW) {
                                ballDirX = ballDirX / 1.5
                                ballDirY = ballDirY / 1.5
                                correctBallSpeed()
                            } else if (bonus.getType() == Bonus.TYPE_FAST) {
                                ballDirX = ballDirX * 1.5
                                ballDirY = ballDirY * 1.5
                                correctBallSpeed()
                            } else if (bonus.getType() == Bonus.TYPE_GROW_BAT) {
                                if (bat.getSize() < Bat.MAX_SIZE) {
                                    bat.size = bat.size + 1
                                    if (bat.getTranslateX() + bat.getWidth() > Config.FIELD_WIDTH) {
                                        bat.setTranslateX(Config.FIELD_WIDTH - bat.getWidth())
                                    }
                                }
                            } else if (bonus.getType() == Bonus.TYPE_REDUCE_BAT) {
                                if (bat.getSize() > 0) {
                                    val oldWidth = bat.getWidth()
                                    bat.size = bat.size - 1
                                    bat.setTranslateX(bat.getTranslateX() + ((oldWidth - bat.getWidth()) / 2))
                                }
                            } else if (bonus.getType() == Bonus.TYPE_GROW_BALL) {
                                if (ball.getSize() < Ball.MAX_SIZE) {
                                    ball.size = ball.getSize() + 1
                                    if (state == BALL_CATCHED) {
                                        ball.setTranslateY(Config.BAT_Y - ball.getDiameter())
                                    }
                                }
                            } else if (bonus.getType() == Bonus.TYPE_REDUCE_BALL) {
                                if (ball.getSize() > 0) {
                                    ball.size = ball.getSize() - 1
                                    if (state == BALL_CATCHED) {
                                        ball.setTranslateY(Config.BAT_Y - ball.getDiameter())
                                    }
                                }
                            } else if (bonus.getType() == Bonus.TYPE_LIFE) {
                                mainFrame.increaseLives()
                                updateLives()
                            }
                        }
                    }
                }
                if (state != PLAYING) {
                    return
                }
                var newX = ball.getTranslateX() + ballDirX
                var newY = ball.getTranslateY() + ballDirY
                var inverseX = false
                var inverseY = false
                if (newX < 0) {
                    newX = -newX
                    inverseX = true
                }
                val BALL_MAX_X = Config.FIELD_WIDTH - ball.getDiameter()
                if (newX > BALL_MAX_X) {
                    newX = BALL_MAX_X - (newX - BALL_MAX_X)
                    inverseX = true
                }
                if (newY < Config.FIELD_Y) {
                    newY = 2 * Config.FIELD_Y - newY
                    inverseY = true
                }
                // Determine hit bat and ball
                if (ballDirY > 0 &&
                        ball.getTranslateY() + ball.getDiameter() < Config.BAT_Y &&
                        newY + ball.getDiameter() >= Config.BAT_Y &&
                        newX >= bat.getTranslateX() - ball.getDiameter() &&
                        newX < bat.getTranslateX() + bat.getWidth() + ball.getDiameter()) {
                    inverseY = true
                    // Speed up ball
                    val speed = Math.sqrt(ballDirX * ballDirX + ballDirY * ballDirY)
                    ballDirX = ballDirX * (speed + Config.BALL_SPEED_INC) / speed
                    ballDirY = ballDirY * (speed + Config.BALL_SPEED_INC) / speed
                    // Correct ballDirX and ballDirY
                    val offsetX = newX + ball.getDiameter() / 2 - bat.getTranslateX() - bat.getWidth() / 2
                    // Don't change direction if center of bat was used
                    if (Math.abs(offsetX) > bat.getWidth() / 4) {
                        ballDirX = ballDirX + offsetX / 5
                        val MAX_COORD_SPEED = Math.sqrt(speed * speed -
                            Config.BALL_MIN_COORD_SPEED * Config.BALL_MIN_COORD_SPEED)
                        if (Math.abs(ballDirX) > MAX_COORD_SPEED) {
                            ballDirX = Utils.sign(ballDirX) * MAX_COORD_SPEED
                        }
                        ballDirY = Utils.sign(ballDirY) *
                            Math.sqrt(speed * speed - ballDirX * ballDirX)
                    }
                    correctBallSpeed()
                    if (catchedBonus == Bonus.TYPE_CATCH) {
                        newY = Config.BAT_Y - ball.getDiameter()
                        state = BALL_CATCHED
                    }
                }
                // Determine hit ball and brick
                var firstCol = (newX / Config.BRICK_WIDTH) as int
                var secondCol = ((newX + ball.getDiameter()) / Config.BRICK_WIDTH) as int
                var firstRow = ((newY - Config.FIELD_Y) / Config.BRICK_HEIGHT) as int
                var secondRow = ((newY - Config.FIELD_Y + ball.getDiameter()) / Config.BRICK_HEIGHT) as int
                if (ballDirX > 0) {
                    val temp = secondCol
                    secondCol = firstCol
                    firstCol = temp
                }
                if (ballDirY > 0) {
                    val temp = secondRow
                    secondRow = firstRow
                    firstRow = temp
                }
                val vertBrick = getBrick(firstRow, secondCol)
                val horBrick = getBrick(secondRow, firstCol)
                if (vertBrick != null) {
                    kickBrick(firstRow, secondCol)
                    if (catchedBonus != Bonus.TYPE_STRIKE) {
                        inverseY = true
                    }
                }
                if (horBrick != null &&
                        (firstCol != secondCol || firstRow != secondRow)) {
                    kickBrick(secondRow, firstCol)
                    if (catchedBonus != Bonus.TYPE_STRIKE) {
                        inverseX = true
                    }
                }
                if (firstCol != secondCol || firstRow != secondRow) {
                    val diagBrick = getBrick(firstRow, firstCol)
                    if (diagBrick != null && diagBrick != vertBrick &&
                            diagBrick != horBrick) {
                        kickBrick(firstRow, firstCol)
                        if (vertBrick == null && horBrick == null &&
                                catchedBonus != Bonus.TYPE_STRIKE) {
                            inverseX = true
                            inverseY = true
                        }
                    }
                }
                ball.translateX = newX
                ball.translateY = newY
                if (inverseX) {
                    ballDirX = - ballDirX
                }
                if (inverseY) {
                    ballDirY = - ballDirY
                }
                if (ball.getTranslateY() > Config.SCREEN_HEIGHT) {
                    // Ball was lost
                    lostLife
                }
        	])
        ]
    }

    def void start() {
        startingTimeline.play()
        timeline.play()
        group.getChildren().get(0).requestFocus()
        updateScore(0)
        updateLives()
    }

    def void stop() {
        startingTimeline.stop()
        timeline.stop()
    }

    def private void initLevel() {
        val level = LevelData.getLevelData(levelNumber)
        for (row: 0 ..< level.length) {
            for (col : 0 ..< Config.FIELD_BRICK_IN_ROW) {
                val rowString = level.get(row)
                var Brick brick = null
                if (rowString != null && col < rowString.length()) {
                    val type = rowString.substring(col, col + 1)
                    if (!type.equals(" ")) {
                        brick = new Brick(Brick.getBrickType(type))
                        brick.setTranslateX(col * Config.BRICK_WIDTH)
                        brick.setTranslateY(Config.FIELD_Y + row * Config.BRICK_HEIGHT)
                        if (brick.getType() != Brick.TYPE_GREY) {
                            brickCount = brickCount + 1
                        }
                    }
                }
                bricks.add(brick)
            }
        }
    }

    def private Brick getBrick(int row, int col) {
        val i = row * Config.FIELD_BRICK_IN_ROW + col
        if (col < 0 || col >= Config.FIELD_BRICK_IN_ROW || row < 0 || i >= bricks.size()) {
            return null
        } else {
            return bricks.get(i)
        }
    }

    def private void updateScore(int inc) {
        mainFrame.setScore(mainFrame.getScore() + inc)
//        score.setText(mainFrame.getScore() + "")
    }

    def private void moveBat(double newX) {
        var x = newX
        if (x < 0) {
            x = 0
        }
        if (x + bat.getWidth() > Config.FIELD_WIDTH) {
            x = Config.FIELD_WIDTH - bat.getWidth()
        }
        if (state == BALL_CATCHED) {
            var ballX = ball.getTranslateX() + x - bat.getTranslateX()
            if (ballX < 0) {
                ballX = 0
            }
            var BALL_MAX_X = Config.FIELD_WIDTH - ball.getDiameter()
            if (ballX > BALL_MAX_X) {
                ballX = BALL_MAX_X
            }
            ball.setTranslateX(ballX)
        }
        bat.setTranslateX(x)
    }

    def private void kickBrick(int row, int col) {
        val brick = getBrick(row, col)
        if (brick == null || (catchedBonus != Bonus.TYPE_STRIKE && !brick.kick())) {
            return
        }
        updateScore(10)
        if (brick.getType() != Brick.TYPE_GREY) {
            brickCount = brickCount - 1
            if (brickCount == 0) {
                mainFrame.changeState(mainFrame.getState() + 1)
            }
        }
        bricks.set(row * Config.FIELD_BRICK_IN_ROW + col, null)
        fadeBricks.add(brick)
        if (Utils.random(8) == 0 && bonuses.size() < 5) {
            val bonus = new Bonus(Utils.random(Bonus.COUNT))
            bonus.setTranslateY(brick.getTranslateY())
            bonus.setVisible(true)
            bonus.setTranslateX(brick.getTranslateX() + (Config.BRICK_WIDTH - bonus.getWidth()) / 2)
            group.getChildren().add(bonus)
            bonuses.add(bonus)
        }
    }

    def private void updateLives() {
        while (lives.size() > mainFrame.getLifeCount()) {
            val lifeBat = lives.get(lives.size() - 1)
            lives.remove(lifeBat)
            infoPanel.getChildren().remove(lifeBat)
        }
        // Add lifes (but no more than 9)
        val maxVisibleLifes = 9
        val scale = 0.8

        for (life : lives.size() ..< Math.min(mainFrame.getLifeCount(), maxVisibleLifes)) {
            val lifeBonus = new Bonus(Bonus.TYPE_LIFE)
            lifeBonus.setScaleX(scale)
            lifeBonus.setScaleY(scale)
            lifeBonus.setTranslateX(57.0 + (life % 3) * lifeBonus.getWidth())
            lifeBonus.setTranslateY(200.0 +
                (life / 3) * lifeBonus.getHeight() * MOB_SCALING)
            lives.add(lifeBonus)
            infoPanel.getChildren().add(lifeBonus)
        }
    }

    def private void correctBallSpeed() {
        var speed = Math.sqrt(ballDirX * ballDirX + ballDirY * ballDirY)
        if (speed > Config.BALL_MAX_SPEED) {
            ballDirX = ballDirX * Config.BALL_MAX_SPEED / speed
            ballDirY = ballDirY * Config.BALL_MAX_SPEED / speed
            speed = Config.BALL_MAX_SPEED
        }
        if (speed < Config.BALL_MIN_SPEED) {
            ballDirX = ballDirX * Config.BALL_MIN_SPEED / speed
            ballDirY = ballDirY * Config.BALL_MIN_SPEED / speed
            speed = Config.BALL_MIN_SPEED
        }
        if (Math.abs(ballDirX) < Config.BALL_MIN_COORD_SPEED) {
            ballDirX = Utils.sign(ballDirX) * Config.BALL_MIN_COORD_SPEED
            ballDirY = Utils.sign(ballDirY) * Math.sqrt(speed * speed - ballDirX * ballDirX)
        } else if (Math.abs(ballDirY) < Config.BALL_MIN_COORD_SPEED) {
            ballDirY = Utils.sign(ballDirY) * Config.BALL_MIN_COORD_SPEED
            ballDirX = Utils.sign(ballDirX) * Math.sqrt(speed * speed - ballDirY * ballDirY)
        }
    }

    def private void lostLife() {
        mainFrame.decreaseLives()
        if (mainFrame.getLifeCount() < 0) {
            state = GAME_OVER
            ball.visible = false
            bat.visible = false
            message.setImage(Config.images.get(Config.IMAGE_GAMEOVER))
            message.setTranslateX((Config.FIELD_WIDTH - message.getImage().getWidth()) / 2)
            message.setTranslateY(Config.FIELD_Y +
                (Config.FIELD_HEIGHT - message.getImage().getHeight()) / 2)
            message.setVisible(true)
            message.setOpacity(1)
        } else {
            updateLives()
            bat.size = Bat.DEFAULT_SIZE
            ball.size = Ball.DEFAULT_SIZE
            bat.setTranslateX((Config.FIELD_WIDTH - bat.getWidth()) / 2)
            ball.setTranslateX(Config.FIELD_WIDTH / 2 - ball.getDiameter() / 2)
            ball.setTranslateY(Config.BAT_Y - ball.getDiameter())
            state = BALL_CATCHED
            catchedBonus = 0
            ballDirX = (Utils.random(2) * 2 - 1) * Config.BALL_MIN_COORD_SPEED
            ballDirY = - Config.BALL_MIN_SPEED
        }
    }

    def private void initInfoPanel() {
        infoPanel = new Group()
//        roundCaption = new Text()
//        roundCaption.setText("ROUND")
//        roundCaption.setTextOrigin(VPos.TOP)
//        roundCaption.setFill(Color.rgb(51, 102, 51))
//        Font f = new Font("Impact", 18)
//        roundCaption.setFont(f)
//        roundCaption.setTranslateX(30)
//        roundCaption.setTranslateY(128)
//        round = new Text()
//        round.setTranslateX(roundCaption.getTranslateX() +
//            roundCaption.getBoundsInLocal().getWidth() + Config.INFO_TEXT_SPACE)
//        round.setTranslateY(roundCaption.getTranslateY())
//        round.setText(levelNumber + "")
//        round.setTextOrigin(VPos.TOP)
//        round.setFont(f)
//        round.setFill(Color.rgb(0, 204, 102))
//        scoreCaption = new Text()
//        scoreCaption.setText("SCORE")
//        scoreCaption.setFill(Color.rgb(51, 102, 51))
//        scoreCaption.setTranslateX(30)
//        scoreCaption.setTranslateY(164)
//        scoreCaption.setTextOrigin(VPos.TOP)
//        scoreCaption.setFont(f)
//        score = new Text()
//        score.setTranslateX(scoreCaption.getTranslateX() +
//            scoreCaption.getBoundsInLocal().getWidth() + Config.INFO_TEXT_SPACE)
//        score.setTranslateY(scoreCaption.getTranslateY())
//        score.setFill(Color.rgb(0, 204, 102))
//        score.setTextOrigin(VPos.TOP)
//        score.setFont(f)
//        score.setText("")
//        livesCaption = new Text()
//        livesCaption.setText("LIFE")
//        livesCaption.setTranslateX(30)
//        livesCaption.setTranslateY(200)
//        livesCaption.setFill(Color.rgb(51, 102, 51))
//        livesCaption.setTextOrigin(VPos.TOP)
//        livesCaption.setFont(f)
//        val INFO_LEGEND_COLOR = Color.rgb(0, 114, 188)
        val infoWidth = Config.SCREEN_WIDTH - Config.FIELD_WIDTH
        val black = new Rectangle()
        black.setWidth(infoWidth)
        black.setHeight(Config.SCREEN_HEIGHT)
        black.setFill(Color.BLACK)
        val verLine = new ImageView()
        verLine.setImage(new Image(typeof(Level).getResourceAsStream(Config.IMAGE_DIR+"vline.png")))
        verLine.setTranslateX(3)
        val logo = new ImageView()
        logo.setImage(Config.images.get(Config.IMAGE_LOGO))
        logo.setTranslateX(30)
        logo.setTranslateY(30)
//        Text legend = new Text()
//        legend.setTranslateX(30)
//        legend.setTranslateY(310)
//        legend.setText("LEGEND")
//        legend.setFill(INFO_LEGEND_COLOR)
//        legend.setTextOrigin(VPos.TOP)
//        legend.setFont(new Font("Impact", 18))
        infoPanel.getChildren().addAll(black, verLine, logo/*, roundCaption,
                round, scoreCaption, score, livesCaption, legend*/)
        for (i : 0 ..< Bonus.COUNT) {
            val bonus = new Bonus(i)
//            Text text = new Text()
//            text.setTranslateX(100)
//            text.setTranslateY(350 + i * 40)
//            text.setText(Bonus.NAMES[i])
//            text.setFill(INFO_LEGEND_COLOR)
//            text.setTextOrigin(VPos.TOP)
//            text.setFont(new Font("Arial", 12))
            bonus.setTranslateX(30 + (820 - 750 - bonus.getWidth()) / 2)
            bonus.setTranslateY(350 + i * 40 -
                (bonus.getHeight()/* - text.getBoundsInLocal().getHeight()*/) / 2)
            // Workaround JFXC-2379
            infoPanel.getChildren().addAll(bonus) //, text)
        }
        infoPanel.setTranslateX(Config.FIELD_WIDTH)
    }

    def private void initContent(int level) {
        catchedBonus = 0
        state = STARTING_LEVEL
        batDirection = 0
        levelNumber = level
        lives = new ArrayList<Bonus>()
        bricks = new ArrayList<Brick>()
        fadeBricks = new ArrayList<Brick>()
        bonuses = new ArrayList<Bonus>()
        ball = new Ball()
        ball.visible = false
        bat = new Bat()
        bat.setTranslateY(Config.BAT_Y)
        bat.visible = false
        message = new ImageView()
        message.setImage(Config.images.get(Config.IMAGE_READY))
        message.setTranslateX((Config.FIELD_WIDTH - message.getImage().getWidth()) / 2)
        message.setTranslateY(Config.FIELD_Y +
            (Config.FIELD_HEIGHT - message.getImage().getHeight()) / 2)
        message.visible = false
        initLevel
        initStartingTimeline
        initTimeline
        initInfoPanel
        group.children += new ImageView => [
	        focusTraversable = true
	        image = Config.images.get(Config.IMAGE_BACKGROUND)
	        fitWidth = Config.SCREEN_WIDTH
	        fitHeight = Config.SCREEN_HEIGHT
	        onMouseMoved = [moveBat(x - bat.width / 2)]
	        onMouseDragged = [moveBat(x - bat.width / 2)]
	        onMousePressed = [
	        	if (state == PLAYING) {
                    // Support touch-only devices like some mobile phones
                    moveBat(x - bat.width / 2)
                }
                if (state == BALL_CATCHED) {
                    state = PLAYING
                }
                if (state == GAME_OVER) {
                    mainFrame.changeState(MainFrame.SPLASH)
                }
	        ]
	        onKeyPressed = [
	        	if ((code === KeyCode.POWER) || (code === KeyCode.X)) {
                    Platform.exit
                }
                if (state == BALL_CATCHED && (code == KeyCode.SPACE ||
                        code == KeyCode.ENTER || code == KeyCode.PLAY)) {
                    state = PLAYING
                }
                if (state == GAME_OVER) {
                    mainFrame.changeState(MainFrame.SPLASH)
                }
                if (state == PLAYING && code == KeyCode.Q) {
                    // Lost life
                    lostLife()
                    return
                }
                if ((code == KeyCode.LEFT || code == KeyCode.TRACK_PREV)) {
                    batDirection = - Config.BAT_SPEED
                }
                if ((code == KeyCode.RIGHT || code == KeyCode.TRACK_NEXT)) {
                    batDirection = Config.BAT_SPEED
                }
	        ]
	        onKeyReleased = [
	        	if (code == KeyCode.LEFT || code == KeyCode.RIGHT ||
                    code == KeyCode.TRACK_PREV || code == KeyCode.TRACK_NEXT) {
                    batDirection = 0
                }
	        ]
        ]
        for (row : 0 ..< bricks.size()/Config.FIELD_BRICK_IN_ROW) {
            for (col : 0 ..< Config.FIELD_BRICK_IN_ROW) {
                val b = getBrick(row, col)
                if (b != null) { //tmp
                    group.children += b
                }
            }
        }

        group.children.addAll(message, ball, bat, infoPanel)
    }
}
