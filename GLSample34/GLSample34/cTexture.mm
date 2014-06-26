#include "cTexture.h"

cTexture::cTexture(void)
{
	texHandle=-1;
	strcpy(texPath,"null");
}

cTexture::~cTexture(void)
{
	if(texHandle>=0)
	glDeleteTextures(1,&texHandle);
}
void cTexture::LoadFromFile(const char *filePathIn)
{
	strcpy(texPath,filePathIn);
//	texHandle = SOIL_load_OGL_texture(
//	filePathIn,
//    SOIL_LOAD_RGBA,
//	SOIL_CREATE_NEW_ID,
//	SOIL_FLAG_MIPMAPS|SOIL_FLAG_INVERT_Y);
//    glActiveTexture(GL_TEXTURE0);
    GLKTextureInfo *spriteTexture;
    NSError *theError;
    
    NSString* fileNameNSString = [NSString stringWithFormat:@"%s",filePathIn];
    NSArray* components = [fileNameNSString componentsSeparatedByString:@"."];
    if ([components count] < 2)
    {
        NSLog(@"Error shader name");
        exit(1);
    }
    NSLog(@"%@ %@",components[0], components[1]);
    
    NSString* file = [[NSBundle mainBundle] pathForResource:components[0]
                                                     ofType:components[1]];

//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"brick1" ofType:@"jpg"]; // 1
    if (!file)
    {
        NSLog(@"No file for texture.");
    }

    spriteTexture = [GLKTextureLoader textureWithContentsOfFile:file options:nil error:&theError]; // 2

    if (spriteTexture == nil)
        NSLog(@"Error loading texture: %@", [theError localizedDescription]);

    texHandle = spriteTexture.name;
//    glTexParameteri(texHandle, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
//	glTexParameteri(texHandle, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
//	glTexParameteri(texHandle, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
//	glTexParameteri(texHandle, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

//    glBindTexture(spriteTexture.target, spriteTexture.name); // 3
//    glEnable(spriteTexture.target); // 4
}
GLuint cTexture::GetTextureHandle()
{
	return this->texHandle;	
}

const char * cTexture::GetTexturePath()
{
	return texPath;
}

