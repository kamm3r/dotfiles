// -*- mode:c -*-
#version 300 es
precision lowp float;

in vec2 v_texcoord;       // comes from vertex shader
out vec4 FragColor;       // replaces gl_FragColor

uniform sampler2D tex;

float distanceSquared(vec3 pixColor, vec3 solarizedColor) {
    vec3 distanceVector = pixColor - solarizedColor;
    return dot(distanceVector, distanceVector);
}

void main() {
    vec3 solarized[16];
    solarized[0]  = vec3(0.0,   0.169, 0.212);
    solarized[1]  = vec3(0.027, 0.212, 0.259);
    solarized[2]  = vec3(0.345, 0.431, 0.459);
    solarized[3]  = vec3(0.396, 0.482, 0.514);
    solarized[4]  = vec3(0.514, 0.580, 0.588);
    solarized[5]  = vec3(0.576, 0.631, 0.631);
    solarized[6]  = vec3(0.933, 0.910, 0.835);
    solarized[7]  = vec3(0.992, 0.965, 0.890);
    solarized[8]  = vec3(0.710, 0.537, 0.000);
    solarized[9]  = vec3(0.796, 0.294, 0.086);
    solarized[10] = vec3(0.863, 0.196, 0.184);
    solarized[11] = vec3(0.827, 0.212, 0.510);
    solarized[12] = vec3(0.424, 0.443, 0.769);
    solarized[13] = vec3(0.149, 0.545, 0.824);
    solarized[14] = vec3(0.165, 0.631, 0.596);
    solarized[15] = vec3(0.522, 0.600, 0.000);

    vec3 pixColor = texture(tex, v_texcoord).rgb;

    int closest = 0;
    float closestDist = distanceSquared(pixColor, solarized[0]);

    for (int i = 1; i < 16; i++) {
        float newDist = distanceSquared(pixColor, solarized[i]);
        if (newDist < closestDist) {
            closest = i;
            closestDist = newDist;
        }
    }

    FragColor = vec4(solarized[closest], 1.0);
}
