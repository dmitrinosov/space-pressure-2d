require daslib/media
require daslib/decs
require daslib/decs_boost

require game_config
require game_var
require game_templates
require game_assets


def create_projectile(projectile_type: ProjectileType;
                      pos: float2;
                      dir: float2)
    var size = float2()
    var speed = 0.0
    var damping = 0.0
    var imageIdx = 0

    if projectile_type == ProjectileType Projectile00
        size = float2(5.0, 5.0)
        speed = 10000.0
        damping = 256.0
        imageIdx = get_image_idx("textures/FXSphere00.png")
    else
        return INVALID_ENTITY_ID

    return create_entity <| @(eid, cmp)
        cmp |> set("pos", pos)
        cmp |> set("size", size * float(SCALE))
        cmp |> set("move_dir", dir)
        cmp |> set("speed", speed * float(SCALE))
        cmp |> set("image_idx", imageIdx)
        cmp |> set("image_angle", 0.0)
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