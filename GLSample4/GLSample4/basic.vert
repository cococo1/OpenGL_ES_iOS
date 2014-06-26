attribute vec4 vertexPosition;
//attribute vec4 vertexColor;

//varying vec4 color;

void main()
{
//	color=vertexColor;
	gl_Position = vertexPosition;
}
