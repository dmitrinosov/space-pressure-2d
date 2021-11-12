require daslib/media
require daslib/decs
require daslib/decs_boost

require game_config
require game_var
require game_templates
require game_input
require game_phys
require game_assets
require game_utils


struct LevelSpawnData
    time: float
    enemy: EnemyType
    x_offset: float
    y_ratio: float

let level_data_null = [[LevelSpawnData]]

let level_data00 = [[LevelSpawnData[]
    [[LevelSpawnData time=0.0, enemy=EnemyType AsteroidSmall00, x_offset=0.0, y_ratio=0.2]];
    [[LevelSpawnData time=3.0, enemy=EnemyType AsteroidMedium00, x_offset=0.0, y_ratio=0.7]]
]]


def get_level_spawn_data_size(idx: int)
    if idx == 0
        return length(level_data00)
    else
        return 0


def get_level_spawn_data(idx: int; spawn_idx: int)
    if idx == 0
        return level_data00[spawn_idx]
    else
        return level_data_null