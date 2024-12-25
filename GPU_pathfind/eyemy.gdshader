shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE:hint_screen_texture, filter_nearest;
void fragment() {
	if ( textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).a != 0.0){
		COLOR = vec4(0.0, 0.0, 0.1, 1.0);
	}else{
		COLOR = vec4(0.0, 0.0, 0.0, 0.0);;
	}
}
