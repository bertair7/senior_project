#version 330 core

in vec3 texcoords;
in vec4 viewSpace;

uniform samplerCube cube_texture;
uniform int fogSelector;
uniform int depthFog;

out vec4 frag_colour;

const vec3 fogColor = vec3(0.7f);
const float FogDensity = 0.025;

void main() {
	frag_colour = texture(cube_texture, texcoords);

	vec3 skyColor = frag_colour.rgb;
	vec3 mixedColor = vec3(0.0f);
	float dist = 0;
	float fogFactor = 0;

	if (depthFog == 0) { //plane based
		dist = abs(viewSpace.z);
	}
	else { //range based
		dist = length(viewSpace);
	}

	if (fogSelector == 0) { //linear fog
		fogFactor = (80 - dist)/70;
		fogFactor = clamp(fogFactor, 0.0, 1.0);
		mixedColor = mix(fogColor, skyColor, fogFactor);
	}
	else if (fogSelector == 1) { //exponential fog
		fogFactor = 1.0/exp(dist * FogDensity);
		fogFactor = clamp(fogFactor, 0.0, 1.0);
		mixedColor = mix(fogColor, skyColor, fogFactor);
	}
	else if (fogSelector == 2) { 
		fogFactor = 1.0/exp( (dist * FogDensity) * (dist * FogDensity));
		fogFactor = clamp(fogFactor, 0.0, 1.0);
		mixedColor = mix(fogColor, skyColor, fogFactor);
	}

	frag_colour = vec4(mixedColor, 1.0);
}