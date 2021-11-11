require daslib/media
require random

struct GameVars
    rand_seed: int4
    dt: float

var game_vars: GameVars


def initialize_game_vars()
    randomize_seed(game_vars.rand_seed)