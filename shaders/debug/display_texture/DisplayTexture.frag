#version 460

uniform sampler2D TEXTURE;

in Data {
    vec2 texCoord;
} Inputs;

out vec4 FragColor;

void main() {
    FragColor = texture(TEXTURE, Inputs.texCoord);
}