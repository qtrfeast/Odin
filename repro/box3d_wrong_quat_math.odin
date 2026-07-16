// Compare RotateVector/InvRotateVector/InvMulQuat to expected results.
package main

import "core:fmt"
import "core:math"
import "core:math/linalg"
import b3 "vendor:box3d"

main :: proc() {
	v := b3.Vec3{1, -2, 3}

	rotated := b3.RotateVector(b3.Quat(1), v)
	fmt.printfln("RotateVector(identity, %v) = %v (want %v)", v, rotated, v)

	q := linalg.quaternion_angle_axis_f32(math.PI / 2, b3.Vec3{0, 0, 1})
	x := b3.RotateVector(q, b3.Vec3{1, 0, 0})
	fmt.printfln("RotateVector(90deg about +Z, +X) = %v (want [0 1 0])", x)

	back := b3.InvRotateVector(q, x)
	fmt.printfln("InvRotateVector(q, RotateVector(q, +X)) = %v (want [1 0 0])", back)

	identity := b3.InvMulQuat(q, q)
	fmt.printfln("InvMulQuat(q, q) = (xyz=%v, w=%v) (want xyz=[0 0 0], w=1)", identity.xyz, identity.w)
}
