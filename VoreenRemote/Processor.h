//
//  Processor.h
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Processor : NSObject {
    NSString* _name;
    NSString* _type;
    NSArray* _properties;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* type;
@property (nonatomic, retain) NSArray* properties;

@end
