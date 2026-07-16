// Demonstrate Recording handle crash via &rec.
package main

import "core:fmt"
import b3 "vendor:box3d"

main :: proc() {
	world_def := b3.DefaultWorldDef()
	world := b3.CreateWorld(world_def)
	defer b3.DestroyWorld(world)

	rec := b3.CreateRecording(0)
	fmt.println("starting recording (forced &rec workaround)...")
	b3.World_StartRecording(world, &rec) // the broken decls force this; C sees garbage
	b3.World_Step(world, 1.0 / 60, 4)
	b3.World_StopRecording(world)
	fmt.printfln("size=%d", b3.Recording_GetSize(rec))
}
