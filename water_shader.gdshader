shader_type canvas_item;


uniform vec4 tint;
uniform float speed;
group_uniforms Noise;
uniform float _noise_scale = 10.0;
uniform float cutoff: hint_range(0.0, 1.0, 0.01) = 0.77;
uniform vec2 _noise_scroll_speed;

group_uniforms Vornoi;
uniform float _columns = 3;
uniform float _rows = 6;
uniform float _vornoi_amplitude = 0.1;
uniform vec2 _vornoi_scroll_speed;

group_uniforms Distortion;
uniform sampler2D distortion;
uniform float distortion_scale: hint_range(0.0, 1.0, 0.1) = 0.27;

float randomf(vec2 uv) {
	return (fract(sin(dot(uv.xy,
		vec2(12.9898,78.233))) * 43758.5453123));
}

vec2 perlin_random(vec2 uv){
    uv = vec2( dot(uv, vec2(127.1,311.7) ),
               dot(uv, vec2(269.5,183.3) ) );
    return -1.0 + 2.0 * fract(sin(uv) * 43758.5453123);
}

vec2 random(vec2 uv) {
	return vec2(randomf(uv));
}

float vornoi(vec2 uv, float columns, float rows) {
	
	vec2 index_uv = floor(vec2(uv.x * columns, uv.y * rows));
	vec2 fract_uv = fract(vec2(uv.x * columns, uv.y * rows));
	
	float minimum_dist = 1.0;  
	
	for (int y= -1; y <= 1; y++) {
		for (int x= -1; x <= 1; x++) {
			vec2 neighbor = vec2(float(x),float(y));
			vec2 point = random(index_uv + neighbor);
			
			vec2 diff = neighbor + point - fract_uv;
			float dist = length(diff);
			minimum_dist = min(minimum_dist, dist);
		}
	}
	
	return minimum_dist;
}

float noise(vec2 uv) {
    vec2 uv_index = floor(uv);
    vec2 uv_fract = fract(uv);

    vec2 blur = smoothstep(0.0, 1.0, uv_fract);

    return mix( mix( dot( perlin_random(uv_index + vec2(0.0,0.0) ), uv_fract - vec2(0.0,0.0) ),
                     dot( perlin_random(uv_index + vec2(1.0,0.0) ), uv_fract - vec2(1.0,0.0) ), blur.x),
                mix( dot( perlin_random(uv_index + vec2(0.0,1.0) ), uv_fract - vec2(0.0,1.0) ),
                     dot( perlin_random(uv_index + vec2(1.0,1.0) ), uv_fract - vec2(1.0,1.0) ), blur.x), blur.y) + 0.5;
}

void fragment() {
	// Create a stylized water effect with a blue color
    vec4 waterColor = tint;

    // Create a wave effect using fbm and voronoi noise
	vec2 _distortion_sample = (texture(distortion, UV).xy * 2.0 - 1.0) * distortion_scale;
	
	float noise = noise (((UV + _noise_scroll_speed * TIME) * _noise_scale) + _distortion_sample);
	noise = step(noise, cutoff);
	
	float vornoi = vornoi(UV + _vornoi_scroll_speed * TIME  + _distortion_sample * 0.6, _columns, _rows) * _vornoi_amplitude;
	
    float wave = noise + vornoi;
	
    // Apply the wave effect to the water color
    COLOR = waterColor + wave;
	//COLOR = vec4(vec3(noise), 1);
}
