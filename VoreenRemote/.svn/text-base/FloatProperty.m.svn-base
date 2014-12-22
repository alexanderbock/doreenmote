//
//  FloatProperty.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "FloatProperty.h"

@implementation FloatProperty

- (id)initWithXML:(TBXMLElement*)element {
    self = [super initWithXML:element];

    if (![self parseValueFromElement:element identifier:@"value" target:&_value])
        return nil;
    NSMutableDictionary* state = [NSMutableDictionary dictionaryWithCapacity:2];
    if (![self parseValueFromElement:element identifier:minValue target:&state])
        return nil;
    if (![self parseValueFromElement:element identifier:maxValue target:&state])
        return nil;
    self.state = state;
    
    return self;
}

- (void)setCurrentValue:(float)value {
    self.value = [NSString stringWithFormat:@"%f", value];
}

- (float)minimumValue {
    return [[self.state objectForKey:minValue] floatValue];
}

- (float)maximumValue {
    return [[self.state objectForKey:maxValue] floatValue];
}

- (float)currentValue {
    return [self.value floatValue];
}

- (NSString*)pythonStringParameter {
    return self.value;
}

@end
