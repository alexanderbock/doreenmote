//
//  IntegerProperty.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "IntegerProperty.h"

@implementation IntegerProperty

- (id)initWithXML:(TBXMLElement *)element {
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

- (void)setCurrentValue:(NSInteger)value {
    self.value = [NSString stringWithFormat:@"%i", value];
}

- (NSInteger)minimumValue {
    return [[self.state objectForKey:minValue] intValue];
}

- (NSInteger)maximumValue {
    return [[self.state objectForKey:maxValue] intValue];
}

- (NSInteger)currentValue {
    return [self.value intValue];
}

- (NSString*)pythonString {
    return [NSString stringWithFormat:@"%i", [self currentValue]];
}

@end
