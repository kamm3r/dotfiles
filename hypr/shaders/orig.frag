#version 300 es
precision mediump float;

in vec2 v_texcoord;
out vec4 FragColor;

uniform sampler2D tex;
// WARNING: disable damage_tracking in Hyprland to get 'time' animation working
uniform float time;

const float display_framerate = 60.0;
const vec2 display_resolution = vec2(2256.0, 1504.0);

vec2 curve(vec2 uv) {
  uv = (uv - 0.5) * 2.0;
  uv *= 1.1;
  uv.x *= 1.0 + pow((abs(uv.y) / 8.0), 2.0);
  uv.y *= 1.0 + pow((abs(uv.x) / 8.0), 2.0);
  uv = (uv / 2.0) + 0.5;
  uv = uv * 0.92 + 0.04;
  return uv;
}

float rand(vec2 uv, float t) {
  return fract(sin(dot(uv, vec2(1225.6548, 321.8942))) * 4251.4865 + t);
}

void main() {
  vec2 uv = v_texcoord;

  // CRT curve / barrel distortion
  uv = curve(uv);
  vec4 pixColor = texture(tex, uv);
  vec3 col = pixColor.rgb;

  // simple chromatic aberration
  float analog_noise = fract(sin(time) * 43758.5453123 * uv.y) * 0.0006;
  col.r = texture(tex, uv + vec2(0.0008 + analog_noise, 0.0)).r + 0.05;
  col.g = texture(tex, uv + vec2(0.0008 + analog_noise, 0.0005)).g + 0.05;
  col.b = texture(tex, uv + vec2(-0.0008 + analog_noise, 0.0)).b + 0.05;

  // contrast bump
  col = mix(col, col * smoothstep(0.0, 1.0, col), 1.0);
  col = mix(col, col * smoothstep(0.0, 1.0, col), 0.5);

  // noise / grain
  float scale = 2.8;
  float amount = 0.15;
  vec2 offset = (rand(uv, time) - 0.9) * 1.8 * uv * scale;
  vec3 noise = texture(tex, uv + offset).rgb;
  col = mix(col, noise, amount);
  col *= 12.8;

  // bloom (expensive blur)
  const float blur_directions = 24.0;
  const float blur_quality = 4.0;
  const float blur_size = 12.0;
  const float blur_brightness = 6.5;
  const vec2 blur_radius = blur_size / (display_resolution * 0.5);

  vec3 bloomColor = vec3(0.0);
  for (float d = 0.0; d < 6.28318530718;
       d += 6.28318530718 / blur_directions) {
    for (float i = 1.0 / blur_quality; i <= 1.0; i += 1.0 / blur_quality) {
      vec3 toAdd = texture(tex, uv + vec2(cos(d), sin(d)) * blur_radius * i).rgb;
      toAdd *= blur_brightness * vec3(1.5, 0.85, 0.40);
      bloomColor += toAdd;
    }
  }
  bloomColor /= (blur_quality * blur_directions);
  col += bloomColor;

  // scanlines
  float scanvar = 0.1;
  float scanlines = clamp(scanvar + scanvar *
                          sin(display_framerate * 1.95 * mod(-time, 8.0) +
                              uv.y * display_resolution.y),
                          0.0, 1.0);
  float s = pow(scanlines, 1.7);
  col *= (0.4 + 0.7 * s);

  // flicker
  float flickerAmount = 0.01;
  col *= 1.0 + flickerAmount * sin(display_framerate * 2.0 * time);

  // black edges
  if (uv.x < 0.0 || uv.x > 1.0) col *= 0.0;
  if (uv.y < 0.0 || uv.y > 1.0) col *= 0.0;

  // phosphor lines
  float phosphor = 0.10;
  col.r -= clamp(phosphor + phosphor *
                 sin(uv.x * display_resolution.x * 1.3333),0.0,1.0);
  col.g -= clamp(phosphor + phosphor *
                 sin((uv.x + 0.3333) * display_resolution.x * 1.3333),0.0,1.0);
  col.b -= clamp(phosphor + phosphor *
                 sin((uv.x + 0.6666) * display_resolution.x * 1.3333),0.0,1.0);

  col *= 0.5;

  // vignette
  const float vignetteStr = 200.0;
  const float vignetteExtend = 0.5;
  vec2 uv_ = uv * (1.0 - uv.yx);
  float vignette = uv_.x * uv_.y * vignetteStr;
  vignette = clamp(pow(vignette, vignetteExtend), 0.0, 1.0);
  col *= vignette;

  // crude gamut mixing
  pixColor.r = mix(col.r, mix(col.g, col.b, 0.9), 0.05);
  pixColor.g = mix(col.g, mix(col.r, col.b, 0.3), 0.05);
  pixColor.b = mix(col.b, mix(col.g, col.r, 0.8), 0.05);

  pixColor.rb *= vec2(1.04, 0.8);

  FragColor = vec4(pixColor.rgb, 1.0);
}
