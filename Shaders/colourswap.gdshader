shader_type canvas_item;

const vec4 utilityMapRed = vec4(1.0, 0.0, 0.0, 1.0); //red - fins
const vec4 utilityMapGre  = vec4(0.0, 1.0, 0.0, 1.0); 
const vec4 utilityMapBlu  = vec4(0.0, 0.0, 1.0, 1.0); 
const vec4 utilityMapYel  = vec4(1.0, 1.0, 0.0, 1.0);
const vec4 utilityMapCya  = vec4(0.0, 1.0, 1.0, 1.0);
const vec4 utilityMapMag  = vec4(1.0, 0.0, 1.0, 1.0);
const vec4 utilityMapBla  = vec4(0.0, 0.0, 0.0, 1.0); 
const vec4 utilityMapWhi  = vec4(1.0, 1.0, 1.0, 1.0);

uniform vec4 ReplaceRed : source_color ;
uniform vec4 ReplaceGre : source_color ;
uniform vec4 ReplaceBlu : source_color ;
uniform vec4 ReplaceYel : source_color ;
uniform vec4 ReplaceCya : source_color ;
uniform vec4 ReplaceMag : source_color ;
uniform vec4 ReplaceBla : source_color ;
uniform vec4 ReplaceWhi : source_color ;

const float tolerance = 0.99;

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	
	float dist_Red = distance(tex_color.rgb, utilityMapRed.rgb);
	float dist_Gre = distance(tex_color.rgb, utilityMapGre.rgb);
	float dist_Blu = distance(tex_color.rgb, utilityMapBlu.rgb);
	float dist_Yel = distance(tex_color.rgb, utilityMapYel.rgb);
	float dist_Cya = distance(tex_color.rgb, utilityMapCya.rgb);
	float dist_Mag = distance(tex_color.rgb, utilityMapMag.rgb);
	float dist_Bla = distance(tex_color.rgb, utilityMapBla.rgb);
	float dist_Whi = distance(tex_color.rgb, utilityMapWhi.rgb);
	
	if (dist_Red < tolerance) {
		tex_color.rgb = ReplaceRed.rgb;
	}
	else if (dist_Gre < tolerance) {
		tex_color.rgb = ReplaceGre.rgb;
	}
	else if (dist_Blu < tolerance) {
		tex_color.rgb = ReplaceBlu.rgb;
	}
	else if (dist_Yel < tolerance) {
		tex_color.rgb = ReplaceYel.rgb;
	}
	else if (dist_Cya < tolerance) {
		tex_color.rgb = ReplaceCya.rgb;
	}
	else if (dist_Mag < tolerance) {
		tex_color.rgb = ReplaceMag.rgb;
	}
	else if (dist_Bla < tolerance) {
		tex_color.rgb = ReplaceBla.rgb;
	}
	else if (dist_Whi < tolerance) {
		tex_color.rgb = ReplaceWhi.rgb;
	}
	
	COLOR = tex_color;
}