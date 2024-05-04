#version 460

uniform mat4 PVM, M, V;

uniform mat4 LIGHT_SPACE_MAT;
uniform vec4 LIGHT_DIR;

uniform sampler2D DISPLACEMENT_MAP;
uniform mat3 NORMAL_MAT;

in vec2 texCoord0;
in vec4 position;
in vec4 normal;

out Data {
    vec4 worldPos;
    vec4 lightSpaceCoord;
    vec3 normal;
    vec3 lightDir;
    vec2 tex_coords;
} Outputs;

void main (){
    vec4 displacement_and_normal = texture(DISPLACEMENT_MAP, texCoord0);
    vec3 displaced_normal = displacement_and_normal.xyz;
    float displacement = displacement_and_normal.w;

    vec4 displaced_pos = position + (normal * displacement);

    Outputs.worldPos = displaced_pos * M;
    Outputs.lightSpaceCoord = LIGHT_SPACE_MAT * Outputs.worldPos;
    Outputs.normal = normalize(NORMAL_MAT*displaced_normal);
    Outputs.lightDir = normalize(vec3(V * -LIGHT_DIR));
    Outputs.tex_coords = texCoord0;

    gl_Position = PVM * displaced_pos;
}