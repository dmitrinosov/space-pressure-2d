require daslib/media
require daslib/decs
require daslib/decs_boost


[decs_template]
struct PlayerInput
    up: bool
    down: bool
    left: bool
    right: bool


[decs_template]
struct PhysObj
    force: float2
    velocity: float2
    damping: float