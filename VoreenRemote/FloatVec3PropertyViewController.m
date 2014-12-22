//
//  FloatVec3PropertyViewController.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "FloatVec3PropertyViewController.h"
#import "NSLogAddition.h"
#import "common.h"

@implementation FloatVec3PropertyViewController

@synthesize property = _property;
@synthesize titleLabel;
@synthesize value00;
@synthesize value01;
@synthesize value02;

- (id)initWithProperty:(Property*)property {
    self = [super initWithNibName:@"FloatVec3PropertyViewController" bundle:nil];
    
    if (![property isKindOfClass:[FloatVec3Property class]])
        ULog(@"Property is not of Class FloatVec3Property");

    self.property = (FloatVec3Property*)property;
    return self;        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = [self.property name];
    self.value00.text = [NSString stringWithFormat:@"%f", [self.property currentValueForColumn:0]];
    self.value01.text = [NSString stringWithFormat:@"%f", [self.property currentValueForColumn:1]];
    self.value02.text = [NSString stringWithFormat:@"%f", [self.property currentValueForColumn:2]];
}

- (void)dealloc {
    [titleLabel release];
    [value00 release];
    [value01 release];
    [value02 release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setValue00:nil];
    [self setValue01:nil];
    [self setValue02:nil];
    [super viewDidUnload];
}

- (NSInteger)columnForTextfield:(UITextField*)field {
    if (field == self.value00)
        return 0;
    else if (field == self.value01)
        return 1;
    else
        return 2;
}

- (IBAction)valueChanged:(id)sender {
    float value = [[sender text] floatValue];
    float minValue = [self.property minimumValueForColumn:[self columnForTextfield:sender]];
    float maxValue = [self.property maximumValueForColumn:[self columnForTextfield:sender]];
        
    if (value < minValue) {
        value = minValue;
        [sender setText:[NSString stringWithFormat:@"%f", value]];
    }
    
    if (value > maxValue) {
        value = maxValue;
        [sender setText:[NSString stringWithFormat:@"%f", value]];
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
