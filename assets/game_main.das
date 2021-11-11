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
require game_draw

options debugger
require daslib/debug


// Runs once when game starts and every hot-reload
[export]
def initialize
    set_window_title(WINDOW_TITLE)
    set_resolution(WINDOW_WIDTH, WINDOW_HEIGHT)

    restart()

    initialize_game_vars()
    load_assets()
    game_start()
    return


// Called to update game data
[export, unused_argument(dt)]
def act(var dt: float)
    //game_vars.dt = dt

    decs_stage("input")
    update_phys_world(dt)
    decs_stage("update")
    decs_stage("update2")

// Called every frame after 'act'
[export]
def draw
    decs_stage("draw")
    var START = 0
    text_out(0, START, "{game_vars.dbg}", 0xffffffff)



