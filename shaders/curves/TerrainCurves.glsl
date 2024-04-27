float getContinental(float noise, float factor);
float getErosion(float noise, float factor);
float getPeaksNValleys(float noise, float factor);

vec2[4] getInBetween13(float noise, vec2[13] points, int size);
vec2[4] getInBetween14(float noise, vec2[14] points, int size);
float getTime(float minu, float maxi, float value);

// NEW METHOD -> utiliza um spline, catmull-rom, para calcular  
uniform float alpha = 0.5;
// OLD_METHOD -> utiliza intrevalos de reta para calcular, nao e continuo
uniform bool OLD_METHOD = false;


float getContinental(float noise, float factor){
    if (noise >= 1) noise = 1;
    if (noise <= -1) noise = -1;
    
    if (OLD_METHOD) {
        float m_factor = 0, b_factor = 0;
        if(noise <= -0.6) {m_factor = 0; b_factor = -1.0;}
        else if (noise <= -0.5) {m_factor = 6; b_factor = 2.6;}
        else if (noise <= -0.2) {m_factor = 1; b_factor = 0.1;}
        else if (noise <= -0.05) {m_factor = 0.6667 ; b_factor = 0.0133;}
        else if (noise <= 0.1) {m_factor = 0.3333 ; b_factor = 0.0167;}
        else if (noise <= 0.4) {m_factor = 0.5; b_factor = 0;}
        else if (noise <= 0.6) {m_factor = 1.5; b_factor = -0.4;}
        else if (noise <= 0.8) {m_factor = 1; b_factor = -0.1;}
        else if (noise <= 0.9) {m_factor = 3; b_factor = -1.7;}
        else {m_factor = 0; b_factor = 1.0;}

        return (m_factor * noise + b_factor) * factor;
    }

    vec2[14] points = {
        vec2(-1.1,0),
        vec2(-1,0),
        vec2(-0.7,35),
        vec2(-0.6,60),
        vec2(-0.5,95),
        vec2(-0.2,95),
        vec2(0.1,100),
        vec2(0.35,115),
        vec2(0.55,140),
        vec2(0.6,145),
        vec2(0.7,150),
        vec2(0.8,155),  
        vec2(1,160),
        vec2(1.1,125)
    }; int size = 14;
    
    vec2[4] inBetween = getInBetween14(noise, points, size);

    float time = getTime(inBetween[1].x, inBetween[2].x, noise);
    vec4 cmTime = vec4(pow(time,3), pow(time,2), time, 1);
    
    mat4 cmPoints = transpose(mat4(
        inBetween[0],0,0,
        inBetween[1],0,0,
        inBetween[2],0,0,
        inBetween[3],0,0    
    ));

    mat4 cmMatrix = transpose(mat4(
        -alpha, 2 - alpha, alpha - 2, alpha,
        2 * alpha, alpha - 3, 3 - 2 * alpha, -alpha,
        -alpha, 0, alpha, 0,
        0, 1, 0, 0  
    )); 

    vec4 final = cmTime * cmMatrix * cmPoints;

    return final.y * factor;
}

float getErosion(float noise, float factor){
    if (noise >= 1) noise = 1;
    if (noise <= -1) noise = -1;

    if (OLD_METHOD){
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
        else {m_factor = -0.5; b_factor = 0.5;}

        return (m_factor * noise + b_factor) * factor;
    }
    
    
    vec2[14] points = {
        vec2(-1.1,80),
        vec2(-1,75),
        vec2(-0.8,70),
        vec2(-0.5,60),
        vec2(-0.35,40),
        vec2(-0.1,30),
        vec2(0.2,20),
        vec2(0.5,20),
        vec2(0.6,35),
        vec2(0.75,35),
        vec2(0.85,15),
        vec2(0.9,5),  
        vec2(1,0),
        vec2(1.1,0)
    }; int size = 14;
    
    vec2[4] inBetween = getInBetween14(noise, points, size);

    float time = getTime(inBetween[1].x, inBetween[2].x, noise);
    vec4 cmTime = vec4(pow(time,3), pow(time,2), time, 1);
    
    mat4 cmPoints = transpose(mat4(
        inBetween[0],0,0,
        inBetween[1],0,0,
        inBetween[2],0,0,
        inBetween[3],0,0    
    ));

    mat4 cmMatrix = transpose(mat4(
        -alpha, 2 - alpha, alpha - 2, alpha,
        2 * alpha, alpha - 3, 3 - 2 * alpha, -alpha,
        -alpha, 0, alpha, 0,
        0, 1, 0, 0  
    )); 

    vec4 final = cmTime * cmMatrix * cmPoints;

    return final.y * factor;
}

float getPeaksNValleys(float noise, float factor){
   vec2[13] points = {
        vec2(-1.1,0),
        vec2(-1,0),

        vec2(-0.7,4),
        vec2(-0.5,12),
        vec2(-0.2,16),
        vec2(0,20),
        vec2(0.2,22),
        vec2(0.4,28),
        vec2(0.6,32),
        vec2(0.7,35),
        vec2(0.9,38),  
       
        vec2(1,40),
        vec2(1.1,40)
    }; int size = 13;
    
    vec2[4] inBetween = getInBetween13(noise, points, size);

    float time = getTime(inBetween[1].x, inBetween[2].x, noise);
    vec4 cmTime = vec4(pow(time,3), pow(time,2), time, 1);
    
    mat4 cmPoints = transpose(mat4(
        inBetween[0],0,0,
        inBetween[1],0,0,
        inBetween[2],0,0,
        inBetween[3],0,0    
    ));

    mat4 cmMatrix = transpose(mat4(
        -alpha, 2 - alpha, alpha - 2, alpha,
        2 * alpha, alpha - 3, 3 - 2 * alpha, -alpha,
        -alpha, 0, alpha, 0,
        0, 1, 0, 0  
    )); 

    vec4 final = cmTime * cmMatrix * cmPoints;

    return final.y * factor;
}

vec2[4] getInBetween13(float noise, vec2[13] points, int size){
    vec2[4] inBetween;
    if (noise == 1){
        inBetween[0] = points[size - 4];
        inBetween[1] = points[size - 3];
        inBetween[2] = points[size - 2];
        inBetween[3] = points[size - 1];
        return inBetween;
    } 
    if (noise == -1){
        inBetween[0] = points[0];
        inBetween[1] = points[1];
        inBetween[2] = points[2];
        inBetween[3] = points[3];
        return inBetween;
    }
    
    int i = 0;
    for ( i = 0; i < size; i++) if (noise <= points[i].x) break;
    inBetween[0] = points[i - 2];
    inBetween[1] = points[i - 1];
    inBetween[2] = points[i + 0];
    inBetween[3] = points[i + 1];
    return inBetween;
}

vec2[4] getInBetween14(float noise, vec2[14] points, int size){
    vec2[4] inBetween;
    if (noise == 1){
        inBetween[0] = points[size - 4];
        inBetween[1] = points[size - 3];
        inBetween[2] = points[size - 2];
        inBetween[3] = points[size - 1];
        return inBetween;
    } 
    if (noise == -1){
        inBetween[0] = points[0];
        inBetween[1] = points[1];
        inBetween[2] = points[2];
        inBetween[3] = points[3];
        return inBetween;
    }
    
    int i = 0;
    for ( i = 0; i < size; i++) if (noise <= points[i].x) break;
    inBetween[0] = points[i - 2];
    inBetween[1] = points[i - 1];
    inBetween[2] = points[i + 0];
    inBetween[3] = points[i + 1];
    return inBetween;
}


float getTime(float minu, float maxi, float value){
    return (value - minu) / (maxi - minu);
}