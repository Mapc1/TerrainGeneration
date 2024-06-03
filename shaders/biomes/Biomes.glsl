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

//const float THRESHOLD_PEAKS[3] = {-0.6, 0.4, 1}; // 1
//const float THRESHOLD_CONTINENTAL[3] = {0, 0.5, 1}; // 2
//const float THRESHOLD_EROSION[3] = {-0.6, 0.4, 1}; // 3
//const float THRESHOLD_TEMPERATURE[3] = {-0.5, 0.5, 1}; // 4
//const float THRESHOLD_HUMIDITY[3] = {-0.5, 0.5, 1}; // 5

const int BIOME_LUT_MAX = 8,
          BIOME_LUT_SQUARE_MAX = 2;

int biomes_lookup[BIOME_LUT_MAX] = {
    PEAKS,
    SNOW_MOUNTAIN,

    FOREST,

    DESERT,

    PLATEAU, //More optional than the others
    SNOW_PLAINS, //More optional than the others
    JUNGLE,
    
    PLAIN
};

const float biomes_limits[BIOME_LUT_MAX][BIOME_LUT_SQUARE_MAX][10] = {
    /*
    {
        1º Box : { peaks_lim_inf,peaks_lim_sup, 
                   continental_lim_inf,continental_lim_sup,
                   erosion_lim_inf,erosion_lim_sup, 
                   humidity_lim_inf,humidity_lim_sup, 
                   temperature_lim_inf,temperature_lim_sup},
        2º Box : ...,
        .
        .
        .
        BIOME_LUT_SQUARE_MAXº Box : ...;
        // NO BOX = {-2,0, 0,0, 0,0, 0,0, 0,0}
    }
    */
    
    {
        {0.3,1, -1,1, -1,1, -1,1, 0,1}, {-2,0, 0,0, 0,0, 0,0, 0,0} // PEAKS
    },
    {
        {0.3,1, -1,1, -1,1, -1,1, -1,0}, {-2,0, 0,0, 0,0, 0,0, 0,0} // SNOW_MOUNTAIN
    },
    {
        {-2,0, 0,0, 0,0, 0,0, 0,0}, {-2,0, 0,0, 0,0, 0,0, 0,0} // FOREST
    },
    {
        {-2,0, 0,0, 0,0, 0,0, 0,0}, {-2,0, 0,0, 0,0, 0,0, 0,0}// DESERT
    },
    {
        {-2,0, 0,0, 0,0, 0,0, 0,0}, {-2,0, 0,0, 0,0, 0,0, 0,0} // PLATEAU
    },
    {
        {-2,0, 0,0, 0,0, 0,0, 0,0}, {-2,0, 0,0, 0,0, 0,0, 0,0} // SNOW_PLAINS
    },
    {
        {-2,0, 0,0, 0,0, 0,0, 0,0}, {-2,0, 0,0, 0,0, 0,0, 0,0} // JUNGLE
    },
    {
        {-1,1, -1,1, -1,1, -1,1, -1,1},  {-2,1, -1,1, -1,1, -1,1, -1,1} // PLAIN 
    },
};

// Problema -> gerar terreno natural
// solucoes -> 1 altura random
// 2 -> Funcao linear -> muito repetida
// 3 -> funcao noise simple / octavos nao resolve -> muito regular // falta espetaculo
// 4 -> funcao noise + splines -> Best 


int getBiome(float continental, float erosion, float peaks_and_valleys, float temperature, float humidity, float water_level, float height){
    
    if (height <= water_level){
        if (temperature >= -0.5) return OCEAN;
        else return FROZEN_OCEAN;
    }

    for(int biome_lu = 0; biome_lu < BIOME_LUT_MAX; biome_lu++){
        for(int table = 0; table < BIOME_LUT_SQUARE_MAX; table++){
            if (biomes_limits[biome_lu][table][0] != -2){
                bool in_peaks = peaks_and_valleys >= biomes_limits[biome_lu][table][0] &&  peaks_and_valleys <= biomes_limits[biome_lu][table][1],
                     in_cont = continental >= biomes_limits[biome_lu][table][2] &&  continental <= biomes_limits[biome_lu][table][3],
                     in_eros = erosion >= biomes_limits[biome_lu][table][4] &&  erosion <= biomes_limits[biome_lu][table][5],
                     in_hum = humidity >= biomes_limits[biome_lu][table][6] &&  humidity <= biomes_limits[biome_lu][table][7],
                     in_temp = temperature >= biomes_limits[biome_lu][table][8] &&  temperature <= biomes_limits[biome_lu][table][9];
                
                if (in_peaks && in_cont && in_eros && in_hum && in_temp) return biomes_lookup[biome_lu];
            }
        }
    }
    /*
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
    */
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