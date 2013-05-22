package brickbreaker

import javafx.scene.Group

class MainFrame { // Instance of scene root node
	Group root

	// Instance of splash (if exists)
	Splash splash

	// Instance of level (if exists)
	Level level

	// Number of lifes
	int lifeCount

	// Current score
	int score

	new(Group root) {
		this.root = root
	}

	def int getState() {
		return state
	}

	def int getScore() {
		return score
	}

	def void setScore(int score) {
		this.score = score
	}

	def int getLifeCount() {
		return lifeCount
	}

	def void increaseLives() {
		lifeCount = Math::min(lifeCount + 1, Config::MAX_LIVES)
	}

	def void decreaseLives() {
		lifeCount = lifeCount - 1
	}

	// Initializes game (lifes, scores etc)
	def void startGame() {
		lifeCount = 3
		score = 0
		changeState(1)
	}

	// Current state of the game. The next values are available
	// 0 - Splash
	public static final int SPLASH = 0

	// 1..Level.LEVEL_COUNT - Level
	int state = SPLASH

	def void changeState(int newState) {
		this.state = newState
		if (splash != null) {
			splash.stop()
		}
		if (level != null) {
			level.stop()
		}
		if (state < 1 || state > LevelData::getLevelsCount()) {
			root.getChildren().remove(level)
			level = null
			splash = new Splash()
			root.getChildren().add(splash)
			splash.start()
		} else {
			root.getChildren().remove(splash)
			splash = null
			level = new Level(state)
			root.getChildren().add(level)
			level.start()
		}
	}

}
