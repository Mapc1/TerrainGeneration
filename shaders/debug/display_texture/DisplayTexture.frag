#version 460

uniform sampler2D TEXTURE;

in Data {
    vec2 texCoord;
} Inputs;

out vec4 FragColor;

void main() {
    float color = texture(TEXTURE, Inputs.texCoord).r;
    if (color < 0 ) FragColor = vec4(abs(color), 0,0,1);
    else FragColor = vec4(0,0,color,1);
}