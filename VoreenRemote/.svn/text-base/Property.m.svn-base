//
//  Property.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "Property.h"
#import "NSLogAddition.h"

NSString* minValue = @"minValue";
NSString* maxValue = @"maxValue";
NSString* x = @"x";
NSString* y = @"y";
NSString* z = @"z";
NSString* w = @"w";
NSString* row0 = @"row0";
NSString* row1 = @"row1";
NSString* row2 = @"row2";
NSString* row3 = @"row3";

@implementation Property

- (id)initWithXML:(TBXMLElement*)element {
    self = [super init];
    
    NSError* error = 0;
    NSString* identifier = [TBXML valueOfAttributeNamed:@"name" forElement:element error:&error];
    if (error != 0) {
        [self logErrorAttribute:@"name" error:error];
        return nil;
        
    }
    self.identifier = identifier;
    
    NSString* name = [TBXML valueOfAttributeNamed:@"guiName" forElement:element error:&error];
    if (error != 0) {
        [self logErrorAttribute:@"guiName" error:error];
        return nil;
    }
    self.name = name;
    
    NSString* type = [TBXML valueOfAttributeNamed:@"type" forElement:element error:&error];
    if (error != 0) {
        [self logErrorAttribute:@"type" error:error];
        return nil;
    }
    
    if ([type hasSuffix:@"OptionProperty"])
        type = @"OptionProperty";
    self.type = type;
    
    NSString* lod = [TBXML valueOfAttributeNamed:@"lod" forElement:element];
    if (lod == nil)
        self.isVisible = YES;
    else
        self.isVisible = NO;
    
    return self;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"{\nName: %@,\nIdentifier: %@,\nType: %@,\nValue: %@,\nState: %@}", _name, _identifier, _type, _value, _state];
}

- (void)logErrorAttribute:(NSString*)attributeName error:(NSError*)error {
    ALog(@"Error occurred while parsing '%@'. %@", attributeName, error);    
}

- (BOOL)parseValueFromElement:(TBXMLElement*)element identifier:(NSString*)identifier target:(id*)target {
    NSError* error = 0;
    NSString* value = [TBXML valueOfAttributeNamed:identifier forElement:element error:&error];
    if (error != 0) {
        [self logErrorAttribute:identifier error:error];
        return NO;
    }
    
    if ([*target isKindOfClass:[NSMutableDictionary class]])
        [*target setObject:value forKey:identifier];
    else
        *target = [value retain];
    
    return YES;
}

- (BOOL)parseVec2FromElement:(TBXMLElement*)element identifier:(NSString*)identifier target:(id*)target {
    NSError* error = 0;
    TBXMLElement* childElement = [TBXML childElementNamed:identifier parentElement:element error:&error];
    if (error != 0) {
        [self logErrorAttribute:identifier error:error];
        return NO;
    }
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:3];
    NSString* xVal = [TBXML valueOfAttributeNamed:@"x" forElement:childElement error:&error];
    if (error != 0) {
        [self logErrorAttribute:@"NAME X" error:error];
        return NO;
    }
    [dict setObject:xVal forKey:x];
    NSString* yVal = [TBXML valueOfAttributeNamed:@"y" forElement:childElement error:&error];
    if (error != 0) {
        [self logErrorAttribute:@"NAME Y" error:error];
        return NO;
    }
    [dict setObject:yVal forKey:y];
    
    if ([*target isKindOfClass:[NSMutableDictionary class]])
        [*target setObject:dict forKey:identifier];
    else
        *target = dict;
    
    return YES;
}

- (BOOL)parseVec3FromElement:(TBXMLElement*)element identifier:(NSString*)identifier target:(id*)target {
    NSError* error = 0;
    TBXMLElement* childElement = [TBXML childElementNamed:identifier parentElement:element error:&error];
    if (error != 0) {
        [self logErrorAttribute:identifier error:error];
        return NO;
    }
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:3];
    NSString* xVal = [TBXML valueOfAttributeNamed:@"x" forElement:childElement error:&error];
    if (error != 0) {
        [self logErrorAttribute:@"NAME X" error:error];
        return NO;
    }
    [dict setObject:xVal forKey:x];
    NSString* yVal = [TBXML valueOfAttributeNamed:@"y" forElement:childElement error:&error];
    if (error != 0) {
        [self logErrorAttribute:@"NAME Y" error:error];
        return NO;
    }
    [dict setObject:yVal forKey:y];
    NSString* zVal = [TBXML valueOfAttributeNamed:@"z" forElement:childElement error:&error];
    if (error != 0) {
        [self logErrorAttribute:@"NAME Z" error:error];
        return NO;
    }
    [dict setObject:zVal forKey:z];
    
    if ([*target isKindOfClass:[NSMutableDictionary class]])
        [*target setObject:dict forKey:identifier];
    else
        *target = dict;
    
    return YES;    
}

- (BOOL)parseVec4FromElement:(TBXMLElement*)element identifier:(NSString*)identifier target:(id*)target {
    NSError* error = 0;
    TBXMLElement* childElement = [TBXML childElementNamed:identifier parentElement:element error:&error];
    if (error != 0) {
        [self logErrorAttribute:identifier error:error];
        return NO;
    }
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:3];
    NSString* xVal = [TBXML valueOfAttributeNamed:@"x" forElement:childElement error:&error];
    if (error != 0) {
        [self logErrorAttribute:@"NAME X" error:error];
        return NO;
    }
    [dict setObject:xVal forKey:x];
    NSString* yVal = [TBXML valueOfAttributeNamed:@"y" forElement:childElement error:&error];
    if (error != 0) {
        [self logErrorAttribute:@"NAME Y" error:error];
        return NO;
    }
    [dict setObject:yVal forKey:y];
    NSString* zVal = [TBXML valueOfAttributeNamed:@"z" forElement:childElement error:&error];
    if (error != 0) {
        [self logErrorAttribute:@"NAME Z" error:error];
        return NO;
    }
    [dict setObject:zVal forKey:z];
    NSString* wVal = [TBXML valueOfAttributeNamed:@"w" forElement:childElement error:&error];
    if (error != 0) {
        [self logErrorAttribute:@"NAME W" error:error];
        return NO;
    }
    [dict setObject:wVal forKey:w];
    
    if ([*target isKindOfClass:[NSMutableDictionary class]])
        [*target setObject:dict forKey:identifier];
    else
        *target = dict;
    
    return YES;
}

- (BOOL)parseMat2FromElement:(TBXMLElement*)element identifier:(NSString*)identifier target:(id*)target {
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:2];
    NSString* row0String = [NSString stringWithFormat:@"%@.row0", identifier];
    if (![self parseVec2FromElement:element identifier:row0String target:&dict])
        return NO;
    
    NSString* row1String = [NSString stringWithFormat:@"%@.row1", identifier];
    if (![self parseVec2FromElement:element identifier:row1String target:&dict])
        return NO;
    
    if ([*target isKindOfClass:[NSMutableDictionary class]])
        [*target setObject:dict forKey:identifier];
    else
        *target = dict;

    return YES;
}

- (BOOL)parseMat3FromElement:(TBXMLElement*)element identifier:(NSString*)identifier target:(id*)target {
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:3];
    NSString* row0String = [NSString stringWithFormat:@"%@.row0", identifier];
    if (![self parseVec3FromElement:element identifier:row0String target:&dict])
        return NO;
    
    NSString* row1String = [NSString stringWithFormat:@"%@.row1", identifier];
    if (![self parseVec3FromElement:element identifier:row1String target:&dict])
        return NO;
    
    NSString* row2String = [NSString stringWithFormat:@"%@.row2", identifier];
    if (![self parseVec3FromElement:element identifier:row2String target:&dict])
        return NO;

    if ([*target isKindOfClass:[NSMutableDictionary class]])
        [*target setObject:dict forKey:identifier];
    else
        *target = dict;
    
    return YES;

}

- (BOOL)parseMat4FromElement:(TBXMLElement*)element identifier:(NSString*)identifier target:(id*)target {
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:4];
    NSString* row0String = [NSString stringWithFormat:@"%@.row0", identifier];
    if (![self parseVec4FromElement:element identifier:row0String target:&dict])
        return NO;
    
    NSString* row1String = [NSString stringWithFormat:@"%@.row1", identifier];
    if (![self parseVec4FromElement:element identifier:row1String target:&dict])
        return NO;
    
    NSString* row2String = [NSString stringWithFormat:@"%@.row2", identifier];
    if (![self parseVec4FromElement:element identifier:row2String target:&dict])
        return NO;
    
    NSString* row3String = [NSString stringWithFormat:@"%@.row3", identifier];
    if (![self parseVec4FromElement:element identifier:row3String target:&dict])
        return NO;
    
    if ([*target isKindOfClass:[NSMutableDictionary class]])
        [*target setObject:dict forKey:identifier];
    else
        *target = dict;
    
    return YES;
}

- (NSString*)pythonString {
    return [NSString stringWithFormat:@"voreen.setPropertyValue(\"%@\", \"%@\", %@);\r\n", self.processor.name, self.identifier, [self pythonStringParameter]];
}

- (NSString*)pythonStringParameter {
    return @"\"\"";
}

@end
