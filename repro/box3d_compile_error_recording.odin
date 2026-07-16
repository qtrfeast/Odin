// Demonstrate compile errors in Recording handle usage.
package main

import "core:fmt"
import b3 "vendor:box3d"

main :: proc() {
	world_def := b3.DefaultWorldDef()
	world := b3.CreateWorld(world_def)
	defer b3.DestroyWorld(world)

	rec := b3.CreateRecording(0)
	b3.World_StartRecording(world, rec)
	b3.World_Step(world, 1.0 / 60, 4)
	b3.World_StopRecording(world)

	size := b3.Recording_GetSize(rec)
	data := b3.Recording_GetData(rec)
	fmt.printfln("recorded %d bytes, data=%p", size, data)

	b3.DestroyRecording(rec)
}
