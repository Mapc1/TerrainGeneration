#version 460

uniform samplerCube CUBEMAP;

in Data {
    vec4 localPos;
} Inputs;

out vec4 FragColor;

void main() {
    vec3 texCoord = normalize(vec3(Inputs.localPos));

    FragColor = texture(CUBEMAP, texCoord);
}