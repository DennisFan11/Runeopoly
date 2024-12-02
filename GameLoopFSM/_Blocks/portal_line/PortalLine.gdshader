shader_type canvas_item;

uniform sampler2D color_gradient;
uniform sampler2D curve;
uniform sampler2D noiseTexture :repeat_enable;
uniform float speed: hint_range (0.0,5.0);
uniform float variation: hint_range (0.0,2.0);
uniform float width: hint_range (0.0,1.0);

void fragment(){
	vec2 noise_uv;
	if (UV.y>=0.5){
		noise_uv = vec2(UV.x, UV.y+TIME*speed);
	}else{
		noise_uv = vec2(UV.x, UV.y-TIME*speed);
	}

	float dist_to_center = abs(UV.y-0.5); // 0~0.5

	//vec2 fixed_uv = vec2(UV.x, dist_to_center);

	dist_to_center += texture(noiseTexture, noise_uv).r * variation;

	if (dist_to_center > width){
		discard;
	}
	float mount = texture(curve, vec2(dist_to_center/width,0.0)).r;
	COLOR = texture(color_gradient, vec2(mount,0.0));
	//COLOR.rg = UV;

}













//