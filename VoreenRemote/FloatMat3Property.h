//
//  FloatMat3Property.h
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "Property.h"

@interface FloatMat3Property : Property

- (float)minimumValueForRow:(NSInteger)row column:(NSInteger)column;
- (float)maximumValueForRow:(NSInteger)row column:(NSInteger)column;
- (float)currentValueForRow:(NSInteger)row column:(NSInteger)column;
- (void)setCurrentValue:(float)value forRow:(NSInteger)row column:(NSInteger)column;

@end
