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


uniform int colour_replace_function : hint_range(0, 100, 1) =0 ;

const float tolerance_low = 0.866;
const float tolerance_high = 0.867;

vec3 eight_sphere_replace(vec3 tmp_col) {
	float dist_Red = distance(tmp_col, utilityMapRed.rgb);
	float dist_Gre = distance(tmp_col, utilityMapGre.rgb);
	float dist_Blu = distance(tmp_col, utilityMapBlu.rgb);
	float dist_Yel = distance(tmp_col, utilityMapYel.rgb);
	float dist_Cya = distance(tmp_col, utilityMapCya.rgb);
	float dist_Mag = distance(tmp_col, utilityMapMag.rgb);
	float dist_Bla = distance(tmp_col, utilityMapBla.rgb);
	float dist_Whi = distance(tmp_col, utilityMapWhi.rgb);
	
	if (dist_Red < tolerance_low) {
		float dist = dist_Red;
		tmp_col = ReplaceRed.rgb;
	}
	else if (dist_Gre < tolerance_low) {
		tmp_col = ReplaceGre.rgb;
		float dist = dist_Gre;
	}
	else if (dist_Blu < tolerance_low) {
		tmp_col = ReplaceBlu.rgb;
		float dist = dist_Blu;
	}
	else if (dist_Yel < tolerance_low) {
		tmp_col = ReplaceYel.rgb;
		float dist = dist_Yel;
	}
	else if (dist_Cya < tolerance_low) {
		tmp_col = ReplaceCya.rgb;
		float dist = dist_Cya;
	}
	else if (dist_Mag < tolerance_low) {
		tmp_col = ReplaceMag.rgb;
		float dist = dist_Mag;
	}
	else if (dist_Bla < tolerance_low) {
		tmp_col = ReplaceBla.rgb;
		float dist = dist_Bla;
	}
	else if (dist_Whi < tolerance_low) {
		tmp_col = ReplaceWhi.rgb;
		float dist = dist_Whi;
	}
	else {
		if (dist_Red < tolerance_high) {
			float dist = dist_Red;
			tmp_col = ReplaceRed.rgb;
		}
		else if (dist_Gre < tolerance_high) {
			tmp_col = ReplaceGre.rgb;
			float dist = dist_Gre;
		}
		else if (dist_Blu < tolerance_high) {
			tmp_col = ReplaceBlu.rgb;
			float dist = dist_Blu;
		}
		else if (dist_Yel < tolerance_high) {
			tmp_col = ReplaceYel.rgb;
			float dist = dist_Yel;
		}
		else if (dist_Cya < tolerance_high) {
			tmp_col = ReplaceCya.rgb;
			float dist = dist_Cya;
		}
		else if (dist_Mag < tolerance_high) {
			tmp_col = ReplaceMag.rgb;
			float dist = dist_Mag;
		}
		else if (dist_Bla < tolerance_high) {
			tmp_col = ReplaceBla.rgb;
			float dist = dist_Bla;
		}
		else if (dist_Whi < tolerance_high) {
			tmp_col = ReplaceWhi.rgb;
			float dist = dist_Whi;
		}
	}
	
	

    return tmp_col;
}

void fragment() {
	
	vec4 tex_color = texture(TEXTURE, UV);
    vec3 og_col = tex_color.rgb;
    vec3 tmp_col = og_col;
	
	if( colour_replace_function == 0 ) {
		tmp_col = eight_sphere_replace(tmp_col);
	}
	else if ( colour_replace_function == 1 ) {
		tmp_col = vec3(0.0, 0.0, 0.0);
	}
	else if ( colour_replace_function == 2 ) {
	}
	else if ( colour_replace_function == 3 ) {
	}
	else if ( colour_replace_function == 4 ) {
	}
	else if ( colour_replace_function == 5 ) {
	}
	else if ( colour_replace_function == 6 ) {
	}
	else {
		tmp_col = eight_sphere_replace(tmp_col);
	}
	
	COLOR.rgb = tmp_col;
}
