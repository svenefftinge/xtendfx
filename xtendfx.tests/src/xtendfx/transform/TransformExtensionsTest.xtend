package xtendfx.transform

import javafx.geometry.Point3D
import javafx.scene.transform.Affine
import javafx.scene.transform.Rotate
import javafx.scene.transform.Scale
import javafx.scene.transform.Shear
import javafx.scene.transform.Translate
import org.junit.Test

import static org.junit.Assert.*

import static extension xtendfx.scene.transform.TransformExtensions.*

/**
 * A smoke test for transform extensions.
 * 
 * @author koehnlein
 */
class TransformExtensionsTest {
	@Test
	def testAll() {
		val matrices = #[
			new Translate(1,2), new Translate(1,2,3),
			new Rotate(90), new Rotate(5,6,7), new Rotate(8,9,10,11), 
			new Rotate(12,13,14,15, new Point3D(16,17,18)), new Rotate(19, new Point3D(20,21,22)),
			new Scale(23,24), new Scale(25,26,27), new Scale(28,29,30,31), new Scale(32,33,34,35,36,37),
			new Shear(38,39), new Shear(40,41)
		]
		val operations = <(Affine)=>void> newArrayList(
			[translate(1,2)], [translate(1,2,3)],
			[rotate(90)], [rotate(5,6,7)], [rotate(8,9,10,11)], 
			[rotate(12,13,14,15, new Point3D(16,17,18))], [rotate(19, new Point3D(20,21,22))],
			[scale(23,24)], [scale(25,26,27)], [scale(28,29,30,31)], [scale(32,33,34,35,36,37)],
			[shear(38,39)], [shear(40,41)]
		)
		val vectors = #[
			new Point3D(1,0,0), new Point3D(0,1,0), new Point3D(0,0,1),
			new Point3D(0,1,1), new Point3D(1,0,1), new Point3D(1,1,0)
		]
		for(left: matrices) {
			for(right: matrices) {
				val affine = new Affine()
				affine.leftMultiply(right)
				affine => operations.get(matrices.indexOf(left))
				for(v: vectors) {
			 		assertTrue((left*(right*v)).distance((left*right)*v) < 1e-10)
			 		assertTrue((affine*v).distance(left*right*v) < 1e-10)
				}
			}
		}
	}
}