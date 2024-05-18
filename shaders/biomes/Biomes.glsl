int getBiome(float continental, float erosion, float peaks_and_valleys, float temperature, float humidity);
vec4 getColorBiome(int biome, float water_level, float heigh);

const int OCEAN = 0,
        PLAIN = 1,
        FOREST = 2,
        SNOW_MOUNTAIN = 3,
        DESERT = 4,
        PEAKS = 5,
        PLATEAU = 6, //More optional than the others
        SNOW_PLAINS = 7; //More optional than the others

int getBiome(float continental, float erosion, float peaks_and_valleys, float temperature, float humidity){
    if (continental < 0) {
        return OCEAN;
    }
    if (continental >= 0 && continental < 0.1) return DESERT; //TODO ADD TEMPERATURE CONDITION
    else if (erosion < -0.5) {
        if (temperature < -0.5) 
            return SNOW_MOUNTAIN;
        else 
            return PEAKS;
    } 
    else if ((erosion > 0.5) || (erosion < 0.5 && erosion > -0.5 && continental < 0.5)) {
        if (temperature > 0.6) 
            return DESERT;
        else if (temperature > -0.5 && humidity < 0.25 && humidity > -0.25) 
            return FOREST;
        else if (temperature < -0.5) 
            return SNOW_PLAINS;
        else 
            return PLAIN;
    }
    else return PLATEAU;
    
    
}

vec4 getColorBiome(int biome, float water_level, float heigh){
    if (biome > 100) return vec4(0,1,0,1);
    switch(biome){
        case OCEAN:
            if (heigh < water_level) return vec4(0,0,1,1);
                else return vec4(0,1,0,1);
        
        case PLAIN:
            return vec4(0.3686, 1.0, 0.0, 1.0);
        
        case FOREST:
            return vec4(0.0706, 0.2745, 0.0706, 1.0);
        
        case SNOW_MOUNTAIN:
            return vec4(1,1,1,1);

        case DESERT:
            return vec4(1,1,0,1);

        case PEAKS:
            return vec4(0.5098, 0.498, 0.4863, 1.0);

        case PLATEAU:
            return vec4(0.9451, 0.6392, 0.0275, 1.0);
        
        case SNOW_PLAINS:
            return vec4(1,1,1,1);

        default:
            return vec4(0.9922, 0.098, 0.8, 1.0);
    }
}