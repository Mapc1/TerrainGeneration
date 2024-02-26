#version 460

in Data {
    vec3 normal;
    vec2 texCoord;
    float noise;
} Inputs;

out vec4 FragColor;

void main() {
    vec3 normal = normalize(Inputs.normal);
    FragColor = vec4(0.0,1.0,0.0,1.0);
    if (Inputs.noise == 0.0) {
        FragColor = vec4(0.0,0.0,1.0,1.0);
    }
}