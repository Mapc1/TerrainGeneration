#version 460

in vec4 position;

uniform mat4 PVM;
uniform vec4 CAM_POS;

void main() {
    gl_Position = PVM * (position + vec4(CAM_POS.x, 0.0, CAM_POS.y,0.0));
}