//
//  CameraProperty.h
//  Doreemote
//
//  Created by Alexander Bock on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Property.h"

#import <GLKit/GLKit.h>

@interface CameraProperty : Property

- (id)initWithXML:(TBXMLElement*)element;

@property (nonatomic) GLKVector3 position;
@property (nonatomic) GLKVector3 focus;
@property (nonatomic) GLKVector3 upVector;

@end
