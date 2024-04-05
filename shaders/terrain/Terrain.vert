#version 460

uniform mat4 PVM;
uniform sampler2D DISPLACEMENT_MAP;
uniform mat3 NORMAL_MAT;

in vec2 texCoord0;
in vec4 position;
in vec4 normal;

out Data {
    vec3 normal;
} Outputs;

void main (){
    vec4 displacement_and_normal = texture(DISPLACEMENT_MAP, texCoord0);
    vec3 displaced_normal = displacement_and_normal.xyz;
    float displacement = displacement_and_normal.w;

    vec4 displaced_pos = position + (normal * displacement);

    Outputs.normal = displaced_normal;
    gl_Position = PVM * displaced_pos;
}