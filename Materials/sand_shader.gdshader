shader_type canvas_item;

uniform float aspect_ratio;
uniform vec2 tiling = vec2(2.0, 2.0);

void fragment() {
	vec2 tiled_uvs = UV * tiling;
	tiled_uvs *= aspect_ratio;
	
	COLOR = texture(TEXTURE, tiled_uvs);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
