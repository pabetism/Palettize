shader_type canvas_item;

// The number of color levels per channel (2 levels per channel gives 2*2*2 = 8 colors)
uniform float levels : hint_range(1.0, 10.0) = 2.0; 
uniform bool enable_dithering = true;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// Simple 2x2 Bayer dither pattern (can be extended for more detail)
float dither_pattern(vec2 uv) {
    // Get pixel coordinates
    vec2 pos = floor(uv );
    float x = mod(pos.x, 2.0);
    float y = mod(pos.y, 2.0);
    float result = 0.0;

    // Bayer matrix hardcoded
    if (x == 0.0 && y == 0.0) result = 0.0;
    if (x == 1.0 && y == 0.0) result = 0.5;
    if (x == 0.0 && y == 1.0) result = 0.75;
    if (x == 1.0 && y == 1.0) result = 0.25;

    // Scale dither value to range [-0.5, 0.5]
    return (result - 0.5) / (levels);
}

void fragment() {
    // Sample the screen texture (for post-processing)
    vec4 color = texture(screen_texture, SCREEN_UV);
    vec3 col = color.rgb;

    if (enable_dithering) {
        // Apply dither to the color before quantization
        // We add the dither value to the color channel value
        col.r += dither_pattern(SCREEN_UV);
        col.g += dither_pattern(SCREEN_UV + vec2(0.5, 0.0)); // Slightly offset for variety
        col.b += dither_pattern(SCREEN_UV + vec2(0.0, 0.5)); // Slightly offset for variety
    }

    // Quantize the colors
    // Multiply by levels, round to nearest integer, then divide by levels to get snapped color
    col *= levels;
    col = floor(col + 0.5); // equivalent to round()
    col /= levels;

    COLOR.rgb = col;
    COLOR.a = color.a;
}