//
//  IntVec4Property.h
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "Property.h"

@interface IntVec4Property : Property

- (NSInteger)minimumValueForColumn:(NSInteger)column;
- (NSInteger)maximumValueForColumn:(NSInteger)column;
- (NSInteger)currentValueForColumn:(NSInteger)column;
- (void)setCurrentValue:(NSInteger)value forColumn:(NSInteger)column;

@end
