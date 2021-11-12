require daslib/media
require daslib/decs
require daslib/decs_boost

require game_config
require game_var
require game_templates
require game_projectile
require game_utils


[decs (stage=update_gun)]
def gun_fire_es(eid: EntityId;
                pos: float2;
                dir: float2;
                active: bool;
                player_idx: int;
                damage: float;
            var attached_to: EntityId;
            var gun: Gun)
    var isOwnerAlive = false
    query(attached_to) <| $(health: float)
        isOwnerAlive = health > 0.0

    if !isOwnerAlive
        return

    if !active
        return

    let dt = game_vars.dt
    if gun.cooldown_timer > 0.0
        gun.cooldown_timer -= dt

    if gun.cooldown_timer <= 0.0
        gun.cooldown_timer = gun.cooldown_time
        if gun.projectile_count > 1
            var deltaAngle = 0.0
            var deltaSectorStart = 0.0
            if gun.attack_sector >= 3.14 * 2.0
                deltaAngle = gun.attack_sector / float(gun.projectile_count)
                deltaSectorStart = 0.0
            else
                deltaAngle = gun.attack_sector / float(gun.projectile_count - 1)
                deltaSectorStart = -gun.attack_sector / 2.0

            for i in range(gun.projectile_count)
                let angle = deltaSectorStart + float(i) * deltaAngle
                let projectileDir = rotate_vector(dir, angle)
                create_projectile(gun.projectile_type, pos, projectileDir, player_idx, damage)
        else
            create_projectile(gun.projectile_type, pos, dir, player_idx, damage)


[decs (stage=update_gun)]
def gun_auto_aim_es(gun: Gun;
                    pos: float2;
                    player_idx: int;
                    auto_aim: bool;
                var dir: float2)
    if !auto_aim
        return

    let gunPlayerIdx = player_idx
    var enemyEid = INVALID_ENTITY_ID
    var enemyPos = float2()
    query() <| $(eid: EntityId;
                 pos: float2;
                 health: float;
                 player_idx: int)
        if gunPlayerIdx == player_idx
            return
        enemyEid = eid
        enemyPos = pos
    if enemyEid != INVALID_ENTITY_ID
        var toEnemy = normalize(enemyPos - pos)
        dir = normalize(lerp(dir, toEnemy, 4.0 * game_vars.dt))


[decs (stage=update_gun)]
def gun_image_rotation_es(gun: Gun;
                          dir: float2;
                      var image_angle: float)
    image_angle = (dir.y >= 0.0 ? acos(dir.x) : -acos(dir.x))
