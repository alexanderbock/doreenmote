//
//  FloatVec2Property.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "FloatVec2Property.h"

@implementation FloatVec2Property

- (id)initWithXML:(TBXMLElement *)element {
    self = [super initWithXML:element];
    
    if (![self parseVec2FromElement:element identifier:@"value" target:&_value])
        return nil;
    
    NSMutableDictionary* state = [NSMutableDictionary dictionaryWithCapacity:2];
    if (![self parseVec2FromElement:element identifier:minValue target:&state])
        return nil;
    if (![self parseVec2FromElement:element identifier:maxValue target:&state])
        return nil;
    self.state = state;
    
    return self;
}

- (float)minimumValueForColumn:(NSInteger)column {
    NSDictionary* dict = [self.state objectForKey:minValue];
    NSString* colString;
    switch (column) {
        case 0:
            colString = @"x";
            break;
        case 1:
            colString = @"y";
            break;
    }
    return [[dict objectForKey:colString] floatValue];
}

- (float)maximumValueForColumn:(NSInteger)column {
    NSDictionary* dict = [self.state objectForKey:maxValue];
    NSString* colString;
    switch (column) {
        case 0:
            colString = @"x";
            break;
        case 1:
            colString = @"y";
            break;
    }
    return [[dict objectForKey:colString] floatValue];
}

- (float)currentValueForColumn:(NSInteger)column {
    NSString* colString;
    switch (column) {
        case 0:
            colString = @"x";
            break;
        case 1:
            colString = @"y";
            break;
    }
    return [[self.value objectForKey:colString] floatValue];
}

- (void)setCurrentValue:(float)value forColumn:(NSInteger)column {
    NSString* colString;
    switch (column) {
        case 0:
            colString = @"x";
            break;
        case 1:
            colString = @"y";
            break;
    }
    [self.value setObject:[NSString stringWithFormat:@"%f", value] forKey:colString];
}

- (NSString*)pythonStringParameter {
    return [NSString stringWithFormat:@"(%f,%f)", [self currentValueForColumn:0], [self currentValueForColumn:1]];
}

@end
