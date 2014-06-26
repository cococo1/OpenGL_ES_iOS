#version 330

//http://renderingpipeline.com/2012/03/shader-model-and-glsl-versions/
//OpenGL GLSL
//ver	 #ver	
//2.0		
//2.1	 120	
//3.0	 130	
//3.1	 140
//3.2	 150	
//3.3	 330
//4.0	 400
//4.1	 410	
//4.2	 420	
//4.3	 430	

in vec3 TexCoord;
layout (location = 0) out vec4 FragColor;

uniform BlobSettings {
  vec4 InnerColor;
  vec4 OuterColor;
  float RadiusInner;
  float RadiusOuter;
};

void main() {
    float dx = TexCoord.x - 0.5;
    float dy = TexCoord.y - 0.5;
    float dist = sqrt(dx * dx + dy * dy);
    FragColor =
       mix( InnerColor, OuterColor,
             smoothstep( RadiusInner, RadiusOuter, dist )
            );
}
