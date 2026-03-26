shader_type spatial;

uniform sampler2D diffuse;
uniform sampler2D translucency;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 color = texture(diffuse, UV);
	ALBEDO = color.rgb;
	ALPHA = color.a;
}

void light() {
	float NdotL = max(dot(LIGHT, NORMAL), 0.0);
	float lit_intensity=smoothstep(0.0,0.5,NdotL*ATTENUATION);
	vec4 shadow_colour = texture(translucency, UV);
	DIFFUSE_LIGHT += mix(vec4(0), shadow_colour, lit_intensity) * ALBEDO * LIGHT_COLOR * NdotL;
}
