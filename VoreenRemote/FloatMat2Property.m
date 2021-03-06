//
//  FloatMat2Property.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "FloatMat2Property.h"

@implementation FloatMat2Property

- (id)initWithXML:(TBXMLElement *)element {
    self = [super initWithXML:element];
    
    if (![self parseMat2FromElement:element identifier:@"value" target:&_value])
        return nil;
    
    NSMutableDictionary* state = [NSMutableDictionary dictionaryWithCapacity:2];
    if (![self parseMat2FromElement:element identifier:minValue target:&state])
        return nil;
    if (![self parseMat2FromElement:element identifier:maxValue target:&state])
        return nil;
    self.state = state;
    
    return self;
}

- (float)minimumValueForRow:(NSInteger)row column:(NSInteger)column {
    NSDictionary* dict = [self.state objectForKey:minValue];
    NSDictionary* rowDict = [dict objectForKey:[NSString stringWithFormat:@"minValue.row%i", row]];
    NSString* colString;
    switch (column) {
        case 0:
            colString = @"x";
            break;
        case 1:
            colString = @"y";
            break;
    }
    return [[rowDict objectForKey:colString] floatValue];
}

- (float)maximumValueForRow:(NSInteger)row column:(NSInteger)column {
    NSDictionary* dict = [self.state objectForKey:maxValue];
    NSDictionary* rowDict = [dict objectForKey:[NSString stringWithFormat:@"maxValue.row%i", row]];
    NSString* colString;
    switch (column) {
        case 0:
            colString = @"x";
            break;
        case 1:
            colString = @"y";
            break;
    }
    return [[rowDict objectForKey:colString] floatValue];
}

- (float)currentValueForRow:(NSInteger)row column:(NSInteger)column {
    NSDictionary* rowDict = [self.value objectForKey:[NSString stringWithFormat:@"value.row%i", row]];
    NSString* colString;
    switch (column) {
        case 0:
            colString = @"x";
            break;
        case 1:
            colString = @"y";
            break;
    }
    return [[rowDict objectForKey:colString] floatValue];
}

- (void)setCurrentValue:(float)value forRow:(NSInteger)row column:(NSInteger)column {
    NSMutableDictionary* rowDict = [self.value objectForKey:[NSString stringWithFormat:@"value.row%i", row]];
    NSString* colString;
    switch (column) {
        case 0:
            colString = @"x";
            break;
        case 1:
            colString = @"y";
            break;
    }
    [rowDict setObject:[NSString stringWithFormat:@"%f", value] forKey:colString];
}

- (NSString*)pythonString {
    return [NSString stringWithFormat:@"((%f,%f),(%f,%f))",
                        [self currentValueForRow:0 column:0], [self currentValueForRow:0 column:1],
                        [self currentValueForRow:1 column:0], [self currentValueForRow:1 column:1]];
}

@end
