require daslib/media
require daslib/decs
require daslib/decs_boost
require random

require game_config
require game_var
require game_templates
require game_assets


def check_rect_overlap(min1: float2;
                       max1: float2;
                       min2: float2;
                       max2: float2)
    return !((max2.x <= min1.x) || (min2.x >= max1.x) || (max2.y <= min1.y) || (min2.y >= max1.y))


def check_obj_overlap(pos1: float2;
                      size1: float2;
                      pos2: float2;
                      size2: float2)
    return check_rect_overlap(pos1 - size1 * 0.5,
                              pos1 + size1 * 0.5,
                              pos2 - size2 * 0.5,
                              pos2 + size2 * 0.5)


def random_int(min, max: int) : int
    return min + random_int(game_vars.rand_seed) % (max - min + 1)


def random_float(min, max: float)
    return min + random_float(game_vars.rand_seed) * (max - min)


def do_damage(eid: EntityId;
              damage: float;
              player_idx: int)
    query(eid) <| $(eid: EntityId;
                var damage_fx_timer: float)
        damage_fx_timer = 0.055
    query(eid) <| $(var health: float)
        health -= damage
        if health < 0.0
            delete_entity(eid)