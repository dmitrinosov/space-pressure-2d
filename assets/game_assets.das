require daslib/media

require game_config
require game_utils

let DEATH_IMAGES_COUNT = 14

var g_images: array<Image>

struct GameSprite
    id: string
    texture_path: string
    image_idx: int
    generate_damage_image: bool
    damage_image_idx: int
    genererate_death_images: bool
    death_images_idxs: int[DEATH_IMAGES_COUNT]

var g_game_sprites = [[GameSprite[]
    [[GameSprite id="Back00", texture_path="textures/Back00.png"]];
    [[GameSprite id="Back01", texture_path="textures/Back01.png"]];
    [[GameSprite id="Player00", texture_path="textures/Player00.png", generate_damage_image=true, genererate_death_images=true]];
    [[GameSprite id="Asteroid00", texture_path="textures/Asteroid00.png", generate_damage_image=true, genererate_death_images=true]];
    [[GameSprite id="Enemy00", texture_path="textures/Enemy00.png", generate_damage_image=true, genererate_death_images=true]];
    [[GameSprite id="Enemy01", texture_path="textures/Enemy01.png", generate_damage_image=true, genererate_death_images=true]];
    [[GameSprite id="Enemy02", texture_path="textures/Enemy02.png", generate_damage_image=true, genererate_death_images=true]];
    [[GameSprite id="Enemy03", texture_path="textures/Enemy03.png", generate_damage_image=true, genererate_death_images=true]];
    [[GameSprite id="Enemy04", texture_path="textures/Enemy04_Base.png", generate_damage_image=true, genererate_death_images=true]];
    [[GameSprite id="EnemyGun00", texture_path="textures/EnemyGun00.png", generate_damage_image=true, genererate_death_images=true]];
    [[GameSprite id="Enemy04_MidGun00", texture_path="textures/Enemy04_MidGun00.png", generate_damage_image=true, genererate_death_images=true]];
    [[GameSprite id="Enemy04_BottomGun00", texture_path="textures/Enemy04_BottomGun00.png", generate_damage_image=true, genererate_death_images=true]];
    [[GameSprite id="Enemy04_TopGun00", texture_path="textures/Enemy04_TopGun00.png", generate_damage_image=true, genererate_death_images=true]];
    [[GameSprite id="Enemy04_SideGun00", texture_path="textures/Enemy04_SideGun00.png", generate_damage_image=true, genererate_death_images=true]];
    [[GameSprite id="Health00", texture_path="textures/Health00.png", genererate_death_images=true]];
    [[GameSprite id="Weapon00", texture_path="textures/Weapon00.png", genererate_death_images=true]];
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


def lerp_inv_edge_factor(t: float)
    let x = (t * 2.0 - 1.0)
    let y = -(pow(abs(x), 0.75)) + 1.0
    return y


def load_death_images(path: string;
                  var image_idxs: int[DEATH_IMAGES_COUNT])
    let WAVES_NOISE = 15.0
    let EDGE_WIDTH = 0.1
    let EDGE_COLOR = float3(1.0, 0.66, 0.0)
    for i in range(DEATH_IMAGES_COUNT)
        let dissolveProgress = float(i) / float(DEATH_IMAGES_COUNT)
        let invDissolveProgress = 1.0 - dissolveProgress
        var img <- create_image(path)
        img |> set_image_smooth(true)

        for y in range(img.height)
            for x in range(img.width)
                let p = img |> get_pixel(x, y)
                var a = (p >> 24u) & 0xFFU
                let b = (p >> 0u) & 0xFFU
                let g = (p >> 8u) & 0xFFU
                let r = (p >> 16u) & 0xFFU
                //let uv = float2(float(x)/float(img.width), float(y)/float(img.height))
                let uv = float2(float(x)/200.0, float(y)/200.0)
                let noiseUV = uv * WAVES_NOISE
                let noiseFactor = (gradient_noise(noiseUV) + 1.0) * 0.5
                let dissolveFactor = noiseFactor - dissolveProgress
                if dissolveFactor < 0.0
                    a = 0u

                let isEdgeZone = noiseFactor > dissolveProgress + EDGE_WIDTH ? 0.0 : 1.0
                let edgeL = dissolveFactor / EDGE_WIDTH
                let edgeFactor = lerp_inv_edge_factor(edgeL)

                var color = float3((float(r)/255.0),
                                   (float(g)/255.0),
                                   (float(b)/255.0))
                color += lerp(EDGE_COLOR, float3(1.0), edgeFactor) * isEdgeZone * 5.0

                img |> set_pixel(x, y,
                    make_color(color.x, color.y, color.z,
                               (float(a)/255.0)))
        g_images |> emplace(img)
        image_idxs[i] = length(g_images) - 1


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
        if gameSprite.genererate_death_images
            load_death_images(gameSprite.texture_path, gameSprite.death_images_idxs)

    g_game_back00_image_idx = get_image_idx("textures/Back00.png");
    g_game_back01_image_idx = get_image_idx("textures/Back01.png");