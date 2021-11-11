enum ProjectileType: int
    None
    Projectile00

let
    WINDOW_TITLE = "Space Pressure 2D"
    SCALE = 4
    WINDOW_WIDTH = 320 * SCALE
    WINDOW_HEIGHT = 200 * SCALE
    FONT_SIZE = 12 * SCALE
    PLAYER_SIZE = float2(163.0, 163.0) * 0.35  * 0.5 * float(SCALE)
    PLAYER_SPEED = 4600.0 * float(SCALE)
    PLAYER_START_POSITION_RATIO = float2(0.2, 0.5)
    PLAYER_START_PROJECTILE_TYPE = ProjectileType Projectile00
    PLAYER_DAMPING = 96.0
    PHYS_FIXED_DT = 1.0 / 30.0