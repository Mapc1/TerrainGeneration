#version 460

uniform mat3 NORMAL_MAT;
uniform mat4 PVM;
uniform sampler2D NOISE_TEX;

in vec4 position;
in vec3 normal;
in vec2 texCoord0;

out Data {
    vec3 normal;
    vec2 texCoord;
    float noise;
} Outputs;

void main() {
    Outputs.normal = normalize(NORMAL_MAT*vec3(normal));
    Outputs.texCoord = texCoord0;
    Outputs.noise = max(0.0, texture(NOISE_TEX, texCoord0).r);
    
    vec4 shifted_pos = position + vec4((Outputs.normal * Outputs.noise),0.0);
    gl_Position = PVM * shifted_pos;
}