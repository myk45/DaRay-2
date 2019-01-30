
void intersectSphere(in vec3 Rd, out vec4 col, vec3 O)
{
    vec3 C  = vec3(0, 0, 2);
    
    C = O-C;
        
    float a = dot(Rd, Rd);
   	float b = -2.0 * dot(Rd, C);
	float c = dot(C,C) - 1.0;   
    float d = b*b - (4.0 * a * c); 
        
    if (d  > 0.0) {
    	float t = -b + sqrt(d)/2.0;
        vec3 c = vec3(0.5, 0.5, 0.5);
            
        vec3 light = vec3(sin(iTime)*1.0, cos(iTime)*1.0, 0.0);
        //vec3 light = vec3(1.0, 0.0, 0.0);
        col = vec4(1.0, 0.0, 0.0, 1.0) * dot(Rd, light) + vec4(0.2, 0.2, 0.2, 1.0);
    }  
}

void intersectPlane(in vec3 Rd, out vec4 col)
{
    vec3 mNormal = vec3(0, 1, 0);
    vec3 PointOnPlane = vec3(0, -1.0, 0);
    vec3 Cam = vec3(0, 0, 0);

    float t = (dot(PointOnPlane, mNormal) - dot(Cam, mNormal)) / dot(Rd, mNormal);    
    if (t > 0.0) 
    {
    	col = vec4(0.3, 0.6, 1.0,  1.0);
        //col = vec4(sin(length(Rd*t)));
        //col = vec4(0.2, 0.7, 0.5, 1.0)*vec4(sin(length(Rd*t)));
        
        // Add some shadow!
        {
            vec3 point = Rd*t;
            vec3 light = vec3(sin(iTime)*1.0, cos(iTime)*1.0, 0.0);
            vec3 tempRay = point - light;
            tempRay = normalize(tempRay);
            vec3 C  = vec3(0, 0, 2);
    		C = point-C;
        
    		float a = dot(tempRay, tempRay);
   			float b = -2.0 * dot(tempRay, C);
			float c = dot(C,C) - 1.0;   
   			float d = b*b - (4.0 * a * c); 
        
	    	if (d  > 0.0) {
                col = vec4(0);
			}
    	}
	}
}




void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from -1 to 1)
    vec2 uv = (-1.0 + 2.0*fragCoord.xy / iResolution.xy) * vec2(iResolution.x/iResolution.y, 1.0);
    vec4 col = vec4(0.3);
    
    vec3 Rd = vec3(uv, 1.0);
    Rd = normalize(Rd);
    
	intersectPlane(Rd, col);    
    intersectSphere(Rd, col, vec3(0));
        
        
    fragColor = col;
}