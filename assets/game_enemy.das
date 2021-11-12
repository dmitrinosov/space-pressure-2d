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
                 pos: float2)
    if enemy_type == EnemyType AsteroidSmall00
        create_entity <| @(eid, cmp)
            cmp |> set("pos", pos)
            cmp |> set("size", float2(10.0, 10.0) * float(SCALE))
            cmp |> set("speed", 560.0 * float(SCALE))
            cmp |> set("move_dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("Asteroid00"))
            cmp |> set("image_angle", random_float(0.0, 6.28))
            cmp |> set("image_rotate_speed", 2.0 * (random_int(0, 2) == 0 ? -1.0 : 1.0))
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("health", 40.0)
            cmp |> set("test", 1)
            cmp |> set("damage_fx_timer", 0.0)
            apply_decs_template(
                cmp,
                [[PhysObj
                    damping=96.0,
                    pos=pos,
                    prev_pos=pos]])
    elif enemy_type == EnemyType AsteroidMedium00
        create_entity <| @(eid, cmp)
            cmp |> set("pos", pos)
            cmp |> set("size", float2(17.0, 17.0) * float(SCALE))
            cmp |> set("speed", 460.0 * float(SCALE))
            cmp |> set("move_dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("Asteroid00"))
            cmp |> set("image_angle", random_float(0.0, 6.28))
            cmp |> set("image_rotate_speed", 1.5 * (random_int(0, 2) == 0 ? -1.0 : 1.0))
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("health", 65.0)
            cmp |> set("test", 1)
            cmp |> set("damage_fx_timer", 0.0)
            apply_decs_template(
                cmp,
                [[PhysObj
                    damping=96.0,
                    pos=pos,
                    prev_pos=pos]])
    elif enemy_type == EnemyType AsteroidBig00
        create_entity <| @(eid, cmp)
            cmp |> set("pos", pos)
            cmp |> set("size", float2(25.0, 25.0) * float(SCALE))
            cmp |> set("speed", 360.0 * float(SCALE))
            cmp |> set("move_dir", float2(-1.0, 0.0))
            cmp |> set("sprite_idx", get_sprite_idx("Asteroid00"))
            cmp |> set("image_angle", random_float(0.0, 6.28))
            cmp |> set("image_rotate_speed", -0.5 * (random_int(0, 2) == 0 ? -1.0 : 1.0))
            cmp |> set("player_idx", ENEMY_INDEX)
            cmp |> set("health", 100.0)
            cmp |> set("test", 1)
            cmp |> set("damage_fx_timer", 0.0)
            apply_decs_template(
                cmp,
                [[PhysObj
                    damping=96.0,
                    pos=pos,
                    prev_pos=pos]])

    return INVALID_ENTITY_ID


[decs (stage=update)]
def enemy_borders_es(eid: EntityId;
                     pos: float2;
                     size: float2;
                     player_idx: int)
    if player_idx != ENEMY_INDEX
        return

    if (pos.x + size.x * 0.5) < 0.0
        delete_entity(eid)