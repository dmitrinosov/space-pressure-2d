require daslib/media
require daslib/decs
require daslib/decs_boost

require game_config


[decs (stage=draw)]
def draw_background_es(pos: float2; size: float2)
    fill_rect(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, 0xFF3978FF)

[decs (stage=draw)]
def draw_obj_es(pos: float2; size: float2)
    let halfSize = size * 0.5
    rect(pos.x - halfSize.x, pos.y - halfSize.y, size.x, size.y, 0xFFF11079)