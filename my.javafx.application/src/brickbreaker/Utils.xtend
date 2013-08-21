package brickbreaker

import java.util.Random

class Utils {
	static val RANDOM = new Random

    // Returns random integer number from 0 to max - 1
    def static int random(int max) {
        return (RANDOM.nextDouble() * max) as int
    }

    // Returns sign of the value
    def static int sign(double n) {
    	switch null {
    		case n == 0 : 0
    		case n > 0 : 1
    		default : -1
    	}
    }
}