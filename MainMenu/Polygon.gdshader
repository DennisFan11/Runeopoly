shader_type canvas_item;
uniform vec4 main_color:source_color;
uniform vec4 back_color:source_color;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;
void fragment() {
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
	if (color.r <= 0.1){
		COLOR = main_color;
	}else{
		COLOR = back_color;
	}

}