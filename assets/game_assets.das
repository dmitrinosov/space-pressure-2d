require daslib/media

require game_config


var g_images: array<Image>

struct GameSprite
    id: string
    texture_path: string
    image_idx: int
    generate_damage_image: bool
    damage_image_idx: int

var g_game_sprites = [[GameSprite[]
    [[GameSprite id="Back00", texture_path="textures/Back00.png"]];
    [[GameSprite id="Back01", texture_path="textures/Back01.png"]];
    [[GameSprite id="Player00", texture_path="textures/Player00.png", generate_damage_image=true]];
    [[GameSprite id="Asteroid00", texture_path="textures/Asteroid00.png", generate_damage_image=true]];
    [[GameSprite id="Enemy00", texture_path="textures/Enemy00.png", generate_damage_image=true]];
    [[GameSprite id="Enemy01", texture_path="textures/Enemy01.png", generate_damage_image=true]];
    [[GameSprite id="Enemy02", texture_path="textures/Enemy02.png", generate_damage_image=true]];
    [[GameSprite id="Enemy03", texture_path="textures/Enemy03.png", generate_damage_image=true]];
    [[GameSprite id="Enemy04", texture_path="textures/Enemy04.png", generate_damage_image=true]];
    [[GameSprite id="EnemyGun00", texture_path="textures/EnemyGun00.png"]];
    [[GameSprite id="Projectile00", texture_path="textures/FXSphere00.png"]];
    [[GameSprite id="Projectile01", texture_path="textures/Projectile01b.png"]];
    [[GameSprite id="Projectile02", texture_path="textures/Projectile02.png"]];
    [[GameSprite id="Projectile03", texture_path="textures/Projectile03.png"]]
]]

var g_game_back00_image_idx = 0
var g_game_back01_image_idx = 0


def load_image(path : string)
    var img <- create_image(path)
    img |> set_image_smooth(true)

    g_images |> emplace(img)
    return length(g_images) - 1

def load_damage_image(path: string)
    var img <- create_image(path)
    img |> set_image_smooth(true)

    for y in range(img.height)
        for x in range(img.width)
            let p = img |> get_pixel(x, y)
            let a = (p >> 24u) & 0xFFU
            let b = (p >> 0u) & 0xFFU
            let g = (p >> 8u) & 0xFFU
            let r = (p >> 16u) & 0xFFU
            img |> set_pixel(x, y,
                make_color((float(r)/255.0) + 0.5,
                           (float(g)/255.0) + 0.5,
                           (float(b)/255.0) + 0.5,
                           (float(a)/255.0)))
    g_images |> emplace(img)
    return length(g_images) - 1


def get_image_idx(texture_path: string)
    for gameSprite in g_game_sprites
        if gameSprite.texture_path == texture_path
            return gameSprite.image_idx
    return -1


def get_sprite_idx(sprite_id: string)
    for i in iter_range(g_game_sprites)
        if g_game_sprites[i].id == sprite_id
            return i
    return -1


def load_assets()
    set_font_name("fonts/ARCADECLASSIC.TTF")
    set_font_size(FONT_SIZE)

    g_images |> clear()

    for gameSprite in g_game_sprites
        gameSprite.image_idx = load_image(gameSprite.texture_path)
        if gameSprite.generate_damage_image
            gameSprite.damage_image_idx = load_damage_image(gameSprite.texture_path)

    g_game_back00_image_idx = get_image_idx("textures/Back00.png");
    g_game_back01_image_idx = get_image_idx("textures/Back01.png");