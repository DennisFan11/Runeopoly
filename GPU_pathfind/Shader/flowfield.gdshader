shader_type canvas_item;

const float INCREMENT = 0.0001; // 0.0000001
void fragment() {

	// get neightbor
	vec4 left = textureLod(TEXTURE, UV+vec2(-TEXTURE_PIXEL_SIZE.x, 0.0), 0.0);
	vec4 right = textureLod(TEXTURE, UV+vec2(TEXTURE_PIXEL_SIZE.x, 0.0), 0.0);
	vec4 up = textureLod(TEXTURE, UV+vec2(0.0, -TEXTURE_PIXEL_SIZE.y), 0.0);
	vec4 down = textureLod(TEXTURE, UV+vec2(0.0, TEXTURE_PIXEL_SIZE.y), 0.0);
	vec4 up_left = textureLod(TEXTURE, UV+vec2(-TEXTURE_PIXEL_SIZE.x, -TEXTURE_PIXEL_SIZE.y), 0.0);
	vec4 up_right = textureLod(TEXTURE, UV+vec2(TEXTURE_PIXEL_SIZE.x, -TEXTURE_PIXEL_SIZE.y), 0.0);
	vec4 down_left = textureLod(TEXTURE, UV+vec2(-TEXTURE_PIXEL_SIZE.x, TEXTURE_PIXEL_SIZE.y), 0.0);
	vec4 down_right = textureLod(TEXTURE, UV+vec2(TEXTURE_PIXEL_SIZE.x, TEXTURE_PIXEL_SIZE.y), 0.0);

	// 設置透明度為最大
	COLOR.a = 1.0;

	// 計算顏色b（熱度圖），並減少最小增量
	float temp = max(max(up.b, down.b), max(left.b, right.b));
	temp = max(temp, max(up_left.b, down_right.b));
	temp = max(temp, max(up_right.b, down_left.b));

	COLOR.b = temp - INCREMENT;
	COLOR.b = max(max(up.b, down.b), max(left.b, right.b)) - INCREMENT;

	// 根據最大值設置顏色方向
	if (left.b == temp){
		COLOR.rg = vec2(-1.0, 0.0);
	}else if (right.b == temp){
		COLOR.rg = vec2(1.0, 0.0);
	}else if (up.b == temp){
		COLOR.rg = vec2(0.0, -1.0);
	}else if (down.b == temp){
		COLOR.rg = vec2(0.0, 1.0);
	}else if (up_left.b == temp){
		COLOR.rg = vec2(-1.0, -1.0);
	}else if (up_right.b == temp){
		COLOR.rg = vec2(1.0, -1.0);
	}else if (down_left.b == temp){
		COLOR.rg = vec2(-1.0, 1.0);
	}else if (down_right.b == temp){
		COLOR.rg = vec2(1.0, 1.0);
	}

	COLOR.rg = normalize(COLOR.rg);

}
