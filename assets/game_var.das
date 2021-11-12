require daslib/media
require daslib/decs
require daslib/decs_boost
require random


enum GameState: int
    None
    FadeIn
    FlyIn
    Game
    FlyOut
    FadeOut
    GameOver


struct GameVars
    rand_seed: int4
    dt: float
    time: float
    level: int
    spawn_index: int
    game_state: GameState
    fade_progress: float
    fly_progress: float
    fly_x: float
    dbg: float

var game_vars: GameVars


def initialize_game_vars()
    game_vars = [[GameVars]]
    randomize_seed(game_vars.rand_seed)