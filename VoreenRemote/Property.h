//
//  Property.h
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
#import "NSString_BooleanCast.h"
#import "Processor.h"

extern NSString* minValue;
extern NSString* maxValue;
extern NSString* x;
extern NSString* y;
extern NSString* z;
extern NSString* w;
extern NSString* row0;
extern NSString* row1;
extern NSString* row2;
extern NSString* row3;

@interface Property : NSObject {
    NSString* _name;
    NSString* _identifier;
    NSString* _type;
    Processor* _processor;
    id _value;
    BOOL _isVisible;
    NSDictionary* _state;
}

- (id)initWithXML:(TBXMLElement*)element;
- (void)logErrorAttribute:(NSString*)attributeName error:(NSError*)error;

- (BOOL)parseValueFromElement:(TBXMLElement*)element identifier:(NSString*)identifier target:(id*)target;

- (BOOL)parseVec2FromElement:(TBXMLElement*)element identifier:(NSString*)identifier target:(id*)target;
- (BOOL)parseVec3FromElement:(TBXMLElement*)element identifier:(NSString*)identifier target:(id*)target;
- (BOOL)parseVec4FromElement:(TBXMLElement*)element identifier:(NSString*)identifier target:(id*)target;

- (BOOL)parseMat2FromElement:(TBXMLElement*)element identifier:(NSString*)identifier target:(id*)target;
- (BOOL)parseMat3FromElement:(TBXMLElement*)element identifier:(NSString*)identifier target:(id*)target;
- (BOOL)parseMat4FromElement:(TBXMLElement*)element identifier:(NSString*)identifier target:(id*)target;

- (NSString*)pythonString;
- (NSString*)pythonStringParameter;

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* identifier;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, assign) Processor* processor;
@property (nonatomic, retain) id value;
@property (nonatomic, getter=isVisible, setter=setVisible:) BOOL isVisible;
@property (nonatomic, retain) NSDictionary* state;

@end
