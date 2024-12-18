shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (length(UV-vec2(0.5, 0.5))>=0.5){
		discard;
	}else{
		COLOR = vec4(0, 1, 0, 0.376);
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
