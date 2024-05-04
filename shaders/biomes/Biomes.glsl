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
    switch(biome){
        case OCEAN:
        if (heigh < water_level) return vec4(0,0,1,1);
        else return vec4(0,1,0,1);
        
        case PLAIN:
        return vec4(1,0,0,1);
        
        case FLOREST:
        return vec4(1,0,0,1);
        
        case SNOW_MOUNTAIN:
        return vec4(1,0,0,1);
    }
}