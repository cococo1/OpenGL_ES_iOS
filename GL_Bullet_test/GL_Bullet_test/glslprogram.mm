#include "glslprogram.h"

//#include "glutils.h"

//#include <fstream>
//using std::ifstream;
//using std::ios;
//
//#include <sstream>
//using std::ostringstream;
//
//#include <sys/stat.h>


GLSLProgram::GLSLProgram() : handle(0), linked(false)
{
    NSLog(@"GLSL constructor");
    helper = [[GLSLProgramHelper alloc] init];
}





bool GLSLProgram::compileShaderFromFile( const char * fileName,
                                         GLSLShader::GLSLShaderType type )
{
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
    linked = [helper loadShaders];
    handle = helper.program;
    NSLog(@"handle %i",handle);
    return linked;
}



bool GLSLProgram::compileShaderFromString( const char *source, GLSLShader::GLSLShaderType type )
{
//    if( handle <= 0 ) {
//        handle = glCreateProgram();
//        if( handle == 0) {
//            logString = "Unable to create shader program.";
//            return false;
//        }
//    }
//
//    GLuint shaderHandle = 0;
//
//    switch( type ) {
//    case GLSLShader::VERTEX:
//        shaderHandle = glCreateShader(GL_VERTEX_SHADER);
//        break;
//    case GLSLShader::FRAGMENT:
//        shaderHandle = glCreateShader(GL_FRAGMENT_SHADER);
//        break;
//    case GLSLShader::GEOMETRY:
//        shaderHandle = glCreateShader(GL_GEOMETRY_SHADER);
//        break;
//    case GLSLShader::TESS_CONTROL:
//        shaderHandle = glCreateShader(GL_TESS_CONTROL_SHADER);
//        break;
//    case GLSLShader::TESS_EVALUATION:
//        shaderHandle = glCreateShader(GL_TESS_EVALUATION_SHADER);
//        break;
//    default:
//        return false;
//    }
//	    
//    glShaderSource( shaderHandle, 1, &source, NULL );
//
//    // Compile the shader
//    glCompileShader(shaderHandle );
//
//    // Check for errors
//    int result;
//    glGetShaderiv( shaderHandle, GL_COMPILE_STATUS, &result );
//    if( GL_FALSE == result ) {
//        // Compile failed, store log and return false
//        int length = 0;
//        logString = "";
//        glGetShaderiv(shaderHandle, GL_INFO_LOG_LENGTH, &length );
//        if( length > 0 ) {
//            char * c_log = new char[length];
//            int written = 0;
//            glGetShaderInfoLog(shaderHandle, length, &written, c_log);
//            logString = c_log;
//            delete [] c_log;
//        }
//
//        return false;
//    } else {
//        // Compile succeeded, attach shader and return true
//        glAttachShader(handle, shaderHandle);
//        return true;
//    }
    return NO;
}

bool GLSLProgram::link()
{
//    if( linked ) return true;
//    if( handle <= 0 ) return false;
//
//    glLinkProgram(handle);
//
//    int status = 0;
//    glGetProgramiv( handle, GL_LINK_STATUS, &status);
//    if( GL_FALSE == status ) {
//        // Store log and return false
//        int length = 0;
//        logString = "";
//
//        glGetProgramiv(handle, GL_INFO_LOG_LENGTH, &length );
//
//        if( length > 0 ) {
//            char * c_log = new char[length];
//            int written = 0;
//            glGetProgramInfoLog(handle, length, &written, c_log);
//            logString = c_log;
//            delete [] c_log;
//        }
//
//        return false;
//    } else {
//        linked = true;
//        return linked;
//    }
    return NO;
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
    NSLog(@"ERROR!!! void GLSLProgram::bindFragDataLocation( GLuint location, const char * name )");
    //glBindFragDataLocation(handle, location, name);
}

void GLSLProgram::setUniform( const char *name, float x, float y, float z)
{
    int loc = getUniformLocation(name);
//    NSLog(@"%i",loc);
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
//    NSLog(@"%i %s %i",loc, name, handle);

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
    int r = glGetUniformLocation(handle, name);
    if (r<0) {
        NSLog(@"handler: %i %s %i",handle,name,r);
    }
    return r;
}

bool GLSLProgram::fileExists( const string & fileName )
{
//    struct stat info;
//    int ret = -1;
//
//    ret = stat(fileName.c_str(), &info);
//    return 0 == ret;
    return NO;
}
