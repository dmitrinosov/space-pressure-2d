require daslib/media
require daslib/decs
require daslib/decs_boost

require game_config
require game_var
require game_templates
require game_input
require game_phys
require game_assets


def game_start()

    // Player
    let playerPos = float2(WINDOW_WIDTH, WINDOW_HEIGHT) * PLAYER_START_POSITION_RATIO
    var playerEid = create_entity <| @(eid, cmp)
        cmp |> set("pos", playerPos)
        cmp |> set("size", PLAYER_SIZE)
        cmp |> set("speed", PLAYER_SPEED)
        cmp |> set("move_dir", float2())
        cmp |> set("image_idx", get_image_idx("textures/Player00.png"))
        cmp |> set("image_angle", 0.0)
        apply_decs_template(cmp, [[PlayerInput]])
        apply_decs_template(
            cmp,
             [[PhysObj
                damping=PLAYER_DAMPING,
                pos=playerPos,
                prev_pos=playerPos]])

    // Player Top Gun
    create_entity <| @(eid, cmp)
        cmp |> set("pos", float2())
        cmp |> set("size", float2(10.0, 10.0))
        cmp |> set("dir", float2(1.0, 0.0))
        cmp |> set("local_pos", float2(12.5, -5.0) * float(SCALE))
        cmp |> set("attached_to", playerEid)
        apply_decs_template(
            cmp,
             [[Gun
                cooldown_time=0.5,
                projectile_type=PLAYER_START_PROJECTILE_TYPE]])

    // Player Bottom Gun
    create_entity <| @(eid, cmp)
        cmp |> set("pos", float2())
        cmp |> set("size", float2(10.0, 10.0))
        cmp |> set("dir", float2(1.0, 0.0))
        cmp |> set("local_pos", float2(12.5, 5.0) * float(SCALE))
        cmp |> set("attached_to", playerEid)
        apply_decs_template(
            cmp,
             [[Gun
                cooldown_time=0.5,
                projectile_type=PLAYER_START_PROJECTILE_TYPE]])


    // Asteroid
    let asteroidPos = float2(float(WINDOW_WIDTH) * 0.7, float(WINDOW_HEIGHT) * 0.3)
    create_entity <| @(eid, cmp)
        cmp |> set("pos", asteroidPos)
        cmp |> set("size", float2(25.0, 25.0) * float(SCALE))
        cmp |> set("speed", float2())
        cmp |> set("move_dir", float2())
        cmp |> set("image_idx", get_image_idx("textures/Asteroid00.png"))
        cmp |> set("image_angle", 0.0)
        apply_decs_template(cmp, [[PlayerInput]])
        apply_decs_template(
            cmp,
             [[PhysObj
                damping=PLAYER_DAMPING,
                pos=asteroidPos,
                prev_pos=asteroidPos]])

    return


[decs (stage=phys_post_update_play)]
def player_game_bounds_es(var phys: PhysObj;
                          size: float2;
                          input: PlayerInput)
    let halfSize = size * 0.5
    if phys.pos.x - halfSize.x < 0.0
        phys.pos.x = halfSize.x
        phys.force.x = 0.0
        phys.velocity.x = 0.0
    elif phys.pos.x + halfSize.x > float(WINDOW_WIDTH)
        phys.pos.x = float(WINDOW_WIDTH) - halfSize.x
        phys.force.x = 0.0
        phys.velocity.x = 0.0

    if phys.pos.y - halfSize.y < 0.0
        phys.pos.y = halfSize.y
        phys.force.y = 0.0
        phys.velocity.y = 0.0
    elif phys.pos.y + halfSize.y > float(WINDOW_HEIGHT)
        phys.pos.y = float(WINDOW_HEIGHT) - halfSize.y
        phys.force.y = 0.0
        phys.velocity.y = 0.0


[decs (stage=phys_pre_update)]
def input_force_es(move_dir: float2;
                   speed: float;
               var phys: PhysObj)
    phys.force = move_dir * speed


[decs (stage=update_play)]
def update_attached_es(attached_to: EntityId;
                       local_pos: float2;
                   var pos: float2)
    var ownerPos = float2(0.0, 0.0)
    query(attached_to) <| $(pos: float2)
        ownerPos = pos
    pos = ownerPos + local_pos