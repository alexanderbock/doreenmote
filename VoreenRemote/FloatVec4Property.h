//
//  FloatVec4Property.h
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "Property.h"

@interface FloatVec4Property : Property

- (float)minimumValueForColumn:(NSInteger)column;
- (float)maximumValueForColumn:(NSInteger)column;
- (float)currentValueForColumn:(NSInteger)column;
- (void)setCurrentValue:(float)value forColumn:(NSInteger)column;

@end
