float getContinental(float noise, float factor);
float getErosion(float noise, float factor);
float getPeaksNValleys(float noise, float factor);

float getContinental(float noise, float factor){
    
    float displacement = 0;
    if(noise <= 0.3) displacement = -1;
    else if (noise <= 0.45) displacement = 5 * noise - 2.5;
    else if (noise <= 0.55) displacement = 2.5 * noise - 1.375;
    else if (noise <= 0.65) displacement = 1 * noise - 0.55;
    else if (noise <= 0.80) displacement = (7/3) * noise - (17/12);
    else if (noise <= 0.95) displacement = (11/3) * noise - (149/60);
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