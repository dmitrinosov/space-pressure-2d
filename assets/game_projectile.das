require daslib/media
require daslib/decs
require daslib/decs_boost

require game_config
require game_var
require game_templates
require game_assets
require game_utils


def create_projectile(projectile_type: ProjectileType;
                      pos: float2;
                      dir: float2;
                      player_idx: int;
                      damage: float)
    var size = float2()
    var speed = 0.0
    var damping = 0.0
    var spriteIdx = 0

    if projectile_type == ProjectileType Projectile00
        size = float2(5.0, 5.0)
        speed = 10000.0
        damping = 256.0
        spriteIdx = get_sprite_idx("Projectile00")
    else
        return INVALID_ENTITY_ID

    return create_entity <| @(eid, cmp)
        cmp |> set("pos", pos)
        cmp |> set("size", size * float(SCALE))
        cmp |> set("move_dir", dir)
        cmp |> set("speed", speed * float(SCALE))
        cmp |> set("sprite_idx", spriteIdx)
        cmp |> set("image_angle", 0.0)
        cmp |> set("player_idx", player_idx)
        cmp |> set("damage", damage)
        apply_decs_template(
            cmp,
            [[Projectile]])
        apply_decs_template(
            cmp,
             [[PhysObj
                damping=damping,
                pos=pos,
                prev_pos=pos]])


[decs (stage=update_projectile)]
def projectile_borders_es(eid: EntityId;
                          projectile: Projectile;
                          size: float2;
                          pos: float2)
    if (pos.x - size.x * 0.5) > float(WINDOW_WIDTH)
        delete_entity(eid)


[decs (stage=update_projectile)]
def projectile_damage_es(eid: EntityId;
                         projectile: Projectile;
                         size: float2;
                         pos: float2;
                         player_idx: int;
                         damage: float)
    let projectilePos = pos
    let projectileSize = size
    let projectilePlayerIndex = player_idx

    var enemyEid = INVALID_ENTITY_ID
    query() <| $(eid: EntityId;
                 pos: float2;
                 size: float2;
                 player_idx: int;
                 health: float)
        if player_idx == projectilePlayerIndex
            return

        if check_obj_overlap(projectilePos,
                             projectileSize,
                             pos,
                             size)
            enemyEid = eid
            return

    if enemyEid != INVALID_ENTITY_ID
        do_damage(enemyEid, damage, projectilePlayerIndex)
        delete_entity(eid)