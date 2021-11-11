require daslib/media
require daslib/decs
require daslib/decs_boost

require game_config
require game_var
require game_templates


struct PhysWorld
    fixed_dt: float
    acc: float
    acc_ratio: float
    steps: int


var phys_world: PhysWorld = [[PhysWorld fixed_dt=PHYS_FIXED_DT]]


def update_phys_world(dt: float)
    decs_stage("phys_pre_update")

    phys_world.acc += dt
    phys_world.steps = floori(phys_world.acc / phys_world.fixed_dt)
    if phys_world.steps > 0
        phys_world.acc -= float(phys_world.steps) * phys_world.fixed_dt
    phys_world.acc_ratio = phys_world.acc / phys_world.fixed_dt

    phys_world.steps = min(phys_world.steps, 32)

    for i in range(phys_world.steps)
        decs_stage("phys_update")

    decs_stage("phys_post_update_play")
    decs_stage("phys_post_update")


[decs (stage=phys_update)]
def phys_fixed_update_es(var phys: PhysObj)
    let dt = phys_world.fixed_dt

    phys.prev_pos = phys.pos
    phys.velocity += phys.force * dt
    phys.pos += phys.velocity * dt
    phys.velocity *= 1.0 / (1.0 + phys.damping * dt)


[decs (stage=update)]
def phys_finish_update_es(var phys: PhysObj)
    phys.force = float2()


[decs (stage=phys_post_update)]
def phys_interpolation_es(phys: PhysObj;
                      var pos: float2&)
    pos = lerp(phys.prev_pos, phys.pos, phys_world.acc_ratio)