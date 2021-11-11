require daslib/media
require daslib/decs
require daslib/decs_boost

require game_config
require game_var
require game_templates
require game_input
require game_phys


enum ProjectileType: int
    Projectile00


def create_projectile(projectile_type: ProjectileType)
    if projectile_type == ProjectileType Projectile00
        return