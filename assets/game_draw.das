require daslib/media
require daslib/decs
require daslib/decs_boost

require game_config
require game_var
require game_assets
require game_templates


def draw_image(image_idx: int; pos: float2; size: float2; angle: float)
    let image& = g_images[image_idx]
    draw_image_transformed(image, pos.x, pos.y,
                           float4(0.0, 0.0, float(image.width), float(image.height)),
                           0xFFFFFFFFu, size, angle, 0.5, 0.5)


def draw_background()
    let backsCount = 4
    let backHeight = float(WINDOW_HEIGHT)
    let backSize = float2(backHeight, backHeight)
    let backSpeed = 20.0

    for i in range(backsCount)
        let backOffset00 = (-(game_vars.time * backSpeed + backHeight * float(i)) % (backHeight * float(backsCount)) +
                           float(WINDOW_WIDTH))
        let backImageIdx = (i % 2 == 0) ? g_game_back00_image_idx : g_game_back01_image_idx
        draw_image(backImageIdx, float2(backOffset00, 0.0) + backSize * 0.5, backSize, 0.0)


def draw_fade()
    if game_vars.fade_progress > 0.0
        fill_rect(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, make_color(0.0, 0.0, 0.0, game_vars.fade_progress))


[decs (stage=update)]
def image_rotate_es(image_rotate_speed:float;
                var image_angle: float&)
    image_angle += image_rotate_speed * game_vars.dt


[decs (stage=draw)]
def draw_obj_es(pos: float2;
                size: float2;
                sprite_idx: int;
                image_angle: float)
    let image_idx = g_game_sprites[sprite_idx].image_idx
    draw_image(image_idx, pos, size, image_angle)

[decs (stage=draw)]
def draw_damage_fx_es(pos: float2;
                      size: float2;
                      sprite_idx: int;
                      image_angle: float;
                      damage_fx_timer: float)
    if damage_fx_timer > 0.0
        let image_idx = g_game_sprites[sprite_idx].damage_image_idx
        draw_image(image_idx, pos, size, image_angle)

/*
[decs (stage=draw)]
def draw_spawn_idx_es(pos: float2;
                      spawn_idx: int)
    text_out(pos.x, pos.y, "{spawn_idx}", 0xffffffff)
*/


[decs (stage=draw)]
def draw_gun_es(pos: float2;
                size: float2;
                gun :Gun)
    let halfSize = size * 0.5
    rect(pos.x - halfSize.x, pos.y - halfSize.y, size.x, size.y, 0xFFF11079)
