float getContinental(float noise, float factor);
float getErosion(float noise, float factor);
float getPeaksNValleys(float noise, float factor);

float getContinental(float noise, float factor){
    
    float m_factor = 0, b_factor = 0;
    if(noise <= -0.6) {m_factor = 0; b_factor = -1;}
    else if (noise <= -0.5) {m_factor = 6; b_factor = 2.6;}
    else if (noise <= -0.2) {m_factor = 1; b_factor = 0.1;}
    else if (noise <= -0.05) {m_factor = 0.6667 /*2/3*/; b_factor = 0.0133 /*1/30*/;}
    else if (noise <= 0.1) {m_factor = 0.3333 /*1/3*/; b_factor = 0.0167 /*1/60*/;}
    else if (noise <= 0.4) {m_factor = 0.5; b_factor = 0;}
    else if (noise <= 0.6) {m_factor = 1.5; b_factor = -0.4;}
    else if (noise <= 0.8) {m_factor = 1; b_factor = -0.1;}
    else if (noise <= 0.9) {m_factor = 3; b_factor = -1.7;}
    else {m_factor = 0; b_factor = 1;}

    return (m_factor * noise + b_factor) * factor;
}

float getErosion(float noise, float factor){
    
    float m_factor = 0, b_factor = 0;
    if(noise <= -0.8) {m_factor = -1.75; b_factor = -0.75;}
    else if (noise <= -0.5) {m_factor = -0.5; b_factor = 0.25;}
    else if (noise <= -0.35) {m_factor = 0.5; b_factor = 0.75;}
    else if (noise <= -0.1) {m_factor = -1.1; b_factor = 0.19;}
    else if (noise <= 0.2) {m_factor = -0.1667; b_factor = 0.2833;}
    else if (noise <= 0.5) {m_factor = 0; b_factor = 0.25;}
    else if (noise <= 0.6) {m_factor = 1; b_factor = -0.25;}
    else if (noise <= 0.75) {m_factor = 0; b_factor = 0.35;}
    else if (noise <= 0.85) {m_factor = -1.5; b_factor = 1.475;}
    else if (noise <= 0.9) {m_factor = -3; b_factor = 2.75;}
    else {m_factor = -0.5; b_factor = 00.5;}

    return (m_factor * noise + b_factor) * factor;
}

float getPeaksNValleys(float noise, float factor){
    float displacement = 0;

    return displacement;
}