//
//  IntVec2PropertyViewController.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "IntVec2PropertyViewController.h"
#import "NSLogAddition.h"
#import "common.h"

@implementation IntVec2PropertyViewController

@synthesize property = _property;
@synthesize titleLabel;
@synthesize value00;
@synthesize value01;

- (id)initWithProperty:(Property*)property {
    self = [super initWithNibName:@"IntVec2PropertyViewController" bundle:nil];
    
    if (![property isKindOfClass:[IntVec2Property class]])
        ULog(@"Property is not of Class IntVec2Property");

    self.property = (IntVec2Property*)property;
    return self;        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = [self.property name];
    self.value00.text = [NSString stringWithFormat:@"%i", [self.property currentValueForColumn:0]];
    self.value01.text = [NSString stringWithFormat:@"%i", [self.property currentValueForColumn:1]];
}

- (void)dealloc {
    [titleLabel release];
    [value00 release];
    [value01 release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setValue00:nil];
    [self setValue01:nil];
    [super viewDidUnload];
}

- (NSInteger)columnForTextfield:(UITextField*)field {
    if (field == self.value00)
        return 0;
    else
        return 1;
}

- (IBAction)valueChanged:(id)sender {
    int value = [[sender text] intValue];
    int minValue = [self.property minimumValueForColumn:[self columnForTextfield:sender]];
    int maxValue = [self.property maximumValueForColumn:[self columnForTextfield:sender]];
        
    if (value < minValue) {
        value = minValue;
        [sender setText:[NSString stringWithFormat:@"%i", value]];
    }
    
    if (value > maxValue) {
        value = maxValue;
        [sender setText:[NSString stringWithFormat:@"%i", value]];
    }
    
    [self.property setCurrentValue:value forColumn:[self columnForTextfield:sender]];

    [[NSNotificationCenter defaultCenter] postNotificationName:PropertyValueChangedNotification object:self.property];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self valueChanged:textField];
    return YES;
}

@end
