require daslib/media
require daslib/decs
require daslib/decs_boost

require game_config
require game_var
require game_templates
require game_input
require game_phys


def game_start()

    // Player
    let playerPos = float2(WINDOW_WIDTH, WINDOW_HEIGHT) * PLAYER_START_POSITION_RATIO
    var playerEid = create_entity <| @(eid, cmp)
        cmp |> set("pos", playerPos)
        cmp |> set("size", PLAYER_SIZE)
        cmp |> set("speed", PLAYER_SPEED)
        apply_decs_template(cmp, [[PlayerInput]])
        apply_decs_template(
            cmp,
             [[PhysObj
                damping=PLAYER_DAMPING,
                pos=playerPos,
                prev_pos=playerPos]])

    create_entity <| @(eid, cmp)
        cmp |> set("pos", float2())
        cmp |> set("size", float2(10.0, 10.0))
        cmp |> set("local_pos", float2(40.0, 20.0))
        cmp |> set("attached_to", playerEid)
        apply_decs_template(
            cmp,
             [[Gun
                cooldown_time=0.5]])

    return


[decs (stage=phys_post_update)]
def player_game_bounds_es(var phys: PhysObj;
                          size: float2)
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


[decs (stage=update2)]
def update_attached_es(attached_to: EntityId;
                       local_pos: float2;
                   var pos: float2)
    var ownerPos = float2(0.0, 0.0)
    query(attached_to) <| $(pos: float2)
        ownerPos = pos
    pos = ownerPos + local_pos