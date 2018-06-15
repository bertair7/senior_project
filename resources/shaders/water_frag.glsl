#version 330 core
uniform sampler2D Texture0;

//in vec3 fragNor;
in vec2 fragTex;
in float dCo;
in vec4 viewSpace;

uniform int fogSelector, depthFog;

out vec4 color;

const vec3 fogColor = vec3(0.7f);
const float FogDensity = 0.05;

void main() {
    //vec4 texColor0 = texture(Texture0, vTexCoord);
    
    color = texture(Texture0, fragTex);
    
    //DEBUG:Outcolor = vec4(vTexCoord.s, vTexCoord.t, 0, 1);

	vec3 waterColor = color.rgb;
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
		mixedColor = mix(fogColor, waterColor, fogFactor);
	}
	else if (fogSelector == 1) { //exponential fog
		fogFactor = 1.0/exp(dist * FogDensity);
		fogFactor = clamp(fogFactor, 0.0, 1.0);
		mixedColor = mix(fogColor, waterColor, fogFactor);
	}
	else if (fogSelector == 2) { 
		fogFactor = 1.0/exp( (dist * FogDensity) * (dist * FogDensity));
		fogFactor = clamp(fogFactor, 0.0, 1.0);
		mixedColor = mix(fogColor, waterColor, fogFactor);
	}
	color = vec4(mixedColor, 1.0);
}

