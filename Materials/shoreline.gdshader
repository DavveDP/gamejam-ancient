shader_type canvas_item;

void fragment() {
	
	float color = 0.0;
	
	
	if (abs(UV.y + sin(UV.x * 16.0 * PI - sin(TIME*1.2))*0.15 * sin(TIME) - 0.5) < 0.2)
	{
		color = 1.0;
	}
	
	float wave = sin(UV.x * 2.0 * PI);
	
	
	COLOR = vec4(color);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
