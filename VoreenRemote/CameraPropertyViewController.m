//
//  CameraPropertyViewController.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "CameraPropertyViewController.h"
#import "NSLogAddition.h"
#import "common.h"
#import <GLKit/GLKit.h>

typedef struct {
    float Position[3];
    float Color[4];
} Vertex;

#define SIZE 0.5f

const Vertex Vertices[] = {
    {{SIZE,-SIZE,SIZE},{1,0,1,1}},   // 0
    {{-SIZE,SIZE,SIZE},{0,1,1,1}},   // 1
    {{-SIZE,-SIZE,SIZE},{0,0,1,1}},  // 2
    {{SIZE,SIZE,-SIZE},{1,1,0,1}},   // 3
    {{SIZE,-SIZE,-SIZE},{1,0,0,1}},  // 4
    {{-SIZE,SIZE,-SIZE},{0,1,0,1}},  // 5
    {{-SIZE,-SIZE,-SIZE},{0,0,0,1}}, // 6
    {{SIZE,SIZE,SIZE}, {1,1,1,1}}    // 7
};

const GLubyte Indices[] = {
    6,5,4, 3,4,5,   // black, red, green, yellow
    4,3,0, 7,0,3,   // red, magenta, yellow, white
    0,7,2, 1,2,7,   // magenta, white, blue, cyan
    2,5,6, 1,5,2,   // blue, green, black, cyan
    5,1,3, 7,3,1,   // green, yellow, cyan, white
    0,2,4, 2,6,4    // magenta, blue, red, black
};

@interface CameraPropertyViewController () {
    GLuint _vertexBuffer;
    GLuint _indexBuffer;
    
    GLKVector3 _center;
    float _size;
    CGPoint _panLastPosition;
}

- (GLKVector3)projectToSphere:(GLKVector2)point;

@property (nonatomic, assign) EAGLContext* context;
@property (nonatomic, retain) GLKBaseEffect* effect;

@end

@implementation CameraPropertyViewController

@synthesize property = _property;
@synthesize context = _context;
@synthesize effect = _effect;

- (id)initWithProperty:(Property*)property {
    self = [super initWithNibName:@"CameraPropertyViewController" bundle:nil];
    
    if (![property isKindOfClass:[CameraProperty class]])
        ULog(@"Property is not of Class CameraProperty");
    
    self.property = (CameraProperty*)property;
    
    EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    GLKView* view = [[GLKView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.context = context;
    view.delegate = self;
    
    UIRotationGestureRecognizer* rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
    rotation.delegate = self;
    UIPanGestureRecognizer* singlePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSinglePan:)];
    singlePan.minimumNumberOfTouches = 1;
    singlePan.maximumNumberOfTouches = 1;
    singlePan.delegate = self;
    UIPanGestureRecognizer* doublePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoublePan:)];
    doublePan.minimumNumberOfTouches = 2;
    doublePan.delegate = self;
    UIPinchGestureRecognizer* pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    pinch.delegate = self;
    
    [view addGestureRecognizer:rotation];
    [view addGestureRecognizer:singlePan];
    [view addGestureRecognizer:doublePan];
    [view addGestureRecognizer:pinch];
    
    self.view = view;
    self.context = context;
    
    _size = 0.5f;
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [EAGLContext setCurrentContext:self.context];
    
    self.effect = [[GLKBaseEffect alloc] init];
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
    
    glGenBuffers(1, &_indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
    
    _center = self.property.focus;
    
    
    [super viewDidLoad];
}

- (void)dealloc {
    [super dealloc];
}

- (void)viewDidUnload {
    [EAGLContext setCurrentContext:self.context];
    
    self.effect = nil;
    
    glDeleteBuffers(1, &_vertexBuffer);
    glDeleteBuffers(1, &_indexBuffer);
    
    [super viewDidUnload];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glEnable(GL_CULL_FACE);
    glCullFace(GL_BACK);
    
    glClearColor(0.f, 0.f, 0.f, 1.f);
    glClear(GL_COLOR_BUFFER_BIT);
    float aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.01f, 50.0f);
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    GLKVector3 position = self.property.position;
    GLKVector3 focus = self.property.focus;
    GLKVector3 upVector = self.property.upVector;
    self.effect.transform.modelviewMatrix = GLKMatrix4MakeLookAt(position.x, position.y, position.z, focus.x, focus.y, focus.z, upVector.x, upVector.y, upVector.z);
    
    [self.effect prepareToDraw];
    
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *) offsetof(Vertex, Position));
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *) offsetof(Vertex, Color));
    
    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]), GL_UNSIGNED_BYTE, 0);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (IBAction)handleSinglePan:(UIGestureRecognizer *)recognizer {
    UIPanGestureRecognizer* panRecognizer = (UIPanGestureRecognizer*)recognizer;
    CGPoint new = [panRecognizer locationInView:self.view];
    CGPoint translation = [panRecognizer translationInView:self.view];
    CGPoint old = CGPointMake(new.x - translation.x, new.y - translation.y);
    new.x /= self.view.frame.size.width;
    new.y /= self.view.frame.size.height;
    new.y = 1.f - new.y;
    new.x -= 0.5f;
    new.x *= 2.f;
    new.y -= 0.5f;
    new.y *= 2.f;
    old.x /= self.view.frame.size.width;
    old.y /= self.view.frame.size.height;
    old.y = 1.f - old.y;
    old.x -= 0.5f;
    old.x *= 2.f;
    old.y -= 0.5f;
    old.y *= 2.f;
    
    
    GLKVector3 p1 = [self projectToSphere:GLKVector2Make(old.x, old.y)];
    GLKVector3 p2 = [self projectToSphere:GLKVector2Make(new.x, new.y)];
    GLKVector3 axis = GLKVector3CrossProduct(p2, p1);
    
    GLKVector3 length = GLKVector3Subtract(p1, p2);
    float t = GLKVector3Length(length) / (2.f * _size);
    
    if (t > 1.f)
        t = 1.f;
    if (t < -1.f)
        t = -1.f;
    
    float phi = 8.f * asinf(t);
    
    GLKMatrix3 axisRotationMatrix = GLKMatrix4GetMatrix3(self.effect.transform.modelviewMatrix);
    bool invertible;
    GLKMatrix3 axisRotationMatrixInv = GLKMatrix3Invert(axisRotationMatrix, &invertible);
    if (!invertible)
        ALog(@"Matrix not invertible");
    
    GLKVector3 transformedAxis = GLKMatrix3MultiplyVector3(axisRotationMatrixInv, axis);
    
    GLKQuaternion rotation = GLKQuaternionMakeWithAngleAndAxis(phi, transformedAxis.x, transformedAxis.y, transformedAxis.z);
    self.property.position = GLKVector3Add(GLKQuaternionRotateVector3(rotation, GLKVector3Subtract(self.property.position, _center)), _center);
    self.property.focus = GLKQuaternionRotateVector3(rotation, self.property.focus);
    self.property.upVector = GLKQuaternionRotateVector3(rotation, self.property.upVector);
    
    _panLastPosition = [panRecognizer locationInView:self.view];
    _panLastPosition.x /= self.view.frame.size.width;
    _panLastPosition.y /= self.view.frame.size.height;
    [panRecognizer setTranslation:CGPointMake(0.f, 0.f) inView:self.view];
    
    [(GLKView*)self.view display];
    [[NSNotificationCenter defaultCenter] postNotificationName:PropertyValueChangedNotification object:self.property];
}

- (IBAction)handleDoublePan:(UIGestureRecognizer *)recognizer {
    UIPanGestureRecognizer* panRecognizer = (UIPanGestureRecognizer*)recognizer;
    
    CGPoint translation = [panRecognizer translationInView:self.view];
    translation.x /= self.view.frame.size.width;
    translation.x *= -5.f;
    translation.y /= self.view.frame.size.height;
    translation.y *= 5.f;
    GLKVector3 translationVector = GLKVector3Make(translation.x, translation.y, 0.f);
    
    GLKMatrix3 rotationMatrix = GLKMatrix4GetMatrix3(self.effect.transform.modelviewMatrix);
    bool invertible;
    GLKMatrix3 rotationMatrixInv = GLKMatrix3Invert(rotationMatrix, &invertible);
    if (!invertible)
        ALog(@"Matrix not invertible");
    
    GLKVector3 transformedTranslation = GLKMatrix3MultiplyVector3(rotationMatrixInv, translationVector);
    
    self.property.position = GLKVector3Add(self.property.position, transformedTranslation);
    self.property.focus = GLKVector3Add(self.property.focus, transformedTranslation);
 
    [panRecognizer setTranslation:CGPointMake(0.f, 0.f) inView:self.view];
    [(GLKView*)self.view display];

    [[NSNotificationCenter defaultCenter] postNotificationName:PropertyValueChangedNotification object:self.property];
}

- (IBAction)handlePinch:(UIGestureRecognizer *)recognizer {
    UIPinchGestureRecognizer* pinchRecognizer = (UIPinchGestureRecognizer*)recognizer;
    CGFloat scale = pinchRecognizer.scale;

    GLKVector3 direction = GLKVector3Subtract(self.property.position, self.property.focus);
    direction = GLKVector3MultiplyScalar(direction, 1.f / scale);
    
    self.property.position = GLKVector3Add(self.property.focus, direction);
    
    pinchRecognizer.scale = 1.f;
    [(GLKView*)self.view display];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PropertyValueChangedNotification object:self.property];
 
}

- (IBAction)handleRotate:(UIGestureRecognizer *)recognizer {
    UIRotationGestureRecognizer* rotateRecognizer = (UIRotationGestureRecognizer*)recognizer;
    CGFloat angle = rotateRecognizer.rotation;
    
  
    GLKVector3 position = GLKVector3Make(self.property.position.x - 1.f, self.property.position.y - 1.f, self.property.position.z - 1.f);
    GLKVector3 axis = GLKVector3Subtract(position, self.property.focus);
//    GLKVector3 axis = GLKVector3Subtract(self.property.position, self.property.focus);
    GLKMatrix3 rotationMatrix = GLKMatrix3MakeRotation(angle, axis.x, axis.y, axis.z);
    
    self.property.upVector = GLKMatrix3MultiplyVector3(rotationMatrix, self.property.upVector);
    rotateRecognizer.rotation = 0.f;
    [(GLKView*)self.view display];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PropertyValueChangedNotification object:self.property];    
}

- (GLKVector3)projectToSphere:(GLKVector2)point {
    GLKVector3 result;
    const float sqrt2 = sqrtf(2.f);
    
    const float length = GLKVector2Length(point);
    if (length < _size * sqrt2 / 2.f) {
        result.z = sqrtf(_size * _size - length * length);
    }
    else {
        float t = _size / sqrt2;
        result.z = t * t / length;
    }
    
    result.x = point.x;
    result.y = point.y;
    return GLKVector3Normalize(result);
    
}


@end
