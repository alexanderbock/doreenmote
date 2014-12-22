//
//  WorkspaceFileParser.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "WorkspaceFileParser.h"
#import "TBXML.h"
#import "NSLogAddition.h"
#import "Processor.h"
#import "Property.h"

@interface WorkspaceFileParser ()

- (Processor*)parseProcessor:(TBXMLElement*)processorElement error:(NSError**)error;
- (Property*)parseProperty:(TBXMLElement*)propertyElement error:(NSError**)error;

@property (nonatomic, retain) NSString* source;

@end

@implementation WorkspaceFileParser

@synthesize source;

- (NSArray*)parseWorkspaceFile:(NSString*)xmlSource error:(NSError**)error {
    self.source = xmlSource;
    *error = nil;
    TBXML* file = [TBXML newTBXMLWithXMLString:xmlSource error:error];
    
    if (*error != nil) {
        ALog(@"Error creating the TBXML file.\nError: %@", *error);
        ALog(@"%@", self.source);
        return nil;
    }
    
    TBXMLElement* rootElement = file.rootXMLElement;
    if (rootElement == nil) {
        ALog(@"Error accessing the rootElement.\nError: %@", *error);
        ALog(@"%@", self.source);
        return nil;
    }
    
    TBXMLElement* workspaceElement = [TBXML childElementNamed:@"Workspace" parentElement:rootElement error:error];
    if (*error != nil) {
        ALog(@"Error accessing the child element 'Workspace'.\nError: %@", *error);
        ALog(@"%@", self.source);
        return nil;
    }
    
    TBXMLElement* processorNetworkElement = [TBXML childElementNamed:@"ProcessorNetwork" parentElement:workspaceElement error:error];
    if (*error != nil) {
        ALog(@"Error accessing the child element 'ProcessorNetwork'.\nError: %@", *error);
        ALog(@"%@", self.source);
        return nil;
    }
    
    TBXMLElement* processorsElement = [TBXML childElementNamed:@"Processors" parentElement:processorNetworkElement error:error];
    if (*error != nil) {
        ALog(@"Error accessing the child element 'Processors'.\nError: %@", *error);
        ALog(@"%@", self.source);
        return nil;
    }
    
    TBXMLElement* processorElement = processorsElement->firstChild;
    if (processorElement == nil) {
        ALog(@"Error while accessing the child element 'Processor'. No processor in workspace");
        ALog(@"%@", self.source);
        return nil;
    }
    
    NSMutableArray* result = [NSMutableArray arrayWithCapacity:5];
    do {
        Processor* processor = [self parseProcessor:processorElement error:error];
        if (*error != nil)
            return nil;
        [result addObject:processor];
    } while ((processorElement = processorElement->nextSibling));
    
    return result;
}

- (Processor*)parseProcessor:(TBXMLElement*)processorElement error:(NSError**)error {
    NSString* name = [TBXML valueOfAttributeNamed:@"name" forElement:processorElement error:error];
    if (*error != nil) {
        ALog(@"Error accessing the attribute 'name'.\nError: %@", *error);
        ALog(@"%@", self.source);
        return nil;
    }
    
    NSString* type = [TBXML valueOfAttributeNamed:@"type" forElement:processorElement error:error];
    if (*error != nil) {
        ALog(@"Error accessing the attribute 'type' of processor '%@'.\nError: %@", name, *error);
        ALog(@"%@", self.source);
        return nil;
    }
    
    TBXMLElement* propertiesElement = [TBXML childElementNamed:@"Properties" parentElement:processorElement error:error];
    if (*error != nil) {
        ALog(@"Error accessing the child element 'Properties' of processor '%@'.\nError: %@", name, *error);
        ALog(@"%@", self.source);
        return nil;
    }
    
    TBXMLElement* propertyElement = propertiesElement->firstChild;

    Processor* result = [[[Processor alloc] init] autorelease];
    result.name = name;
    result.type = type;

    NSArray* properties;
    if (propertyElement == nil) {
        properties = [NSArray arrayWithObjects:nil count:0];
    }
    else {
        properties = [NSMutableArray arrayWithCapacity:5];
        do {
            Property* property = [self parseProperty:propertyElement error:error];
            if (*error != nil)
                return nil;
            if (property && property.isVisible) {
                property.processor = result;
                [(NSMutableArray*)properties addObject:property];
            }
        } while ((propertyElement = propertyElement->nextSibling));
    }
    
    result.properties = properties;
    
    return result;
}

- (Property*)parseProperty:(TBXMLElement*)propertyElement error:(NSError**)error {
    NSString* name = [TBXML valueOfAttributeNamed:@"name" forElement:propertyElement error:error];
    
    if (*error != nil) {
        ALog(@"Error accessing attribute 'name'.\nError: %@", *error);
        ALog(@"%@", self.source);
        return nil;
    }
    
    NSString* type = [TBXML valueOfAttributeNamed:@"type" forElement:propertyElement error:error];
    if (*error != nil) {
        ALog(@"Error accessing attribute 'type' of property '%@'.\nError: %@", name, *error);
        ALog(@"%@", self.source);
        return nil;
    }
    
    if ([type hasSuffix:@"OptionProperty"])
        type = @"OptionProperty";
    else if ([type isEqualToString:@"VolumeHandleProperty"])
        return nil;
    
    Class class = NSClassFromString(type);
    
    if (class == nil) {
        ALog(@"Class not found: %@", type);
        return nil;
    }
    else {    
        Property* property = [[[class alloc] initWithXML:propertyElement] autorelease];
        
        return property;
    }
}

@end
