require daslib/media
require daslib/decs
require daslib/decs_boost
require strings

require game_config
require game_var
require game_templates
require game_assets
require game_input
require game_phys
require game_play
require game_gun
require game_projectile
require game_draw

options debugger
require daslib/debug


// Runs once when game starts and every hot-reload
[export]
def initialize
    set_window_title(WINDOW_TITLE)
    set_resolution(WINDOW_WIDTH, WINDOW_HEIGHT)
    disable_auto_upscale()
    set_antialiasing(0)
    set_vsync_enabled(false)

    restart()

    initialize_game_vars()
    load_assets()
    game_start()
    return


// Called to update game data
[export]
def act(var dt: float)
    game_vars.dt = dt
    game_vars.time += dt
    game_vars.dbg = 0.0

    decs_stage("input")
    update_phys_world(dt)
    decs_stage("update")
    decs_stage("update_play")
    decs_stage("update_gun")
    decs_stage("update_projectile")


// Called every frame after 'act'
[export]
def draw
    enable_alpha_blend()
    decs_stage("draw")
    var START = 0
    text_out(0, START, "{game_vars.dbg}", 0xffffffff)



