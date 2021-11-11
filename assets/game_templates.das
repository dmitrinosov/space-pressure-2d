require daslib/media
require daslib/decs
require daslib/decs_boost


require game_config


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
    pos: float2
    prev_pos: float2


[decs_template]
struct Projectile
    tag: int


[decs_template]
struct Gun
    cooldown_time: float
    cooldown_timer: float
    projectile_type: ProjectileType