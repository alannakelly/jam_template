shader_type spatial;

void vertex() {
	COLOR=vec4(0,0,0,1);
}

void fragment() {
	ALBEDO = COLOR.rgb;
}
