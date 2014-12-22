//
//  TransFuncProperty.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

NSString* type = @"type";
NSString* lower = @"lower";
NSString* upper = @"upper";
NSString* keys = @"Keys";

#import "TransFuncProperty.h"
#import "NSLogAddition.h"
#import "NSString_BooleanCast.h"

@implementation TransFuncProperty

- (id)initWithXML:(TBXMLElement *)element {
    self = [super initWithXML:element];
    NSError* error = 0;
    TBXMLElement* transferFuncElement = [TBXML childElementNamed:@"TransferFunction" parentElement:element error:&error];
    if (error != 0) {
        [self logErrorAttribute:@"TransferFunction" error:error];
        return nil;
    }
    
    NSMutableDictionary* state = [NSMutableDictionary dictionaryWithCapacity:3];
    if (![self parseValueFromElement:transferFuncElement identifier:type target:&state])
        return nil;
    if (![self parseValueFromElement:transferFuncElement identifier:lower target:&state])
        return nil;
    if (![self parseValueFromElement:transferFuncElement identifier:upper target:&state])
        return nil;
    
    TBXMLElement* keysElement = [TBXML childElementNamed:keys parentElement:transferFuncElement error:&error];
    if (error != 0) {
        [self logErrorAttribute:@"Keys" error:error];
        return nil;
    }
    
    TBXMLElement* keyElement = keysElement->firstChild;
    NSMutableArray* keysArray = [NSMutableArray arrayWithCapacity:5];
    if (keysElement == 0) {
        ALog(@"Error parsing keys");
        return nil;
    }
    
    do {
        NSMutableDictionary* keyDict = [NSMutableDictionary dictionaryWithCapacity:5];
        if (![self parseValueFromElement:keyElement identifier:@"intensity" target:&keyDict])
            return nil;
        if (![self parseValueFromElement:keyElement identifier:@"split" target:&keyDict])
            return nil;
        
        TBXMLElement* colorLElement = [TBXML childElementNamed:@"colorL" parentElement:keyElement error:&error];
        if (error != 0) {
            [self logErrorAttribute:@"colorL" error:error];
            return nil;
        }
        NSMutableDictionary* colorLDict = [NSMutableDictionary dictionaryWithCapacity:4];
        if (![self parseValueFromElement:colorLElement identifier:@"r" target:&colorLDict])
            return nil;
        if (![self parseValueFromElement:colorLElement identifier:@"g" target:&colorLDict])
            return nil;
        if (![self parseValueFromElement:colorLElement identifier:@"b" target:&colorLDict])
            return nil;
        if (![self parseValueFromElement:colorLElement identifier:@"a" target:&colorLDict])
            return nil;
        [keyDict setObject:colorLDict forKey:@"colorL"];
        
        
        if ([[keyDict objectForKey:@"split"] booleanValue]) {
            TBXMLElement* colorRElement = [TBXML childElementNamed:@"colorR" parentElement:keyElement error:&error];
            if (error != 0) {
                [self logErrorAttribute:@"colorR" error:error];
                return nil;
            }
            NSMutableDictionary* colorRDict = [NSMutableDictionary dictionaryWithCapacity:4];
            if (![self parseValueFromElement:colorRElement identifier:@"r" target:&colorRDict])
                return nil;
            if (![self parseValueFromElement:colorRElement identifier:@"g" target:&colorRDict])
                return nil;
            if (![self parseValueFromElement:colorRElement identifier:@"b" target:&colorRDict])
                return nil;
            if (![self parseValueFromElement:colorRElement identifier:@"a" target:&colorRDict])
                return nil;
            [keyDict setObject:colorRDict forKey:@"colorR"];
        }
        [keysArray addObject:keyDict];
        [state setObject:keysArray forKey:keys];
    } while ((keyElement = keyElement->nextSibling));
    self.state = state;
    
    return self;
}

@end
