require daslib/media
require daslib/decs
require daslib/decs_boost
require random


struct GameVars
    rand_seed: int4
    dt: float
    time: float
    dbg: float


var game_vars: GameVars


def initialize_game_vars()
    randomize_seed(game_vars.rand_seed)