//
//  NSString_BooleanCast.h
//  Doreemote
//
//  Created by Alexander Bock on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString_BooleanCast.h"

@implementation NSString (BooleanCast)

- (BOOL)booleanValue {
    if ([self isEqualToString:@"false"])
        return NO;
    else if ([self isEqualToString:@"true"])
        return YES;
    else
        return [self boolValue];
}

@end
