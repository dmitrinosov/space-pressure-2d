require daslib/media
require daslib/decs
require daslib/decs_boost

require game_config
require game_var
require game_templates
require game_input
require game_phys
require game_assets
require game_utils
require game_enemy


def game_start()

    // Player
    let playerPos = float2(WINDOW_WIDTH, WINDOW_HEIGHT) * PLAYER_START_POSITION_RATIO
    var playerEid = create_entity <| @(eid, cmp)
        cmp |> set("pos", playerPos)
        cmp |> set("size", PLAYER_SIZE)
        cmp |> set("speed", PLAYER_SPEED)
        cmp |> set("move_dir", float2())
        cmp |> set("sprite_idx", get_sprite_idx("Player00"))
        cmp |> set("image_angle", 0.0)
        cmp |> set("player_idx", PLAYER_INDEX)
        cmp |> set("health", PLAYER_HEALTH)
        cmp |> set("damage_fx_timer", 0.0)
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
        cmp |> set("player_idx", PLAYER_INDEX)
        cmp |> set("damage", PLAYER_DAMAGE)
        apply_decs_template(
            cmp,
             [[Gun
                cooldown_time=PLAYER_COOLDOWN,
                projectile_type=PLAYER_START_PROJECTILE_TYPE]])

    // Player Bottom Gun
    create_entity <| @(eid, cmp)
        cmp |> set("pos", float2())
        cmp |> set("size", float2(10.0, 10.0))
        cmp |> set("dir", float2(1.0, 0.0))
        cmp |> set("local_pos", float2(12.5, 5.0) * float(SCALE))
        cmp |> set("attached_to", playerEid)
        cmp |> set("player_idx", PLAYER_INDEX)
        cmp |> set("damage", PLAYER_DAMAGE)
        apply_decs_template(
            cmp,
             [[Gun
                cooldown_time=PLAYER_COOLDOWN,
                projectile_type=PLAYER_START_PROJECTILE_TYPE]])

    // Asteroid
    create_enemy(EnemyType AsteroidSmall00, float2(float(WINDOW_WIDTH) * 0.7, float(WINDOW_HEIGHT) * 0.3))
    create_enemy(EnemyType AsteroidBig00, float2(float(WINDOW_WIDTH) * 0.8, float(WINDOW_HEIGHT) * 0.4))
    create_enemy(EnemyType AsteroidMedium00, float2(float(WINDOW_WIDTH) * 0.5, float(WINDOW_HEIGHT) * 0.5))
    create_enemy(EnemyType AsteroidSmall00, float2(float(WINDOW_WIDTH) * 0.6, float(WINDOW_HEIGHT) * 0.6))

    create_enemy(EnemyType AsteroidSmall00, float2(float(WINDOW_WIDTH) * 1.2, float(WINDOW_HEIGHT) * 0.3))
    create_enemy(EnemyType AsteroidBig00, float2(float(WINDOW_WIDTH) * 1.3, float(WINDOW_HEIGHT) * 0.4))
    create_enemy(EnemyType AsteroidMedium00, float2(float(WINDOW_WIDTH) * 1.4, float(WINDOW_HEIGHT) * 0.5))
    create_enemy(EnemyType AsteroidSmall00, float2(float(WINDOW_WIDTH) * 1.5, float(WINDOW_HEIGHT) * 0.6))

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


[decs (stage=update)]
def player_enemy_collision_es(eid: EntityId;
                              pos: float2;
                              size: float2;
                              player_idx: int;
                              input: PlayerInput;
                          var phys: PhysObj)
    let playerPos = pos
    let playerSize = size
    let playerIdx = player_idx

    var enemyEid = INVALID_ENTITY_ID
    var enemyPos = float2()
    query() <| $(eid: EntityId;
                 pos: float2;
                 size: float2;
                 phys: PhysObj;
                 player_idx: int)
        if player_idx == playerIdx
            return

        if check_obj_overlap(playerPos, playerSize,
                             pos, size)
            enemyEid = eid
            enemyPos = pos

    if enemyEid != INVALID_ENTITY_ID
        let toPlayer = playerPos - enemyPos
        normalize(toPlayer)
        phys.velocity += toPlayer * 5.0

        do_damage(eid, PLAYER_COLLISION_DAMAGE, ENEMY_INDEX)


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


[decs (stage=update_play)]
def update_damage_fx_timer_es(var damage_fx_timer: float)
    if damage_fx_timer > 0.0
        damage_fx_timer -= game_vars.dt