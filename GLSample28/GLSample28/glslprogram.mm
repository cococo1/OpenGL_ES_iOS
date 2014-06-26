#include "glslprogram.h"

//#include "glutils.h"
//#include <string.h>
//#include <fstream>
//using std::ifstream;
//using std::ios;
//
//#include <sstream>
//using std::ostringstream;
//
#include <sys/stat.h>

GLSLProgram::GLSLProgram() : handle(0), linked(false) { }

bool GLSLProgram::compileShaderFromFile( const char * fileName,
                                         GLSLShader::GLSLShaderType type )
{
    NSString* fileNameNSString = [NSString stringWithFormat:@"%s",fileName];
    NSArray* components = [fileNameNSString componentsSeparatedByString:@"."];
    if ([components count] < 2)
    {
        NSLog(@"Error shader name");
        exit(1);
    }
//    NSLog(@"%@ %@",components[0], components[1]);

    NSString* file = [[NSBundle mainBundle] pathForResource:components[0]
                                                     ofType:components[1]];
    //    NSLog(@"%@",file);
    NSError* error;
    NSString *shaderNSString =[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:&error];
    if (!shaderNSString)
    {
        NSLog(@"Failed to load vertex shader. Error: %@",error.localizedDescription);
        return false;
    }
    const GLchar* shaderCstring = (GLchar *)[shaderNSString UTF8String];
    return compileShaderFromString(shaderCstring, type);
    
    
//    /////Here starts their version
//	char bufferToStoreFileContentsInOut[4096];
//
//    FILE* file=NULL;
//	
//	fopen_s(&file,fileName,"rb");
//
//    if(file == NULL)
//    {
//        return false;
//    }
//
//    fseek(file, 0, SEEK_END);
//    int size = ftell(file);
//    rewind(file);
//
//    fread(bufferToStoreFileContentsInOut,1,size,file);
//	bufferToStoreFileContentsInOut[size]=NULL;
//
//	fclose(file);
//
//    return compileShaderFromString(bufferToStoreFileContentsInOut, type);
}

bool GLSLProgram::compileShaderFromString( const char *source, GLSLShader::GLSLShaderType type )
{
    if( handle <= 0 ) {
        handle = glCreateProgram();
        if( handle == 0)
        {
            NSLog(@"Error creating the program.");
            exit(1);
        }
    }

    GLuint shaderHandle = 0;

    switch( type ) {
    case GLSLShader::VERTEX:
        shaderHandle = glCreateShader(GL_VERTEX_SHADER);
        if( 0 == shaderHandle )
        {
            //        fprintf(stderr, "Error creating vertex shader.\n");
            NSLog(@"Error creating vertex shader.");
            exit(1);
        }
        break;
    case GLSLShader::FRAGMENT:
        shaderHandle = glCreateShader(GL_FRAGMENT_SHADER);
        if( 0 == shaderHandle )
        {
            //        fprintf(stderr, "Error creating vertex shader.\n");
            NSLog(@"Error creating fragment shader.");
            exit(1);
        }
        break;
//    case GLSLShader::GEOMETRY:
//        shaderHandle = glCreateShader(GL_GEOMETRY_SHADER);
//        break;
//    case GLSLShader::TESS_CONTROL:
//        shaderHandle = glCreateShader(GL_TESS_CONTROL_SHADER);
//        break;
//    case GLSLShader::TESS_EVALUATION:
//        shaderHandle = glCreateShader(GL_TESS_EVALUATION_SHADER);
//        break;
    default:
        return false;
    }
    int shaderStringLength = strlen(source);

//    glShaderSource(vertShader, 1, &shaderCstring, &shaderStringLength);

	   
    glShaderSource( shaderHandle, 1, &source, &shaderStringLength );

    // Compile the shader
    glCompileShader(shaderHandle );

//    GLint result;
//    glGetShaderiv( vertShader, GL_COMPILE_STATUS, &result );
//    if( GL_FALSE == result )
//    {
//        
//        //        fprintf( stderr, "Vertex shader compilation failed!\n" );
//        NSLog(@"Vertex shader compilation failed!");
//        
//        GLint logLen;
//        glGetShaderiv( vertShader, GL_INFO_LOG_LENGTH, &logLen );
//        
//        if( logLen > 0 )
//        {
//            char * log = (char *)malloc(logLen);
//            
//            GLsizei written;
//            glGetShaderInfoLog(vertShader, logLen, &written, log);
//            
//            NSLog(@"Shader log: \n%s", log);
//            
//            free(log);
//        }
//    }
    // Check for errors
    GLint result;
    glGetShaderiv( shaderHandle, GL_COMPILE_STATUS, &result );
    if( GL_FALSE == result )
    {
        NSLog(@"Frag shader compilation failed!");
        // Compile failed, store log and return false
        GLint logLen;
        glGetShaderiv(shaderHandle, GL_INFO_LOG_LENGTH, &logLen );
        if( logLen > 0 ) {
            char * c_log = new char[logLen];
            GLsizei written = 0;
            glGetShaderInfoLog(shaderHandle, logLen, &written, c_log);
            logString = c_log;
            NSLog(@"Shader log: \n%s", c_log);
            delete [] c_log;
        }

        return false;
    } else {
        // Compile succeeded, attach shader and return true
        glAttachShader(handle, shaderHandle);
        return true;
    }
}

bool GLSLProgram::link()
{
    if( linked ) return true;
    if( handle <= 0 ) return false;

    glLinkProgram(handle);

    int status = 0;
    glGetProgramiv( handle, GL_LINK_STATUS, &status);
    if( GL_FALSE == status )
    {
        NSLog(@"Failed to link shader program!");

        // Store log and return false
        GLint logLen;


        glGetProgramiv(handle, GL_INFO_LOG_LENGTH, &logLen );

        if( logLen > 0 ) {
            char * c_log = new char[logLen];
            int written = 0;
            glGetProgramInfoLog(handle, logLen, &written, c_log);
            NSLog(@"Program log: \n%s",c_log);
            logString = c_log;
            delete [] c_log;
        }

        return false;
    } else {
        linked = true;
        return linked;
    }
}

void GLSLProgram::use()
{
    if( handle <= 0 || (! linked) ) return;
    glUseProgram( handle );
}

string GLSLProgram::log()
{
    return logString;
}

int GLSLProgram::getHandle()
{
    return handle;
}

bool GLSLProgram::isLinked()
{
    return linked;
}

void GLSLProgram::bindAttribLocation( GLuint location, const char * name)
{
    glBindAttribLocation(handle, location, name);
}

void GLSLProgram::bindFragDataLocation( GLuint location, const char * name )
{
    NSLog(@"Function not defined!!!");
//    glBindFragDataLocation(handle, location, name);
}

void GLSLProgram::setUniform( const char *name, float x, float y, float z)
{
    int loc = getUniformLocation(name);
    if( loc >= 0 ) {
        glUniform3f(loc,x,y,z);
    }
}

void GLSLProgram::setUniform( const char *name, const vec3 & v)
{
    this->setUniform(name,v.x,v.y,v.z);
}

void GLSLProgram::setUniform( const char *name, const vec4 & v)
{
    int loc = getUniformLocation(name);
    if( loc >= 0 ) {
        glUniform4f(loc,v.x,v.y,v.z,v.w);
    }
}

void GLSLProgram::setUniform( const char *name, const mat4 & m)
{
    int loc = getUniformLocation(name);
    if( loc >= 0 )
    {
        glUniformMatrix4fv(loc, 1, GL_FALSE, &m[0][0]);
    }
}

void GLSLProgram::setUniform( const char *name, const mat3 & m)
{
    int loc = getUniformLocation(name);
    if( loc >= 0 )
    {
        glUniformMatrix3fv(loc, 1, GL_FALSE, &m[0][0]);
    }
}

void GLSLProgram::setUniform( const char *name, float val )
{
    int loc = getUniformLocation(name);
    if( loc >= 0 )
    {
        glUniform1f(loc, val);
    }
}

void GLSLProgram::setUniform( const char *name, int val )
{
    int loc = getUniformLocation(name);
    if( loc >= 0 )
    {
        glUniform1i(loc, val);
    }
}

void GLSLProgram::setUniform( const char *name, bool val )
{
    int loc = getUniformLocation(name);
    if( loc >= 0 )
    {
        glUniform1i(loc, val);
    }
}

void GLSLProgram::printActiveUniforms() {

    GLint nUniforms, size, location, maxLen;
    GLchar * name;
    GLsizei written;
    GLenum type;

    glGetProgramiv( handle, GL_ACTIVE_UNIFORM_MAX_LENGTH, &maxLen);
    glGetProgramiv( handle, GL_ACTIVE_UNIFORMS, &nUniforms);

    name = (GLchar *) malloc( maxLen );

    printf(" Location | Name\n");
    printf("------------------------------------------------\n");
    for( int i = 0; i < nUniforms; ++i ) {
        glGetActiveUniform( handle, i, maxLen, &written, &size, &type, name );
        location = glGetUniformLocation(handle, name);
        printf(" %-8d | %s\n",location, name);
    }

    free(name);
}

void GLSLProgram::printActiveAttribs() {

    GLint written, size, location, maxLength, nAttribs;
    GLenum type;
    GLchar * name;

    glGetProgramiv(handle, GL_ACTIVE_ATTRIBUTE_MAX_LENGTH, &maxLength);
    glGetProgramiv(handle, GL_ACTIVE_ATTRIBUTES, &nAttribs);

    name = (GLchar *) malloc( maxLength );

    printf(" Index | Name\n");
    printf("------------------------------------------------\n");
    for( int i = 0; i < nAttribs; i++ ) {
        glGetActiveAttrib( handle, i, maxLength, &written, &size, &type, name );
        location = glGetAttribLocation(handle, name);
        printf(" %-5d | %s\n",location, name);
    }

    free(name);
}

bool GLSLProgram::validate()
{
    if( ! isLinked() ) return false;

    GLint status;
    glValidateProgram( handle );
    glGetProgramiv( handle, GL_VALIDATE_STATUS, &status );

    if( GL_FALSE == status ) {
        // Store log and return false
        int length = 0;
        logString = "";

        glGetProgramiv(handle, GL_INFO_LOG_LENGTH, &length );

        if( length > 0 ) {
            char * c_log = new char[length];
            int written = 0;
            glGetProgramInfoLog(handle, length, &written, c_log);
            logString = c_log;
            delete [] c_log;
        }

        return false;
    } else {
       return true;
    }
}

int GLSLProgram::getUniformLocation(const char * name )
{
    return glGetUniformLocation(handle, name);
}

bool GLSLProgram::fileExists( const string & fileName )
{
    struct stat info;
    int ret = -1;

    ret = stat(fileName.c_str(), &info);
    return 0 == ret;
}
