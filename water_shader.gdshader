shader_type canvas_item;

uniform float speed;
uniform float aspect_ratio = 0.5;
uniform vec2 tiling = vec2(5.0, 5.0);

group_uniforms Distortion;
uniform sampler2D distortion;
uniform float distortion_scale: hint_range(0.0, 1.0, 0.001) = 0.27;

void fragment() {
	
	vec2 tiled_uvs = UV * tiling;
	tiled_uvs.y *= aspect_ratio;
	
	vec2 time_offset;
	time_offset.x = cos((TIME + tiled_uvs.x + tiled_uvs.y) * 1.0) * 0.05;
	
	vec2 _distortion_sample = (texture(distortion, UV + time_offset).xy * 2.0 - 1.0) * distortion_scale;
	
    COLOR = texture(TEXTURE, tiled_uvs + _distortion_sample + time_offset);
	//COLOR = vec4(vec3(noise), 1);
}
