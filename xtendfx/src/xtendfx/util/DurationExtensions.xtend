package xtendfx.util

import javafx.util.Duration

class DurationExtensions {
	
	def static millis(double d) {
		Duration::millis(d)
	}
	def static seconds(double d) {
		Duration::seconds(d)
	}
	def static minutes(double d) {
		Duration::minutes(d)
	}
	def static hours(double d) {
		Duration::hours(d)
	}
	
	def static operator_multiply(Duration d, double times) {
		d.multiply(times)
	}
	
	def static operator_divide(Duration d, double times) {
		d.divide(times)
	}
	
	def static operator_plus(Duration d, Duration other) {
		d.add(other)
	}
	
	def static operator_minus(Duration d, Duration other) {
		d.subtract(other)
	}
	
	def static operator_not(Duration d) {
		d.negate
	}
}