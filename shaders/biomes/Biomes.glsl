#version 460

int getBiome(float continental, float erosion, float peaks_and_valleys, float temperature, float humidity);
vec4 getColorBiome(int biome, float water_level, float heigh);

const int OCEAN = 0,
        PLAIN = 1,
        FLOREST = 2,
        SNOW_MOUNTAIN = 3;

int getBiome(float continental, float erosion, float peaks_and_valleys, float temperature, float humidity){
    
    return 0;
}

vec4 getColorBiome(int biome, float water_level, float heigh){
    return vec4(1);
}