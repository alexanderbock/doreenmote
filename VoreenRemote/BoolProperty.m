//
//  BoolProperty.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "BoolProperty.h"
#import "NSLogAddition.h"

@implementation BoolProperty

- (id)initWithXML:(TBXMLElement*)element {
    self = [super initWithXML:element];
    
    if (![self parseValueFromElement:element identifier:@"value" target:&_value])
        return nil;
    
    return self;
}

- (void)setCurrentValue:(BOOL)currentValue {
    if (currentValue)
        self.value = @"true";
    else
        self.value = @"false";
}

- (BOOL)currentValue {
    return [self.value booleanValue];
}

- (NSString*)pythonStringParameter {
    if ([self.value booleanValue])
        return @"1";
    else
        return @"0";
}

@end
