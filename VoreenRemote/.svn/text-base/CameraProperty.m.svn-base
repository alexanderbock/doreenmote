//
//  CameraProperty.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "CameraProperty.h"
#import "NSLogAddition.h"

//NSString* adjustProjectionToViewport = @"adjustProjectionToViewport";
//NSString* projectionMode = @"projectionMode";
//NSString* frustLeft = @"frustLeft";
//NSString* frustRight = @"frustRight";
//NSString* frustBottom = @"frustBottom";
//NSString* frustTop = @"frustTop";
//NSString* frustNear = @"frustNear";
//NSString* frustFar = @"frustFar";
//NSString* fovy = @"fovy";
NSString* position = @"position";
NSString* focus = @"focus";
NSString* upVector = @"upVector";

@implementation CameraProperty

- (id)initWithXML:(TBXMLElement*)element {
    self = [super initWithXML:element];
    
    NSMutableDictionary* state = [NSMutableDictionary dictionaryWithCapacity:13];
//    if (![self parseValueFromElement:element identifier:adjustProjectionToViewport target:&state])
//        return nil;
//    if (![self parseValueFromElement:element identifier:projectionMode target:&state])
//        return nil;
//    if (![self parseValueFromElement:element identifier:frustLeft target:&state])
//        return nil;
//    if (![self parseValueFromElement:element identifier:frustRight target:&state])
//        return nil;
//    if (![self parseValueFromElement:element identifier:frustBottom target:&state])
//        return nil;
//    if (![self parseValueFromElement:element identifier:frustTop target:&state])
//        return nil;
//    if (![self parseValueFromElement:element identifier:frustNear target:&state])
//        return nil;
//    if (![self parseValueFromElement:element identifier:frustFar target:&state])
//        return nil;
//    if (![self parseValueFromElement:element identifier:fovy target:&state])
//        return nil;
    if (![self parseVec3FromElement:element identifier:position target:&state])
        return nil;
    if (![self parseVec3FromElement:element identifier:focus target:&state])
        return nil;
    if (![self parseVec3FromElement:element identifier:upVector target:&state])
        return nil;
    
    NSDictionary* positionDict = [state objectForKey:position];
    self.position = GLKVector3Make([[positionDict objectForKey:@"x"] floatValue],
                                   [[positionDict objectForKey:@"y"] floatValue],
                                   [[positionDict objectForKey:@"z"] floatValue]);
    
    NSDictionary* focusDict = [state objectForKey:focus];
    self.focus = GLKVector3Make([[focusDict objectForKey:@"x"] floatValue],
                                   [[focusDict objectForKey:@"y"] floatValue],
                                   [[focusDict objectForKey:@"z"] floatValue]);

    NSDictionary* upVectorDict = [state objectForKey:upVector];
    self.upVector = GLKVector3Make([[upVectorDict objectForKey:@"x"] floatValue],
                                   [[upVectorDict objectForKey:@"y"] floatValue],
                                   [[upVectorDict objectForKey:@"z"] floatValue]);

    return self;
}

- (NSString*)pythonStringParameter {
    return [NSString stringWithFormat:@"((%f,%f,%f),(%f,%f,%f),(%f,%f,%f))",
            self.position.x, self.position.y, self.position.z,
            self.focus.x, self.focus.y, self.focus.z,
            self.upVector.x, self.upVector.y, self.upVector.z];
}

@end
