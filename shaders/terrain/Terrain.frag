#version 460

vec4 getColorBiome(int biome, float water_level, float heigh);

uniform sampler2DShadow SHADOW_MAP;

uniform sampler2D BIOME_MAP;

uniform float WATER_LEVEL = 115;

const float BIAS = 0.005;

in Data {
    vec4 worldPos;
    vec4 lightSpaceCoord;
    vec3 normal;
    vec3 lightDir;
    vec2 tex_coords;
} Inputs;

out vec4 color;

float sampleShadowMap(vec4 light_space_coord, vec3 normal, vec3 lightDir) {
    float NdotL = max(0.0, dot(normal, lightDir));
    if (NdotL <= 0.01)
        return 0.0;

    light_space_coord.z -= BIAS;

    float luminance = 0.0;
    vec2 texel_size = 1.0 / textureSize(SHADOW_MAP, 0);
    for (int x = -1; x < 1; x++) {
        for (int y = -1; y < 1; y++) {
            vec4 offset = vec4(vec2(x,y)*texel_size, 0.0, 0.0);
            luminance += textureProj(SHADOW_MAP, light_space_coord + offset);
        }
    }

    return NdotL * (luminance/9);
}

void main(){

    /*
    if (Inputs.worldPos.y < 0) diff_color = vec4(0);
    else if (Inputs.worldPos.y <= 1) diff_color = vec4(1);
    else if (Inputs.worldPos.y <= 115) diff_color = vec4(0,0,1,1);
    else diff_color = vec4(0,1,0,1);
    */
    //int biome = int(texture(BIOME_MAP, Inputs.tex_coords).r);
    
    int biome = int(texelFetch(BIOME_MAP, ivec2(Inputs.tex_coords * textureSize(BIOME_MAP, 0)), 0).r);
    
    vec4 diff_color = getColorBiome(biome, WATER_LEVEL, Inputs.worldPos.y);    

    vec4 world_pos = Inputs.worldPos;
    vec4 light_space_coord = Inputs.lightSpaceCoord;
    vec3 normal = normalize(Inputs.normal);
    vec3 light_dir = normalize(Inputs.lightDir);

    float luminance = sampleShadowMap(light_space_coord, normal, light_dir);
    color = 0.25 * diff_color;
    color += luminance * diff_color;
    
}   