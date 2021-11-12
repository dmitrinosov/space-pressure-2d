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
require game_enemy
require game_level
require game_draw


// Runs once when game starts and every hot-reload
[export]
def initialize
    set_window_title(WINDOW_TITLE)
    set_resolution(WINDOW_WIDTH, WINDOW_HEIGHT)
    disable_auto_upscale()
    set_antialiasing(0)
    set_vsync_enabled(false)

    decs_stage("clear")

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

    let restart = !game_update(dt)
    if restart
        initialize()
        return

    decs_stage("update")
    decs_stage("update_play")
    decs_stage("update_gun")
    decs_stage("update_projectile")


// Called every frame after 'act'
[export]
def draw
    enable_alpha_blend()

    draw_background()

    decs_stage("draw")
    // text_out(0, 0, "{game_vars.dbg}", 0xffffffff)

    draw_fade()



