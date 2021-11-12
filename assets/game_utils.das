require daslib/media
require daslib/decs
require daslib/decs_boost
require random
require math

require game_config
require game_var
require game_templates


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


def rotate_vector(vec: float2; angle: float)
    let s = sin(angle)
    let c = cos(angle)
    return float2(c * vec.x - s * vec.y, s * vec.x + c * vec.y)


def fract(x: float)
    if x >= 0.0
        return x - floor(x)
    else
        return x - ceil(x)


def fract(v: float2)
    return float2(fract(v.x), fract(v.y))


def random2(st: float2)
    let st2 = float2(
        dot(st, float2(127.1, 311.7)),
        dot(st, float2(269.5, 183.3)))
    return float2(-1.0) + fract(sin(st2) * 43758.543123) * 2.0


def gradient_noise(st: float2)
    let i = floor(st)
    let f = fract(st)

    let u = f * f * (float2(3.0) - 2.0 * f)

    return lerp(
        lerp(dot(random2(i + float2(0.0, 0.0)), f - float2(0.0, 0.0)),
             dot(random2(i + float2(1.0, 0.0)), f - float2(1.0, 0.0)), u.x),
        lerp(dot(random2(i + float2(0.0, 1.0)), f - float2(0.0, 1.0)),
             dot(random2(i + float2(1.0, 1.0)), f - float2(1.0, 1.0)), u.x), u.y)


def delete_unit_entity(eid: EntityId)
    let entityEid = eid
    query() <| $(eid: EntityId;
                attached_to: EntityId)
        if attached_to == entityEid
            delete_unit_entity(eid)
    delete_entity(entityEid)


def start_unit_death_fx(eid: EntityId)
    let entityEid = eid
    query() <| $(eid: EntityId;
                 attached_to: EntityId)
        if attached_to == entityEid
            start_unit_death_fx(eid)
    query(eid) <| $(death_fx_time: float;
                var death_fx_timer: float)
        death_fx_timer = death_fx_time
    query(eid) <| $(score: int)
        game_vars.score += score


def do_damage(eid: EntityId;
              damage: float;
              player_idx: int)
    if eid == INVALID_ENTITY_ID
        return

    if game_vars.game_state != GameState Game
        return

    let DAMAGE_FX_TIME = 0.055
    query(eid) <| $(eid: EntityId;
                var damage_fx_timer: float)
        damage_fx_timer = DAMAGE_FX_TIME
    query() <| $(attached_to: EntityId;
             var damage_fx_timer: float)
        if attached_to == eid
            damage_fx_timer = DAMAGE_FX_TIME

    query(eid) <| $(var health: float)
        if health > 0.0
            health -= damage
            if health <= 0.0
                start_unit_death_fx(eid)


def alpha_test(img: Image; uv: float2)
    let x = floori(uv.x * float(img.width))
    let y = floori(uv.y * float(img.height))
    let p = img |> get_pixel(x, y)
    var a = (p >> 24u) & 0xFFU
    return a > 0u