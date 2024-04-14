float getContinental(float noise, float factor);
float getErosion(float noise, float factor);
float getPeaksNValleys(float noise, float factor);

float getContinental(float noise, float factor){
    
    float displacement = 0;
    if(noise <= -0.6) displacement = -1;
    else if (noise <= -0.5) displacement = noise * 6 - 2.6;
    else if (noise <= -0.2) displacement = noise * 1 - 0.1;
    else if (noise <= -0.05) displacement = noise * (2/3) - (1/30);
    else if (noise <= 0.1) displacement = noise * (1/3) - (1/60);
    else if (noise <= 0.4) displacement = noise * 0.5 + 0;
    else if (noise <= 0.6) displacement = noise * 1.5 + 0.4;
    else if (noise <= 0.75) displacement = noise * (5/3) + 0.5;
    else if (noise <= 0.9) displacement = noise * (5/3) + 0.5;
    else displacement == 1;

    return displacement * factor;
}

float getErosion(float noise, float factor){
    float displacement = 0;

    return displacement;
}

float getPeaksNValleys(float noise, float factor){
    float displacement = 0;

    return displacement;
}