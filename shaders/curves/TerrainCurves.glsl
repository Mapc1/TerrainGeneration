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
        vec2(-1.1,6),
        vec2(-1,6),
        vec2(-0.6,6),
        vec2(-0.4,50),
        vec2(-0.3,60),
        vec2(-0.2,85),
        vec2(0.1,95),
        vec2(0.35,115),
        vec2(0.55,140),
        vec2(0.6,145),
        vec2(0.7,150),
        vec2(0.8,155),  
        vec2(1,160),
        vec2(1.1,160)
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
        vec2(-0.7,60),
        vec2(-0.55,40),
        vec2(-0.25,45),
        vec2(-0.2,10),
        vec2(0.15,10),
        vec2(0.3,14),
        vec2(0.45,14),
        vec2(0.60,5),
        vec2(0.9,2),  
        vec2(1,1),
        vec2(1.1,1)
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

        vec2(-0.8,2),
        vec2(-0.65,10),
        vec2(-0.45,12),
        vec2(-0.1,14),
        vec2(0,15),
        vec2(0.3,16),
        vec2(0.55,70),
        vec2(0.7,75),
        vec2(0.8,80),  
       
        vec2(1,85),
        vec2(1.1,85)
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