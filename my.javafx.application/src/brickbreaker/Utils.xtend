package brickbreaker

class Utils {
	static final java.util.Random RANDOM = new java.util.Random();

    // Returns random integer number from 0 to max - 1
    def static int random(int max) {
        return (RANDOM.nextDouble() * max) as int;
    }

    // Returns sign of the value
    def static int sign(double n) {
        if (n == 0) {
            return 0;
        }
        if (n > 0) {
            return 1;
        } else {
            return -1;
        }
    }
}