require daslib/media
require daslib/decs
require daslib/decs_boost

require game_config


[decs (stage=draw)]
def draw_background_es(pos: float2; size: float2)
    fill_rect(0, 0, WIDTH, HEIGHT, 0xFF3978FF)

[decs (stage=draw)]
def draw_obj_es(pos: float2; size: float2)
    fill_rect(pos.x, pos.y, size.x, size.y, 0xFFF11079)