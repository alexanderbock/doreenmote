//
//  OptionProperty.m
//  Doreemote
//
//  Created by Alexander Bock on.
//  Copyright (c) 2012. All rights reserved.
//

#import "OptionProperty.h"

@implementation OptionProperty

- (id)initWithXML:(TBXMLElement *)element {
    self = [super initWithXML:element];
    
    if (![self parseValueFromElement:element identifier:@"value" target:&_value])
        return nil;

    NSError* error = 0;
    
    TBXMLElement* keysElem = [TBXML childElementNamed:@"keys" parentElement:element error:&error];
    if (error != 0) {
        [self logErrorAttribute:@"keys" error:error];
        return nil;
    }
    
    TBXMLElement* keyElem = keysElem->firstChild;
    if (keyElem == 0) {
        [self logErrorAttribute:@"keys" error:error];
        return nil;        
    }
    NSMutableArray* keysArray = [NSMutableArray arrayWithCapacity:5];
    do {
        NSString* value = [TBXML valueOfAttributeNamed:@"value" forElement:keyElem error:&error];
        if (error != 0) {
            [self logErrorAttribute:@"key-value" error:error];
            return nil;
        }
        [keysArray addObject:value];
    } while ((keyElem = keyElem->nextSibling));
    
    self.state = [NSDictionary dictionaryWithObject:keysArray forKey:@"keys"];
    
    return self;
}

- (void)setCurrentValue:(NSString *)currentValue {
    self.value = currentValue;
}

- (NSString*)currentValue {
    return self.value;
}

- (NSArray*)possibleValues {
    return [self.state objectForKey:@"keys"];
}

- (NSString*)pythonStringParameter {
    return [NSString stringWithFormat:@"\"%@\"", [self currentValue]];
}

@end
