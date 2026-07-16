// Demonstrate compile errors in RecPlayer handle usage.
package main

import "core:fmt"
import b3 "vendor:box3d"

main :: proc() {
	world_def := b3.DefaultWorldDef()
	world := b3.CreateWorld(world_def)
	defer b3.DestroyWorld(world)

	body_def := b3.DefaultBodyDef()
	body_def.type = .dynamicBody
	body_def.position = b3.Pos{0, 4, 0}
	body := b3.CreateBody(world, body_def)
	shape_def := b3.DefaultShapeDef()
	sphere := b3.Sphere{center = {0, 0, 0}, radius = 0.5}
	_ = b3.CreateSphereShape(body, shape_def, &sphere)

	rec := b3.CreateRecording(0)
	b3.World_StartRecording(world, rec)
	for _ in 0..<4 {
		b3.World_Step(world, 1.0 / 60, 4)
	}
	b3.World_StopRecording(world)

	size := b3.Recording_GetSize(rec)
	data := b3.Recording_GetData(rec)
	fmt.printfln("recorded %d bytes", size)

	player := b3.RecPlayer_Create(rawptr(data), size, 1)
	if player == nil {
		fmt.println("RecPlayer_Create failed")
		return
	}
	fmt.printfln("frames=%d", b3.RecPlayer_GetFrameCount(player))
	fmt.printfln("stepped=%v", b3.RecPlayer_StepFrame(player))

	b3.RecPlayer_Destroy(player)
	b3.DestroyRecording(rec)
}
