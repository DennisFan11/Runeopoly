shader_type canvas_item;
uniform float speed=1.0;

void fragment() {
	COLOR = texture(TEXTURE, UV - vec2(TIME*speed, 0.0));
}