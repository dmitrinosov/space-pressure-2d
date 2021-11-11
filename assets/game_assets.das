require daslib/media

require game_config


var g_images: array<Image>

struct GameSprite
    texture_path: string
    image_idx: int

var g_game_sprites = [[GameSprite[]
    [[GameSprite texture_path="textures/Back00.png"]];
    [[GameSprite texture_path="textures/Back01.png"]];
    [[GameSprite texture_path="textures/Player00.png"]];
    [[GameSprite texture_path="textures/Asteroid00.png"]];
    [[GameSprite texture_path="textures/FXSphere00.png"]]
]]

var g_game_back00_image_idx = 0
var g_game_back01_image_idx = 0


def load_image(path : string)
    var img <- create_image(path)
    img |> set_image_smooth(true)
    g_images |> emplace(img)
    return length(g_images) - 1


def get_image_idx(texture_path: string)
    for gameSprite in g_game_sprites
        if gameSprite.texture_path == texture_path
            return gameSprite.image_idx
    return -1


def load_assets()
    set_font_name("fonts/ARCADECLASSIC.TTF")
    set_font_size(FONT_SIZE)

    for gameSprite in g_game_sprites
        gameSprite.image_idx = load_image(gameSprite.texture_path)

    g_game_back00_image_idx = get_image_idx("textures/Back00.png");
    g_game_back01_image_idx = get_image_idx("textures/Back01.png");