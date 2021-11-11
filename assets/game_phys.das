require daslib/media
require daslib/decs
require daslib/decs_boost

require game_var
require game_templates


[decs (stage=phys_update)]
def phys_update_es(var phys: PhysObj;
                   var pos: float2&)
    let dt = game_vars.dt
    phys.velocity += phys.force * dt
    pos += phys.velocity * dt
    phys.velocity -= phys.velocity * min(1.0, phys.damping * dt)
    phys.force = float2()
