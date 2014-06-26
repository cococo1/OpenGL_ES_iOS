//
//  File2.cpp
//  GL_Bullet_test
//
//  Created by Maxim Chetrusca on 5/5/13.
//  Copyright (c) 2013 Magicindie. All rights reserved.
//

#include "File2.h"
//#import "OpenGLViewController.h"
#include <btBulletDynamicsCommon.h>
#include <btBulletCollisionCommon.h>
//#include "GLDebugDrawer.h"
#include "vbocube.h"
//#include "cTexture.h"


#define SAFE_DELETE(x) { if( x ) { delete (x); (x)=NULL; } }


//cTexture tex;

using glm::mat4;
using glm::vec3;



VBOCube *cube;
mat4 model;
mat4 view;
mat4 projection;
float angle;
GLSLProgram prog;




//Bullet physics variables:
btDefaultCollisionConfiguration* collisionConfiguration = NULL;
btCollisionDispatcher* dispatcher = NULL;
btBroadphaseInterface* overlappingPairCache = NULL;
btSequentialImpulseConstraintSolver* solver = NULL;
btDiscreteDynamicsWorld* dynamicsWorld = NULL;

//static GLDebugDrawer debugDrawer;
//keep track of the shapes, we release memory at exit.
//make sure to re-use collision shapes among rigid bodies whenever possible!
btAlignedObjectArray<btCollisionShape*> collisionShapes;
btCollisionShape* boxShape1 = NULL;
btRigidBody* boxBody1 = NULL;
btCollisionShape* boxShape2 = NULL;
btRigidBody* boxBody2 = NULL;
btRigidBody* groundBody = NULL;
btVector3 groundBodyDims(5.0f, 0.1f, 5.0f);

void initPhysics();
void createGroundBox();
btRigidBody* createBox(const btVector3& pos, btCollisionShape** shape);
void closePhysics();

OpenGL1::OpenGL1():OpenGL(){}

OpenGL1::OpenGL1(const OpenGL1& copy):OpenGL(copy){}

OpenGL1::~OpenGL1()
{
    closePhysics();
}

void* OpenGL1::getProgram()
{
    return &prog;
}

void OpenGL1::init()
{
//    OpenGLViewController *openglvc = [[OpenGLViewController alloc]init];
//    openglvc.prog = &prog;
//    [openglvc akaViewDidLoad];
    
    glEnable(GL_DEPTH_TEST);

    initPhysics();
    createGroundBox();
	boxBody1 = createBox(btVector3(0.0f, 3.0f, 0.0f), &boxShape1);
	boxBody2 = createBox(btVector3(-1.0f, 2.0f, 0.0f), &boxShape2);
    
    cube = new VBOCube();
    
    view = glm::lookAt(vec3(5.0f,3.0f,5.0f), vec3(0.0f,0.0f,0.0f), vec3(0.0f,1.0f,0.0f));
    projection = mat4(1.0f);
    
    angle = 0.0;
    
    prog.setUniform("Light.Intensity", vec3(1.0f,1.0f,1.0f) );
    
//    // Load texture file
//    const char * texName = "texture/brick1.jpg";
//	
//	tex.LoadFromFile(texName);
//    
//    // Copy file to OpenGL
//    glActiveTexture(GL_TEXTURE0);
//	glBindTexture(GL_TEXTURE_2D, tex.GetTextureHandle());
//    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
//    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
//    prog.setUniform("Tex1", 0);
    
//    [openglvc loadContext];
//    [openglvc loadShaders];
}

void OpenGL1::update(int dt)
{
    angle += 0.5f;
    dynamicsWorld->stepSimulation(1.0f/60.0f, 10);


    
}
void OpenGL1::setMatrices()
{
    mat4 mv = view * model;
    prog.setUniform("ModelViewMatrix", mv);
    prog.setUniform("NormalMatrix",
                    mat3( vec3(mv[0]), vec3(mv[1]), vec3(mv[2]) ));
    
//    glm::mat4 m = glm::mat4(1);
    prog.setUniform("MVP", projection * mv);
    
}
void OpenGL1::render()
{
    reshape(320, 480);
    glClearColor(1.0, 0, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
	model = mat4(1.0f);
	setMatrices();
    
	prog.setUniform("Material.Ka", 1.0f, 0.0f, 0.1f);
    
	dynamicsWorld->debugDrawWorld();
    
    prog.setUniform("Light.Position", vec4(0.0f,0.0f,0.0f,1.0f) );
    prog.setUniform("Material.Kd", 0.9f, 0.9f, 0.9f);
    prog.setUniform("Material.Ks", 0.95f, 0.95f, 0.95f);
    prog.setUniform("Material.Ka", 0.1f, 0.1f, 0.1f);
    prog.setUniform("Material.Shininess", 100.0f);
    
	//Draw boxBody1
	btTransform transform;
	//boxBody1->getMotionState()->getWorldTransform(transform);
	transform = boxBody1->getInterpolationWorldTransform();
	
	btMatrix3x3 mat = transform.getBasis();
	model[0][0] = mat[0][0]; model[0][1] = mat[1][0]; model[0][2] = mat[2][0];
	model[1][0] = mat[0][1]; model[1][1] = mat[1][1]; model[1][2] = mat[2][1];
	model[2][0] = mat[0][2]; model[2][1] = mat[1][2]; model[2][2] = mat[2][2];
	btVector3 pos = transform.getOrigin();
	model[3][0] = pos.x(); model[3][1] = pos.y(); model[3][2] = pos.z();
    
    setMatrices();
    cube->render();
    
	//Draw boxBody2
	//boxBody2->getMotionState()->getWorldTransform(transform);
	transform = boxBody2->getInterpolationWorldTransform();
    
	mat = transform.getBasis();
	model[0][0] = mat[0][0]; model[0][1] = mat[1][0]; model[0][2] = mat[2][0];
	model[1][0] = mat[0][1]; model[1][1] = mat[1][1]; model[1][2] = mat[2][1];
	model[2][0] = mat[0][2]; model[2][1] = mat[1][2]; model[2][2] = mat[2][2];
	pos = transform.getOrigin();
	model[3][0] = pos.x(); model[3][1] = pos.y(); model[3][2] = pos.z();
    
    setMatrices();
    cube->render();
    
	//Draw ground
	/*groundBody->getMotionState()->getWorldTransform(transform);
     
     mat = transform.getBasis();
     model[0][0] = mat[0][0]; model[0][1] = mat[0][1]; model[0][2] = mat[0][2];
     model[1][0] = mat[1][0]; model[1][1] = mat[1][1]; model[1][2] = mat[1][2];
     model[2][0] = mat[2][0]; model[2][1] = mat[2][1]; model[2][2] = mat[2][2];
     
     pos = transform.getOrigin();
     model[3][0] = pos.x(); model[3][1] = pos.y(); model[3][2] = pos.z();
     
     mat4 scale;
     scale = glm::scale<float>( vec3(2*groundBodyDims.x(), 2*groundBodyDims.y(), 2*groundBodyDims.z()));
     model = model * scale;
     
     setMatrices();
     cube->render();*/
    
//	glutSwapBuffers();
}
void OpenGL1::reshape(int width, int height)
{
//    NSLog(@"reshape");
    projection = glm::perspective(60.0f, (float)width/height, 0.3f, 100.0f);

    
}
void OpenGL1::keyboard (unsigned char key, int x, int y)
{
    
}
void OpenGL1::getGlVersion(int *major, int *minor)
{
    
}

void OpenGL1::getGlslVersion(int *major, int *minor)
{
    
}
int OpenGL1::main(int argc, char* argv[])
{
    init();
    return 0;
}

//mat4 OpenGL1::getProjectionMatrix()
//{
//    return projection;
//}
//mat4 OpenGL1::getModelMatrix()
//{
//    return view;
//}
//mat4 OpenGL1::getViewMatrix()
//{
//    return model;
//}

void initPhysics()
{
	collisionConfiguration = new ::btDefaultCollisionConfiguration();
	dispatcher = new ::btCollisionDispatcher(collisionConfiguration);
	
	overlappingPairCache = new btDbvtBroadphase();
	//overlappingPairCache = new ::btAxisSweep3(btVector3(-10, -10, -10), btVector3(10, 10, 10));
    
	solver = new btSequentialImpulseConstraintSolver();
    
	dynamicsWorld = new btDiscreteDynamicsWorld(dispatcher,overlappingPairCache,solver,collisionConfiguration);
    
	dynamicsWorld->setGravity(btVector3(0,-10,0));
    
//	debugDrawer.setDebugMode(btIDebugDraw::DBG_DrawWireframe | btIDebugDraw::DBG_DrawNormals);
//	dynamicsWorld->setDebugDrawer(&debugDrawer);
}

void createGroundBox()
{
	btCollisionShape* groundBox = new ::btBoxShape(groundBodyDims);
    
	collisionShapes.push_back(groundBox);
    
	btTransform groundTransform;
	groundTransform.setIdentity();
	//groundTransform.setOrigin(btVector3(0.0f, 0.0f, 0.0f));
	btScalar mass = 0.0f;	// mass=0 -> static body
    
	btDefaultMotionState* myMotionState = new btDefaultMotionState(groundTransform);
	
	btRigidBody::btRigidBodyConstructionInfo rbInfo(mass, myMotionState, groundBox);
	groundBody = new btRigidBody(rbInfo);
	groundBody->setFriction(0.5);
	dynamicsWorld->addRigidBody(groundBody);
}

btRigidBody* createBox(const btVector3& pos, btCollisionShape** boxShape)
{
	*boxShape = new btBoxShape(btVector3(0.5f, 0.5f, 0.5f));
	collisionShapes.push_back(*boxShape);
    
	btTransform boxTransform(btQuaternion(), pos);
	btScalar	mass = 1.0f;
	btVector3 localInertia(0,0,0);
	(*boxShape)->calculateLocalInertia(mass, localInertia);
    
	btDefaultMotionState* myMotionState = new btDefaultMotionState(boxTransform);
	btRigidBody::btRigidBodyConstructionInfo rbInfo(mass, myMotionState, *boxShape, localInertia);
	btRigidBody *boxBody = new btRigidBody(rbInfo);
    
	dynamicsWorld->addRigidBody(boxBody);
    
	return boxBody;
}

void closePhysics()
{
	//remove the rigidbodies from the dynamics world and delete them
	for(int i=dynamicsWorld->getNumCollisionObjects()-1; i>=0 ;i--)
	{
		btCollisionObject* obj = dynamicsWorld->getCollisionObjectArray()[i];
		btRigidBody* body = btRigidBody::upcast(obj);
		if (body && body->getMotionState())
		{
			delete body->getMotionState();
		}
		dynamicsWorld->removeCollisionObject( obj );
		delete obj;
	}
    
	//delete collision shapes
	for (int j=0;j<collisionShapes.size();j++)
	{
		btCollisionShape* shape = collisionShapes[j];
		collisionShapes[j] = 0;
		delete shape;
	}
    
	//delete dynamics world
	SAFE_DELETE( dynamicsWorld );
    
	//delete solver
	SAFE_DELETE( solver );
    
	//delete broadphase
	SAFE_DELETE( overlappingPairCache );
    
	//delete dispatcher
	SAFE_DELETE( dispatcher );
    
	SAFE_DELETE( collisionConfiguration );
    
	//next line is optional: it will be cleared by the destructor when the array goes out of scope
	collisionShapes.clear();
}


