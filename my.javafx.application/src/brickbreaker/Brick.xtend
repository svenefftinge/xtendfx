package brickbreaker

import javafx.scene.Parent
import javafx.scene.image.ImageView

class Brick extends Parent {

	public static val TYPE_BLUE = 0
	public static val TYPE_BROKEN1 = 1
	public static val TYPE_BROKEN2 = 2
	public static val TYPE_BROWN = 3
	public static val TYPE_CYAN = 4
	public static val TYPE_GREEN = 5
	public static val TYPE_GREY = 6
	public static val TYPE_MAGENTA = 7
	public static val TYPE_ORANGE = 8
	public static val TYPE_RED = 9
	public static val TYPE_VIOLET = 10
	public static val TYPE_WHITE = 11
	public static val TYPE_YELLOW = 12

	@Property int type
	ImageView content

	new(int type) {
		content = new ImageView
		children += content
		this.type = type
		mouseTransparent = true;
	}

	def boolean kick() {
		switch type {
			case TYPE_GREY:
				false
			case TYPE_BROWN: {
				type = TYPE_BROKEN2
				false
			}
			default:
				true
		}
	}

	def private void setType(int newType) {
		_type = newType
		content.image = Config.bricksImages.get(_type)
		content.fitWidth = Config.FIELD_WIDTH / 15
	}

	def static int getBrickType(String s) {
		switch s {
			case "L": TYPE_BLUE
			case "2": TYPE_BROKEN1
			case "B": TYPE_BROWN
			case "C": TYPE_CYAN
			case "G": TYPE_GREEN
			case "0": TYPE_GREY
			case "M": TYPE_MAGENTA
			case "O": TYPE_ORANGE
			case "R": TYPE_RED
			case "V": TYPE_VIOLET
			case "W": TYPE_WHITE
			case "Y": TYPE_YELLOW
			default: {
				println('''Unknown brick type "«s»"''')
				TYPE_WHITE
			}
		}
	}
}
