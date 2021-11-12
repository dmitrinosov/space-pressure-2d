enum ProjectileType: int
    None
    PlayerProjectile00
    EnemyProjectile00
    EnemyProjectile01

enum EnemyType: int
    None
    AsteroidSmall00
    AsteroidMedium00
    AsteroidBig00
    Enemy00
    Enemy01
    Enemy02
    Boss00

let
    WINDOW_TITLE = "Space Pressure 2D"
    SCALE = 4
    WINDOW_WIDTH = 320 * SCALE
    WINDOW_HEIGHT = 200 * SCALE
    FONT_SIZE = 8 * SCALE
    PLAYER_SIZE = float2(163.0, 163.0) * 0.3  * 0.5 * float(SCALE)
    PLAYER_SPEED = 4600.0 * float(SCALE)
    PLAYER_START_POSITION_RATIO = float2(0.2, 0.5)
    PLAYER_COOLDOWN = 0.15
    PLAYER_START_PROJECTILE_TYPE = ProjectileType PlayerProjectile00
    PLAYER_DAMPING = 96.0
    PLAYER_HEALTH = 150.0
    PLAYER_DAMAGE = 10.0
    PLAYER_COLLISION_DAMAGE = 2.0
    PLAYER_INDEX = 0
    ENEMY_INDEX = 1
    PHYS_FIXED_DT = 1.0 / 30.0