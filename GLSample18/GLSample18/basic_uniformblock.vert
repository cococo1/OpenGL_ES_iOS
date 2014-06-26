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

layout (location = 0) in vec3 VertexPosition;
layout (location = 1) in vec3 VertexTexCoord;

out vec3 TexCoord;

void main()
{
    TexCoord = VertexTexCoord;
    gl_Position = vec4(VertexPosition,1.0);
}
