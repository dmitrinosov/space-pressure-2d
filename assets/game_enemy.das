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


def create_enemy(enemy_type: EnemyType;
                 pos: float2;
                 spawn_idx: int = -1)
    var entityEid = INVALID_ENTITY_ID
    if enemy_type == EnemyType AsteroidSmall00
        entityEid = create_entity <| @(eid, cmp)
            cmp |> set("pos", pos)
            cmp |> set("size", float2(10.0, 10.0) * float(SCALE))
            cmp |> set("speed", 560.0 * float(SCALE))
            cmp |> set("move_dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("Asteroid00"))
            cmp |> set("image_angle", random_float(0.0, 6.28))
            cmp |> set("image_rotate_speed", 2.0 * (random_int(0, 2) == 0 ? -1.0 : 1.0))
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("health", 40.0)
            cmp |> set("damage_fx_timer", 0.0)
            cmp |> set("death_fx_timer", 0.0)
            cmp |> set("death_fx_time", 0.35)
            cmp |> set("spawn_idx", spawn_idx)
            apply_decs_template(
                cmp,
                [[PhysObj
                    damping=96.0,
                    pos=pos,
                    prev_pos=pos]])
    elif enemy_type == EnemyType AsteroidMedium00
        entityEid = create_entity <| @(eid, cmp)
            cmp |> set("pos", pos)
            cmp |> set("size", float2(17.0, 17.0) * float(SCALE))
            cmp |> set("speed", 460.0 * float(SCALE))
            cmp |> set("move_dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("Asteroid00"))
            cmp |> set("image_angle", random_float(0.0, 6.28))
            cmp |> set("image_rotate_speed", 1.5 * (random_int(0, 2) == 0 ? -1.0 : 1.0))
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("health", 65.0)
            cmp |> set("damage_fx_timer", 0.0)
            cmp |> set("death_fx_timer", 0.0)
            cmp |> set("death_fx_time", 0.4)
            cmp |> set("spawn_idx", spawn_idx)
            apply_decs_template(
                cmp,
                [[PhysObj
                    damping=96.0,
                    pos=pos,
                    prev_pos=pos]])
    elif enemy_type == EnemyType AsteroidBig00
        entityEid = create_entity <| @(eid, cmp)
            cmp |> set("pos", pos)
            cmp |> set("size", float2(25.0, 25.0) * float(SCALE))
            cmp |> set("speed", 360.0 * float(SCALE))
            cmp |> set("move_dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("Asteroid00"))
            cmp |> set("image_angle", random_float(0.0, 6.28))
            cmp |> set("image_rotate_speed", -0.5 * (random_int(0, 2) == 0 ? -1.0 : 1.0))
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("health", 100.0)
            cmp |> set("damage_fx_timer", 0.0)
            cmp |> set("death_fx_timer", 0.0)
            cmp |> set("death_fx_time", 0.45)
            cmp |> set("spawn_idx", spawn_idx)
            apply_decs_template(
                cmp,
                [[PhysObj
                    damping=96.0,
                    pos=pos,
                    prev_pos=pos]])
    elif enemy_type == EnemyType Enemy00
        entityEid = create_entity <| @(eid, cmp)
            cmp |> set("pos", pos)
            cmp |> set("size", float2(56.0, 55.0) * 0.25 * float(SCALE))
            cmp |> set("speed", 560.0 * float(SCALE))
            cmp |> set("move_dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("Enemy00"))
            cmp |> set("image_angle", 0.0)
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("health", 60.0)
            cmp |> set("damage_fx_timer", 0.0)
            cmp |> set("death_fx_timer", 0.0)
            cmp |> set("death_fx_time", 0.4)
            cmp |> set("spawn_idx", spawn_idx)
            apply_decs_template(
                cmp,
                [[PhysObj
                    damping=96.0,
                    pos=pos,
                    prev_pos=pos]])
        // Gun
        create_entity <| @(eid, cmp)
            cmp |> set("pos", float2())
            cmp |> set("size", float2(10.0, 10.0))
            cmp |> set("dir", float2(-1.0, 0.0))
            cmp |> set("local_pos", float2(-10.0, 0.0) * float(SCALE))
            cmp |> set("attached_to", entityEid)
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("damage", 30.0)
            cmp |> set("active", true)
            apply_decs_template(
                cmp,
                [[Gun
                    cooldown_time=4.0,
                    cooldown_timer=random_float(0.0, 4.0),
                    projectile_type=ProjectileType EnemyProjectile00]])
    elif enemy_type == EnemyType Enemy01
        entityEid = create_entity <| @(eid, cmp)
            cmp |> set("pos", pos)
            cmp |> set("size", float2(56.0, 55.0) * 0.25 * float(SCALE))
            cmp |> set("speed", 560.0 * float(SCALE))
            cmp |> set("move_dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("Enemy01"))
            cmp |> set("image_angle", 0.0)
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("health", 80.0)
            cmp |> set("damage_fx_timer", 0.0)
            cmp |> set("death_fx_timer", 0.0)
            cmp |> set("death_fx_time", 0.4)
            cmp |> set("spawn_idx", spawn_idx)
            apply_decs_template(
                cmp,
                [[PhysObj
                    damping=96.0,
                    pos=pos,
                    prev_pos=pos]])
        // Gun
        create_entity <| @(eid, cmp)
            cmp |> set("pos", float2())
            cmp |> set("size", float2(45.0, 19.0) * 0.25 * float(SCALE))
            cmp |> set("dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("EnemyGun00"))
            cmp |> set("image_angle", 0.0)
            cmp |> set("local_pos", float2(0.0, 0.0) * float(SCALE))
            cmp |> set("attached_to", entityEid)
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("damage_fx_timer", 0.0)
            cmp |> set("death_fx_timer", 0.0)
            cmp |> set("death_fx_time", 0.4)
            cmp |> set("damage", 30.0)
            cmp |> set("active", true)
            cmp |> set("auto_aim", true)
            apply_decs_template(
                cmp,
                [[Gun
                    cooldown_time=2.0,
                    cooldown_timer=random_float(0.0, 2.0),
                    projectile_type=ProjectileType EnemyProjectile00]])
    elif enemy_type == EnemyType Enemy02
        entityEid = create_entity <| @(eid, cmp)
            cmp |> set("pos", pos)
            cmp |> set("size", float2(56.0, 55.0) * 0.25 * float(SCALE))
            cmp |> set("speed", 460.0 * float(SCALE))
            cmp |> set("move_dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("Enemy02"))
            cmp |> set("image_angle", 0.0)
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("health", 120.0)
            cmp |> set("damage_fx_timer", 0.0)
            cmp |> set("death_fx_timer", 0.0)
            cmp |> set("death_fx_time", 0.4)
            cmp |> set("spawn_idx", spawn_idx)
            apply_decs_template(
                cmp,
                [[PhysObj
                    damping=96.0,
                    pos=pos,
                    prev_pos=pos]])
        // Gun
        create_entity <| @(eid, cmp)
            cmp |> set("pos", float2())
            cmp |> set("size", float2(10.0, 10.0))
            cmp |> set("dir", float2(-1.0, 0.0))
            cmp |> set("local_pos", float2(0.0, 0.0) * float(SCALE))
            cmp |> set("attached_to", entityEid)
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("damage", 20.0)
            cmp |> set("active", true)
            apply_decs_template(
                cmp,
                [[Gun
                    cooldown_time=4.0,
                    cooldown_timer=random_float(0.0, 4.0),
                    projectile_type=ProjectileType EnemyProjectile01,
                    projectile_count=12,
                    attack_sector=(3.14 * 2.0)]])
    elif enemy_type == EnemyType Boss00
        entityEid = create_entity <| @(eid, cmp)
            cmp |> set("pos", pos)
            cmp |> set("size", float2(333.0, 197.0) * 0.35 * float(SCALE))
            cmp |> set("speed", 30.0 * float(SCALE))
            cmp |> set("move_dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("Enemy04"))
            cmp |> set("image_angle", 0.0)
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("health", 3500.0)
            cmp |> set("damage_fx_timer", 0.0)
            cmp |> set("death_fx_timer", 0.0)
            cmp |> set("death_fx_time", 1.0)
            cmp |> set("spawn_idx", spawn_idx)
            cmp |> set("boss_ai", true)
            apply_decs_template(
                cmp,
                [[PhysObj
                    damping=1.0,
                    pos=pos,
                    prev_pos=pos]])

        // Mid Gun
        create_entity <| @(eid, cmp)
            cmp |> set("pos", float2())
            cmp |> set("size", float2(24.0, 32.0) * 0.35 * float(SCALE))
            cmp |> set("dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("Enemy04_MidGun00"))
            cmp |> set("image_angle", 0.0)
            cmp |> set("local_pos", float2(-54.0, 0.0) * float(SCALE))
            cmp |> set("attached_to", entityEid)
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("health", 600.0)
            cmp |> set("damage_fx_timer", 0.0)
            cmp |> set("death_fx_timer", 0.0)
            cmp |> set("death_fx_time", 0.35)
            cmp |> set("damage", 30.0)
            cmp |> set("active", true)
            // cmp |> set("auto_aim", true)
            apply_decs_template(
                cmp,
                [[Gun
                    cooldown_time=5.0,
                    cooldown_timer=random_float(0.0, 2.0),
                    projectile_type=ProjectileType EnemyProjectile00,
                    projectile_count=5,
                    attack_sector=0.5]])

        // Top Gun
        create_entity <| @(eid, cmp)
            cmp |> set("pos", float2())
            cmp |> set("size", float2(50.0, 33.0) * 0.35 * float(SCALE))
            cmp |> set("dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("Enemy04_TopGun00"))
            cmp |> set("image_angle", 0.0)
            cmp |> set("local_pos", float2(-45.0, -11.0) * float(SCALE))
            cmp |> set("attached_to", entityEid)
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("health", 600.0)
            cmp |> set("damage_fx_timer", 0.0)
            cmp |> set("death_fx_timer", 0.0)
            cmp |> set("death_fx_time", 0.35)
            cmp |> set("damage", 30.0)
            cmp |> set("active", true)
            // cmp |> set("auto_aim", true)
            apply_decs_template(
                cmp,
                [[Gun
                    cooldown_time=4.0,
                    cooldown_timer=random_float(0.0, 2.0),
                    projectile_type=ProjectileType EnemyProjectile01,
                    projectile_count=3,
                    attack_sector=0.25]])

        // Bottom Gun
        create_entity <| @(eid, cmp)
            cmp |> set("pos", float2())
            cmp |> set("size", float2(50.0, 33.0) * 0.35 * float(SCALE))
            cmp |> set("dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("Enemy04_BottomGun00"))
            cmp |> set("image_angle", 0.0)
            cmp |> set("local_pos", float2(-45.0, 11.0) * float(SCALE))
            cmp |> set("attached_to", entityEid)
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("health", 600.0)
            cmp |> set("damage_fx_timer", 0.0)
            cmp |> set("death_fx_timer", 0.0)
            cmp |> set("death_fx_time", 0.35)
            cmp |> set("damage", 30.0)
            cmp |> set("active", true)
            // cmp |> set("auto_aim", true)
            apply_decs_template(
                cmp,
                [[Gun
                    cooldown_time=4.0,
                    cooldown_timer=random_float(0.0, 2.0),
                    projectile_type=ProjectileType EnemyProjectile01,
                    projectile_count=3,
                    attack_sector=0.25]])

        // SideGun00
        create_entity <| @(eid, cmp)
            cmp |> set("pos", float2())
            cmp |> set("size", float2(84.0, 22.0) * 0.25 * float(SCALE))
            cmp |> set("dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("Enemy04_SideGun00"))
            cmp |> set("image_angle", 0.0)
            cmp |> set("local_pos", float2(-55.0, -30.0) * float(SCALE))
            cmp |> set("attached_to", entityEid)
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("health", 400.0)
            cmp |> set("damage_fx_timer", 0.0)
            cmp |> set("death_fx_timer", 0.0)
            cmp |> set("death_fx_time", 0.35)
            cmp |> set("damage", 30.0)
            cmp |> set("active", true)
            cmp |> set("auto_aim", true)
            apply_decs_template(
                cmp,
                [[Gun
                    cooldown_time=1.0,
                    cooldown_timer=random_float(0.0, 2.0),
                    projectile_type=ProjectileType EnemyProjectile00,
                    projectile_count=1,
                    attack_sector=0.0]])

        // SideGun01
        create_entity <| @(eid, cmp)
            cmp |> set("pos", float2())
            cmp |> set("size", float2(84.0, 22.0) * 0.25 * float(SCALE))
            cmp |> set("dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("Enemy04_SideGun00"))
            cmp |> set("image_angle", 0.0)
            cmp |> set("local_pos", float2(-48.0, -24.0) * float(SCALE))
            cmp |> set("attached_to", entityEid)
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("health", 400.0)
            cmp |> set("damage_fx_timer", 0.0)
            cmp |> set("death_fx_timer", 0.0)
            cmp |> set("death_fx_time", 0.35)
            cmp |> set("damage", 30.0)
            cmp |> set("active", true)
            cmp |> set("auto_aim", true)
            apply_decs_template(
                cmp,
                [[Gun
                    cooldown_time=1.5,
                    cooldown_timer=random_float(0.0, 2.0),
                    projectile_type=ProjectileType EnemyProjectile00,
                    projectile_count=1,
                    attack_sector=0.0]])

        // SideGun02
        create_entity <| @(eid, cmp)
            cmp |> set("pos", float2())
            cmp |> set("size", float2(84.0, 22.0) * 0.25 * float(SCALE))
            cmp |> set("dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("Enemy04_SideGun00"))
            cmp |> set("image_angle", 0.0)
            cmp |> set("local_pos", float2(-48.0, 24.0) * float(SCALE))
            cmp |> set("attached_to", entityEid)
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("health", 400.0)
            cmp |> set("damage_fx_timer", 0.0)
            cmp |> set("death_fx_timer", 0.0)
            cmp |> set("death_fx_time", 0.35)
            cmp |> set("damage", 30.0)
            cmp |> set("active", true)
            cmp |> set("auto_aim", true)
            apply_decs_template(
                cmp,
                [[Gun
                    cooldown_time=1.5,
                    cooldown_timer=random_float(0.0, 2.0),
                    projectile_type=ProjectileType EnemyProjectile00,
                    projectile_count=1,
                    attack_sector=0.0]])

        // SideGun03
        create_entity <| @(eid, cmp)
            cmp |> set("pos", float2())
            cmp |> set("size", float2(84.0, 22.0) * 0.25 * float(SCALE))
            cmp |> set("dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("Enemy04_SideGun00"))
            cmp |> set("image_angle", 0.0)
            cmp |> set("local_pos", float2(-55.0, 30.0) * float(SCALE))
            cmp |> set("attached_to", entityEid)
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("health", 400.0)
            cmp |> set("damage_fx_timer", 0.0)
            cmp |> set("death_fx_timer", 0.0)
            cmp |> set("death_fx_time", 0.35)
            cmp |> set("damage", 30.0)
            cmp |> set("active", true)
            cmp |> set("auto_aim", true)
            apply_decs_template(
                cmp,
                [[Gun
                    cooldown_time=1.0,
                    cooldown_timer=random_float(0.0, 2.0),
                    projectile_type=ProjectileType EnemyProjectile00,
                    projectile_count=1,
                    attack_sector=0.0]])

        // CentralGun00
        create_entity <| @(eid, cmp)
            cmp |> set("pos", float2())
            cmp |> set("size", float2(84.0, 22.0) * 0.25 * float(SCALE))
            cmp |> set("dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("Enemy04_SideGun00"))
            cmp |> set("image_angle", 0.0)
            cmp |> set("local_pos", float2(-15.0, 0.0) * float(SCALE))
            cmp |> set("attached_to", entityEid)
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("damage_fx_timer", 0.0)
            cmp |> set("death_fx_timer", 0.0)
            cmp |> set("death_fx_time", 0.35)
            cmp |> set("damage", 30.0)
            cmp |> set("active", true)
            cmp |> set("auto_aim", true)
            apply_decs_template(
                cmp,
                [[Gun
                    cooldown_time=1.0,
                    cooldown_timer=random_float(0.0, 2.0),
                    projectile_type=ProjectileType EnemyProjectile00,
                    projectile_count=1,
                    attack_sector=0.0]])



    return entityEid


[decs (stage=update)]
def enemy_borders_es(eid: EntityId;
                     pos: float2;
                     size: float2;
                     player_idx: int)
    if player_idx != ENEMY_INDEX
        return

    if (pos.x + size.x * 0.5) < 0.0
        delete_entity(eid)


[decs (stage=update)]
def boss_ai_es(eid: EntityId;
               pos: float2;
               boss_ai: bool;
           var move_dir: float2)
    var moveDir = move_dir
    moveDir.x = pos.x < float(WINDOW_WIDTH) * 0.85 ? 0.0 : moveDir.x
    if moveDir.y == 0.0
        moveDir.y = -1.0
    elif moveDir.y > 0.0 && pos.y > float(WINDOW_HEIGHT) * 0.75
        moveDir.y = -1.0
    elif moveDir.y < 0.0 && pos.y < float(WINDOW_HEIGHT) * 0.25
        moveDir.y = 1.0

    move_dir = normalize(moveDir)