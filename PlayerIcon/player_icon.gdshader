shader_type canvas_item;

void fragment() {
	vec4 base = vec4(1.0, 1.0, 1.0, 1.0);
	COLOR.a = 1.0 - length(UV-vec2(0.5, 0.5))*2.0;
}