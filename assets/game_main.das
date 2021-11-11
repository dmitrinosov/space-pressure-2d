require daslib/media
require daslib/decs
require daslib/decs_boost
require strings

require game_config
require game_var
require game_templates
require game_input
require game_phys
require game_draw

options debugger
require daslib/debug


def load_assets()
    return

def game_start()

    // Player
    create_entity <| @(eid, cmp)
        cmp |> set("pos", float2(100.0, 100.0))
        cmp |> set("size", float2(100.0, 100.0))
        apply_decs_template(cmp, [[PlayerInput]])
        apply_decs_template(cmp, [[PhysObj]])

    return

// Runs once when game starts and every hot-reload
[export]
def initialize
    set_font_name("fonts/ARCADECLASSIC.TTF")
    set_font_size(FONT_SIZE)
    set_window_title("SpacePressure3D")
    set_resolution(WIDTH, HEIGHT)
    initialize_game_vars()
    load_assets()
    game_start()
    return

// Called to update game data
[export]
def act(var dt: float)
    game_vars.dt = dt

    decs_stage("input")
    decs_stage("phys_update")
    decs_stage("update")
    return

// Called every frame after 'act'
[export]
def draw
    decs_stage("draw")
    var START = 0
    text_out(0, START, "HIGH", 0xffffffff)
    return


