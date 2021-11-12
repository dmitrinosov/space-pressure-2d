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
require game_level


def create_player()
    // Player
    let playerPos = float2(-WINDOW_WIDTH, WINDOW_HEIGHT) * PLAYER_START_POSITION_RATIO
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
        cmp |> set("death_fx_timer", 0.0)
        cmp |> set("death_fx_time", 0.5)
        apply_decs_template(cmp, [[PlayerInput]])
        apply_decs_template(
            cmp,
             [[PhysObj
                damping=PLAYER_DAMPING,
                pos=playerPos,
                prev_pos=playerPos]])

    // Player Mid Gun
    create_entity <| @(eid, cmp)
        cmp |> set("pos", float2())
        cmp |> set("size", float2(10.0, 10.0))
        cmp |> set("dir", float2(1.0, 0.0))
        cmp |> set("local_pos", float2(16.5, 0.0) * 0.85 * float(SCALE))
        cmp |> set("attached_to", playerEid)
        cmp |> set("player_idx", PLAYER_INDEX)
        cmp |> set("damage", PLAYER_DAMAGE)
        cmp |> set("active", false)
        cmp |> set("index", 0)
        apply_decs_template(
            cmp,
             [[Gun
                cooldown_time=PLAYER_COOLDOWN * 0.9,
                projectile_type=PLAYER_MID_PROJECTILE_TYPE]])


    // Player Top Gun
    create_entity <| @(eid, cmp)
        cmp |> set("pos", float2())
        cmp |> set("size", float2(10.0, 10.0))
        cmp |> set("dir", float2(1.0, 0.0))
        cmp |> set("local_pos", float2(13.5, -5.0) * 0.85 * float(SCALE))
        cmp |> set("attached_to", playerEid)
        cmp |> set("player_idx", PLAYER_INDEX)
        cmp |> set("damage", PLAYER_DAMAGE)
        cmp |> set("active", false)
        cmp |> set("index", 1)
        apply_decs_template(
            cmp,
             [[Gun
                cooldown_time=PLAYER_COOLDOWN,
                projectile_type=PLAYER_SIDE_PROJECTILE_TYPE]])

    // Player Bottom Gun
    create_entity <| @(eid, cmp)
        cmp |> set("pos", float2())
        cmp |> set("size", float2(10.0, 10.0))
        cmp |> set("dir", float2(1.0, 0.0))
        cmp |> set("local_pos", float2(13.5, 5.0) * 0.85 * float(SCALE))
        cmp |> set("attached_to", playerEid)
        cmp |> set("player_idx", PLAYER_INDEX)
        cmp |> set("damage", PLAYER_DAMAGE)
        cmp |> set("active", false)
        cmp |> set("index", 2)
        apply_decs_template(
            cmp,
             [[Gun
                cooldown_time=PLAYER_COOLDOWN,
                projectile_type=PLAYER_SIDE_PROJECTILE_TYPE]])

def is_player_gun_available(index: int)
    if index == 0
        return game_vars.weapon_level == 0 || game_vars.weapon_level > 1
    else
        return game_vars.weapon_level > 0


def update_player_weapon()
    find_query() <| $(eid: EntityId;
                      input: PlayerInput)
        query() <| $(attached_to: EntityId;
                     index: int;
                 var active: bool)
            if attached_to == eid
                active = is_player_gun_available(index)

def set_player_pos(pos: float2)
    find_query() <| $(eid: EntityId;
                      input: PlayerInput;
                  var phys: PhysObj)
        phys.prev_pos = pos
        phys.pos = pos

def get_player_pos()
    var result = float2()
    find_query() <| $(input: PlayerInput;
                      phys: PhysObj)
        result = phys.pos
    return result

def get_player_health()
    var result = 0.0
    find_query() <| $(input: PlayerInput;
                      health: float)
        result = health
    return result

def activate_player_guns(value: bool)
    find_query() <| $(eid: EntityId;
                      input: PlayerInput)
        query() <| $(attached_to: EntityId;
                 var active: bool)
            if attached_to == eid
                active = value

def game_start()
    create_player()

    game_vars.game_state = GameState FadeIn
    game_vars.fade_progress = 1.0


def game_update(dt: float)

    var gameOver = false

    if game_vars.game_state == GameState FadeIn
        game_vars.fade_progress -= dt * 1.35
        if game_vars.fade_progress <= 0.0
            game_vars.fade_progress = 0.0
            game_vars.game_state = GameState FlyIn
    elif game_vars.game_state == GameState FlyIn
        game_vars.fly_progress += dt * 1.0
        let p = saturate(game_vars.fly_progress)
        let pp = p * p * (3.0 - 2.0 * p)
        let playerPos = float2(lerp(-200.0f * float(SCALE), float(WINDOW_WIDTH) * PLAYER_START_POSITION_RATIO.x, pp),
                               float(WINDOW_HEIGHT) * PLAYER_START_POSITION_RATIO.y)
        set_player_pos(playerPos)
        if game_vars.fly_progress >= 1.0
            game_vars.fly_progress = 1.0
            game_vars.game_state = GameState Game
            update_player_weapon()
    elif game_vars.game_state == GameState Game
        let levelSpawnDataSize = get_level_spawn_data_size(game_vars.level)
        var enemiesSpawned = 0
        while game_vars.spawn_index < levelSpawnDataSize
            let spawnData = get_level_spawn_data(game_vars.level, game_vars.spawn_index)
            if  spawnData.time > game_vars.time
                break
            create_enemy(spawnData.enemy,
                         float2(float(WINDOW_WIDTH) + spawnData.x_offset * float(SCALE),
                                float(WINDOW_HEIGHT) * spawnData.y_ratio),
                         game_vars.spawn_index)
            game_vars.spawn_index++
            enemiesSpawned++

        if enemiesSpawned > 0
            commit()

        let playerHealth = get_player_health()
        if playerHealth <= 0.0
            game_vars.game_state = GameState FadeOut
            return !gameOver

        let allEnemiesSpawned = (game_vars.spawn_index >= levelSpawnDataSize)
        var allEnemiesDead = true
        query() <| $(player_idx: int;
                     health: float;
                     death_fx_timer: float)
            if player_idx != ENEMY_INDEX
                return
            if health > 0.0 || death_fx_timer > 0.0
                allEnemiesDead = false

        if allEnemiesSpawned && allEnemiesDead
            game_vars.game_state = GameState FlyOut
            game_vars.fly_x = get_player_pos().x
            activate_player_guns(false)
    elif game_vars.game_state == GameState FlyOut
        game_vars.fly_progress -= dt * 0.75
        let p = 1.0 - saturate(game_vars.fly_progress)
        let pp = p * p * (3.0 - 2.0 * p)
        let playerPos = float2(lerp(game_vars.fly_x, (float(WINDOW_WIDTH) + 400.0* float(SCALE)), pp),
                               get_player_pos().y)
        set_player_pos(playerPos)
        if game_vars.fly_progress <= 0.0
            game_vars.fly_progress = 0.0
            game_vars.game_state = GameState FadeOut
    elif game_vars.game_state == GameState FadeOut
        game_vars.fade_progress += dt * 1.35
        if game_vars.fade_progress >= 1.0
            game_vars.fade_progress = 1.0
            game_vars.game_state = GameState GameOver
    elif game_vars.game_state == GameState GameOver
        gameOver = true

    return !gameOver


[decs (stage=phys_post_update_play)]
def player_game_bounds_es(var phys: PhysObj;
                          size: float2;
                          input: PlayerInput)
    if game_vars.game_state != GameState Game
        return

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
                          var health: float;
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
                 health: float;
                 player_idx: int)
        if player_idx == playerIdx
            return

        if health <= 0.0
            return

        if check_obj_overlap(playerPos, playerSize,
                             pos, size)
            enemyEid = eid
            enemyPos = pos

    if enemyEid != INVALID_ENTITY_ID
        let toPlayer = normalize(playerPos - enemyPos)
        phys.velocity += toPlayer * 15000.0 * game_vars.dt

        do_damage(eid, PLAYER_COLLISION_DAMAGE, ENEMY_INDEX)

    query() <| $(eid: EntityId;
                 pos: float2;
                 size: float2;
                 phys: PhysObj;
                 health_bonus: float;
                 death_fx_timer: float)
        if death_fx_timer > 0.0
            return
        if check_obj_overlap(playerPos, playerSize,
                             pos, size)
            health = min(health + health_bonus, PLAYER_HEALTH)
            start_unit_death_fx(eid)

    query() <| $(eid: EntityId;
                 pos: float2;
                 size: float2;
                 phys: PhysObj;
                 weapon_bonus: int;
                 death_fx_timer: float)
        if death_fx_timer > 0.0
            return
        if check_obj_overlap(playerPos, playerSize,
                             pos, size)
            game_vars.weapon_level += weapon_bonus
            update_player_weapon()
            start_unit_death_fx(eid)


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


[decs (stage=update_play)]
def update_death_fx_timer_es(eid: EntityId;
                         var death_fx_timer: float)
    if death_fx_timer > 0.0
        death_fx_timer -= game_vars.dt
        if death_fx_timer <= 0.0
            delete_unit_entity(eid)

[decs(stage=clear)]
def clear_all_es(var eid: EntityId)
    delete_entity(eid)