#version 460

in Data {
    vec3 normal;
} Inputs;

out vec4 color;

void main(){
    color = vec4(Inputs.normal/2 + 0.5, 1.0);
}