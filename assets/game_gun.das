require daslib/media
require daslib/decs
require daslib/decs_boost

require game_config
require game_var
require game_templates
require game_projectile


[decs (stage=update_gun)]
def gun_fire_es(eid: EntityId;
                pos: float2;
                dir: float2;
                active: bool;
                player_idx: int;
                damage: float;
                attached_to: EntityId;
            var gun: Gun)
    var isOwnerAlive = false
    query(attached_to) <| $(health: float)
        isOwnerAlive = health > 0.0

    if !isOwnerAlive
        delete_entity(eid)
        return

    if !active
        return

    let dt = game_vars.dt
    if gun.cooldown_timer > 0.0
        gun.cooldown_timer -= dt

    if gun.cooldown_timer <= 0.0
        gun.cooldown_timer = gun.cooldown_time
        create_projectile(gun.projectile_type, pos, dir, player_idx, damage)