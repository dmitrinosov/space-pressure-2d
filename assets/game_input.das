require daslib/media
require daslib/decs
require daslib/decs_boost
require daslib/math

require game_config
require game_templates
require game_phys

[decs (stage=input)]
def input_player_es(var input: PlayerInput)
    input.up = get_key(VK_UP) || get_key(VK_W)
    input.down = get_key(VK_DOWN) || get_key(VK_S)
    input.left = get_key(VK_LEFT) || get_key(VK_A)
    input.right = get_key(VK_RIGHT) || get_key(VK_D)


[decs (stage=input)]
def input_force_es(input: PlayerInput;
                   speed: float;
               var phys: PhysObj)
    var dir = float2()

    if input.up
        dir.y -= 1.0
    if input.down
        dir.y += 1.0
    if input.left
        dir.x -= 1.0
    if input.right
        dir.x += 1.0

    normalize(dir)

    phys.force = dir * speed
