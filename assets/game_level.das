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

    [[LevelSpawnData time=0.0, enemy=EnemyType AsteroidSmall00, x_offset=50.0, y_ratio=0.1]];
    [[LevelSpawnData time=0.0, enemy=EnemyType AsteroidMedium00, x_offset=150.0, y_ratio=0.7]];
    [[LevelSpawnData time=0.0, enemy=EnemyType AsteroidSmall00, x_offset=350.0, y_ratio=0.4]];
    [[LevelSpawnData time=0.0, enemy=EnemyType AsteroidMedium00, x_offset=78.0, y_ratio=0.36]];
    [[LevelSpawnData time=0.0, enemy=EnemyType AsteroidBig00, x_offset=262.0, y_ratio=0.9]];
    [[LevelSpawnData time=2.0, enemy=EnemyType AsteroidMedium00, x_offset=124.0, y_ratio=0.32]];
    [[LevelSpawnData time=2.0, enemy=EnemyType AsteroidSmall00, x_offset=245.0, y_ratio=0.84]];
    [[LevelSpawnData time=2.0, enemy=EnemyType AsteroidMedium00, x_offset=99.0, y_ratio=0.65]];
    [[LevelSpawnData time=2.0, enemy=EnemyType AsteroidSmall00, x_offset=89.0, y_ratio=0.23]];
    [[LevelSpawnData time=2.0, enemy=EnemyType AsteroidMedium00, x_offset=267.0, y_ratio=0.54]];

    [[LevelSpawnData time=4.0, enemy=EnemyType AsteroidBig00, x_offset=432.0, y_ratio=0.32]];
    [[LevelSpawnData time=4.0, enemy=EnemyType AsteroidBig00, x_offset=446.0, y_ratio=0.74]];
    [[LevelSpawnData time=4.0, enemy=EnemyType AsteroidSmall00, x_offset=234.0, y_ratio=0.14]];
    [[LevelSpawnData time=4.0, enemy=EnemyType AsteroidMedium00, x_offset=576.0, y_ratio=0.13]];
    [[LevelSpawnData time=4.0, enemy=EnemyType AsteroidSmall00, x_offset=212.0, y_ratio=0.44]];
    [[LevelSpawnData time=6.0, enemy=EnemyType AsteroidMedium00, x_offset=675.0, y_ratio=0.88]];
    [[LevelSpawnData time=6.0, enemy=EnemyType AsteroidSmall00, x_offset=50.0, y_ratio=0.1]];
    [[LevelSpawnData time=6.0, enemy=EnemyType AsteroidSmall00, x_offset=150.0, y_ratio=0.94]];
    [[LevelSpawnData time=6.0, enemy=EnemyType AsteroidSmall00, x_offset=350.0, y_ratio=0.75]];
    [[LevelSpawnData time=6.0, enemy=EnemyType AsteroidSmall00, x_offset=78.0, y_ratio=0.5]];

    [[LevelSpawnData time=8.0, enemy=EnemyType AsteroidSmall00, x_offset=52.0, y_ratio=0.9]];
    [[LevelSpawnData time=8.0, enemy=EnemyType AsteroidSmall00, x_offset=124.0, y_ratio=0.9]];
    [[LevelSpawnData time=8.0, enemy=EnemyType AsteroidSmall00, x_offset=245.0, y_ratio=0.34]];
    [[LevelSpawnData time=8.0, enemy=EnemyType AsteroidMedium00, x_offset=99.0, y_ratio=0.65]];
    [[LevelSpawnData time=8.0, enemy=EnemyType AsteroidMedium00, x_offset=89.0, y_ratio=0.33]];
    [[LevelSpawnData time=10.0, enemy=EnemyType AsteroidMedium00, x_offset=267.0, y_ratio=0.54]];
    [[LevelSpawnData time=10.0, enemy=EnemyType AsteroidMedium00, x_offset=432.0, y_ratio=0.52]];
    [[LevelSpawnData time=10.0, enemy=EnemyType AsteroidMedium00, x_offset=346.0, y_ratio=0.74]];
    [[LevelSpawnData time=10.0, enemy=EnemyType AsteroidMedium00, x_offset=234.0, y_ratio=0.14]];
    [[LevelSpawnData time=10.0, enemy=EnemyType AsteroidMedium00, x_offset=576.0, y_ratio=0.43]];
    [[LevelSpawnData time=10.0, enemy=EnemyType Health00, x_offset=590.0, y_ratio=0.23]];

    [[LevelSpawnData time=12.0, enemy=EnemyType AsteroidBig00, x_offset=412.0, y_ratio=0.24]];
    [[LevelSpawnData time=12.0, enemy=EnemyType AsteroidBig00, x_offset=475.0, y_ratio=0.58]];

    [[LevelSpawnData time=19.0, enemy=EnemyType Enemy00, x_offset=50.0, y_ratio=0.4]];
    [[LevelSpawnData time=19.0, enemy=EnemyType Enemy00, x_offset=50.0, y_ratio=0.6]];


    [[LevelSpawnData time=27.0, enemy=EnemyType Enemy00, x_offset=70.0, y_ratio=0.4]];
    [[LevelSpawnData time=27.0, enemy=EnemyType Enemy01, x_offset=50.0, y_ratio=0.5]];
    [[LevelSpawnData time=27.0, enemy=EnemyType Enemy00, x_offset=70.0, y_ratio=0.6]];
    [[LevelSpawnData time=27.0, enemy=EnemyType Weapon00, x_offset=70.0, y_ratio=0.5]];


    [[LevelSpawnData time=42.0, enemy=EnemyType Enemy00, x_offset=130.0, y_ratio=0.1]];
    [[LevelSpawnData time=42.0, enemy=EnemyType Enemy00, x_offset=110.0, y_ratio=0.2]];
    [[LevelSpawnData time=42.0, enemy=EnemyType Enemy00, x_offset=90.0, y_ratio=0.3]];
    [[LevelSpawnData time=42.0, enemy=EnemyType Enemy00, x_offset=70.0, y_ratio=0.4]];
    [[LevelSpawnData time=42.0, enemy=EnemyType Enemy00, x_offset=50.0, y_ratio=0.5]];
    [[LevelSpawnData time=42.0, enemy=EnemyType Enemy00, x_offset=70.0, y_ratio=0.6]];
    [[LevelSpawnData time=42.0, enemy=EnemyType Enemy00, x_offset=90.0, y_ratio=0.7]];
    [[LevelSpawnData time=42.0, enemy=EnemyType Enemy00, x_offset=110.0, y_ratio=0.8]];
    [[LevelSpawnData time=42.0, enemy=EnemyType Enemy00, x_offset=130.0, y_ratio=0.9]];


    [[LevelSpawnData time=52.0, enemy=EnemyType Enemy01, x_offset=60.0, y_ratio=0.1]];
    [[LevelSpawnData time=52.0, enemy=EnemyType Enemy01, x_offset=60.0, y_ratio=0.3]];

    [[LevelSpawnData time=52.0, enemy=EnemyType Enemy00, x_offset=50.0, y_ratio=0.4]];
    [[LevelSpawnData time=52.0, enemy=EnemyType Enemy00, x_offset=50.0, y_ratio=0.5]];
    [[LevelSpawnData time=52.0, enemy=EnemyType Enemy00, x_offset=50.0, y_ratio=0.6]];
    [[LevelSpawnData time=52.0, enemy=EnemyType Enemy00, x_offset=70.0, y_ratio=0.4]];
    [[LevelSpawnData time=52.0, enemy=EnemyType Enemy00, x_offset=70.0, y_ratio=0.5]];
    [[LevelSpawnData time=52.0, enemy=EnemyType Enemy00, x_offset=70.0, y_ratio=0.6]];

    [[LevelSpawnData time=52.0, enemy=EnemyType Enemy01, x_offset=60.0, y_ratio=0.7]];
    [[LevelSpawnData time=52.0, enemy=EnemyType Enemy01, x_offset=60.0, y_ratio=0.9]];

    [[LevelSpawnData time=52.0, enemy=EnemyType Health00, x_offset=90.0, y_ratio=0.5]];


    [[LevelSpawnData time=62.0, enemy=EnemyType Enemy01, x_offset=50.0, y_ratio=0.4]];
    [[LevelSpawnData time=62.0, enemy=EnemyType Enemy00, x_offset=50.0, y_ratio=0.5]];
    [[LevelSpawnData time=62.0, enemy=EnemyType Enemy01, x_offset=50.0, y_ratio=0.6]];

    [[LevelSpawnData time=62.0, enemy=EnemyType Enemy00, x_offset=70.0, y_ratio=0.4]];
    [[LevelSpawnData time=62.0, enemy=EnemyType Weapon00, x_offset=70.0, y_ratio=0.5]];
    [[LevelSpawnData time=62.0, enemy=EnemyType Enemy00, x_offset=70.0, y_ratio=0.6]];

    [[LevelSpawnData time=62.0, enemy=EnemyType Enemy01, x_offset=90.0, y_ratio=0.4]];
    [[LevelSpawnData time=62.0, enemy=EnemyType Enemy00, x_offset=90.0, y_ratio=0.5]];
    [[LevelSpawnData time=62.0, enemy=EnemyType Enemy01, x_offset=90.0, y_ratio=0.6]];


    [[LevelSpawnData time=72.0, enemy=EnemyType Enemy00, x_offset=130.0, y_ratio=0.1]];
    [[LevelSpawnData time=72.0, enemy=EnemyType Enemy01, x_offset=110.0, y_ratio=0.2]];
    [[LevelSpawnData time=72.0, enemy=EnemyType Enemy00, x_offset=90.0, y_ratio=0.3]];
    [[LevelSpawnData time=72.0, enemy=EnemyType Enemy01, x_offset=70.0, y_ratio=0.4]];
    [[LevelSpawnData time=72.0, enemy=EnemyType Enemy00, x_offset=50.0, y_ratio=0.5]];
    [[LevelSpawnData time=72.0, enemy=EnemyType Enemy01, x_offset=70.0, y_ratio=0.6]];
    [[LevelSpawnData time=72.0, enemy=EnemyType Enemy00, x_offset=90.0, y_ratio=0.7]];
    [[LevelSpawnData time=72.0, enemy=EnemyType Enemy01, x_offset=110.0, y_ratio=0.8]];
    [[LevelSpawnData time=72.0, enemy=EnemyType Enemy00, x_offset=130.0, y_ratio=0.9]];


    [[LevelSpawnData time=82.0, enemy=EnemyType Enemy02, x_offset=50.0, y_ratio=0.3]];
    [[LevelSpawnData time=82.0, enemy=EnemyType Enemy02, x_offset=50.0, y_ratio=0.7]];

    [[LevelSpawnData time=87.0, enemy=EnemyType Enemy02, x_offset=50.0, y_ratio=0.3]];
    [[LevelSpawnData time=87.0, enemy=EnemyType Enemy02, x_offset=50.0, y_ratio=0.7]];


    [[LevelSpawnData time=102.0, enemy=EnemyType Boss00, x_offset=100.0, y_ratio=0.5]]
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