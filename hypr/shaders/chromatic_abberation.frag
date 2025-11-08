// vim: set ft=glsl:
#version 300 es
precision highp float;

in vec2 v_texcoord;          // "varying" is now "in"
out vec4 FragColor;          // must declare your own output

uniform sampler2D tex;

#define STRENGTH 0.0027

void main() {
    vec2 center = vec2(0.5, 0.5);
    vec2 offset = (v_texcoord - center) * STRENGTH;

    float rSquared = dot(offset, offset);
    float distortion = 1.0 + 1.0 * rSquared;
    vec2 distortedOffset = offset * distortion;

    vec4 redColor  = texture(tex, v_texcoord + distortedOffset);
    vec4 blueColor = texture(tex, v_texcoord + distortedOffset);
    vec4 greenColor = texture(tex, v_texcoord);

    FragColor = vec4(redColor.r, greenColor.g, blueColor.b, 1.0);
}
