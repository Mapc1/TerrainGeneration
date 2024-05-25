int getBiome(float continental, float erosion, float peaks_and_valleys, float temperature, float humidity, float water_level, float height);
vec4 getColorBiome(int biome, float water_level, float heigh);
float getInterval(float interval[3], int size, float value);

const int OCEAN = 0,
        PLAIN = 1,
        FOREST = 2,
        SNOW_MOUNTAIN = 3,
        DESERT = 4,
        PEAKS = 5,
        PLATEAU = 6, //More optional than the others
        SNOW_PLAINS = 7, //More optional than the others
        FROZEN_OCEAN = 8,
        JUNGLE = 9,
        DEBUG = 10;

float THRESHOLD_PEAKS[3] = {-0.6, 0.4, 1}; // 1
float THRESHOLD_CONTINENTAL[3] = {0, 0.5, 1}; // 2
float THRESHOLD_EROSION[3] = {-0.6, 0.4, 1}; // 3
float THRESHOLD_TEMPERATURE[3] = {-0.5, 0.5, 1}; // 4
float THRESHOLD_HUMIDITY[3] = {-0.5, 0.5, 1}; // 5

int getBiome(float continental, float erosion, float peaks_and_valleys, float temperature, float humidity, float water_level, float height){
    // int lookup_peaks = lookup(THRESHOLD_PEAKS, peaks_and_valleys);
    
    if (height < water_level){
        if (temperature >= -0.5) return OCEAN;
        else return FROZEN_OCEAN;
    } else {
        if (peaks_and_valleys >= 0.2 && erosion <= 0 && continental > 0.3){
            if (temperature < -0.5) return SNOW_MOUNTAIN;
            else return PEAKS;
        } else if (erosion <= 0.4 ){
            if (temperature > 0.5){
                if (humidity <= 0) return DESERT;
                else return JUNGLE;
            } else if (temperature > -0.5){
                if (humidity >= 0) return FOREST;
                else return PLAIN;
            } else {
                return SNOW_PLAINS;
            }
        } else {
            if(temperature > 0.5 && humidity <= 0) return DESERT;
            else return PLAIN;
        }
    }

    return DEBUG;
}

vec4 getColorBiome(int biome, float water_level, float height){
    switch(biome){
        case OCEAN:
            return vec4(0,0,1,1);
        
        case PLAIN:
            return vec4(0.3686, 1.0, 0.0, 1.0);
        
        case JUNGLE:
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

        case FOREST:
            return vec4(0.0706, 0.5, 0.0706, 1.0);

        case FROZEN_OCEAN:
            return vec4(0.03, 0.03, 0.5, 1.0);

        case DEBUG:
            return vec4(0,0,0,1);

        default:
            return vec4(0.9922, 0.098, 0.8, 1.0);
    }
}

float getInterval(float interval[3], int size, float value){
    int i = 0; for(i = 0, i < size && value < interval[i]; i++);
    return i;
}