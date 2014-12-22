//
//  IntVec2Property.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "IntVec2Property.h"

@implementation IntVec2Property

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

- (NSInteger)minimumValueForColumn:(NSInteger)column {
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
    return [[dict objectForKey:colString] intValue];
}

- (NSInteger)maximumValueForColumn:(NSInteger)column {
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
    return [[dict objectForKey:colString] intValue];
}

- (NSInteger)currentValueForColumn:(NSInteger)column {
    NSString* colString;
    switch (column) {
        case 0:
            colString = @"x";
            break;
        case 1:
            colString = @"y";
            break;
    }
    return [[self.value objectForKey:colString] intValue];    
}

- (void)setCurrentValue:(NSInteger)value forColumn:(NSInteger)column {
    NSString* colString;
    switch (column) {
        case 0:
            colString = @"x";
            break;
        case 1:
            colString = @"y";
            break;
    }
    [self.value setObject:[NSString stringWithFormat:@"%i", value] forKey:colString];
}

- (NSString*)pythonStringParameter {
    return [NSString stringWithFormat:@"(%i,%i)", [self currentValueForColumn:0], [self currentValueForColumn:1]];
}

@end
