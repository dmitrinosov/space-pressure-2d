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
    [[GameSprite id="Projectile00", texture_path="textures/FXSphere00.png"]]
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
            img |> set_pixel(x, y,
                make_color(1.0, 1.0, 1.0, float(a)))
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

    for gameSprite in g_game_sprites
        gameSprite.image_idx = load_image(gameSprite.texture_path)
        if gameSprite.generate_damage_image
            gameSprite.damage_image_idx = load_damage_image(gameSprite.texture_path)

    g_game_back00_image_idx = get_image_idx("textures/Back00.png");
    g_game_back01_image_idx = get_image_idx("textures/Back01.png");