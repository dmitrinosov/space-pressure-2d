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


[decs (stage=draw)]
def draw_background_es(pos: float2; size: float2)
    let backsCount = 4
    let backHeight = float(WINDOW_HEIGHT)
    let backSize = float2(backHeight, backHeight)
    let backSpeed = 20.0

    for i in range(backsCount)
        let backOffset00 = (-(game_vars.time * backSpeed + backHeight * float(i)) % (backHeight * float(backsCount)) +
                           float(WINDOW_WIDTH))
        let backImageIdx = (i % 2 == 0) ? g_game_back00_image_idx : g_game_back01_image_idx
        draw_image(backImageIdx, float2(backOffset00, 0.0) + backSize * 0.5, backSize, 0.0)


[decs (stage=draw)]
def draw_obj_es(pos: float2;
                size: float2;
                image_idx: int;
                image_angle: float)
    draw_image(image_idx, pos, size, image_angle)

    // let halfSize = size * 0.5
    // rect(pos.x - halfSize.x, pos.y - halfSize.y, size.x, size.y, 0xFFF11079)

/*
[decs (stage=draw)]
def draw_gun_es(pos: float2;
                size: float2;
                gun :Gun)
    let halfSize = size * 0.5
    rect(pos.x - halfSize.x, pos.y - halfSize.y, size.x, size.y, 0xFFF11079)
*/