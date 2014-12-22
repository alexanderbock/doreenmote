//
//  FloatMat2PropertyViewController.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "FloatMat2PropertyViewController.h"
#import "NSLogAddition.h"
#import "common.h"

@implementation FloatMat2PropertyViewController

@synthesize property = _property;
@synthesize titleLabel;
@synthesize value00;
@synthesize value01;
@synthesize value10;
@synthesize value11;

- (id)initWithProperty:(Property*)property {
    self = [super initWithNibName:@"FloatMat2PropertyViewController" bundle:nil];
    
    if (![property isKindOfClass:[FloatMat2Property class]])
        ULog(@"Property is not of Class FloatMat2Property");

    self.property = (FloatMat2Property*)property;
    return self;        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = [self.property name];
    self.value00.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:0 column:0]];
    self.value01.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:0 column:1]];
    self.value10.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:1 column:0]];
    self.value11.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:1 column:1]];
}

- (void)dealloc {
    [titleLabel release];
    [value00 release];
    [value01 release];
    [value10 release];
    [value11 release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setValue00:nil];
    [self setValue01:nil];
    [self setValue10:nil];
    [self setValue11:nil];
    [super viewDidUnload];
}

- (NSInteger)rowForTextfield:(UITextField*)field {
    if (field == self.value00)
        return 0;
    else if (field == self.value01)
        return 0;
    else if (field == self.value10)
        return 1;
    else
        return 1;
}

- (NSInteger)columnForTextfield:(UITextField*)field {
    if (field == self.value00)
        return 0;
    else if (field == self.value01)
        return 1;
    else if (field == self.value10)
        return 0;
    else
        return 1;
}

- (IBAction)valueChanged:(id)sender {
    float value = [[sender text] floatValue];
    float minValue = [self.property minimumValueForRow:[self rowForTextfield:sender] column:[self columnForTextfield:sender]];
    float maxValue = [self.property maximumValueForRow:[self rowForTextfield:sender] column:[self columnForTextfield:sender]];
        
    if (value < minValue) {
        value = minValue;
        [sender setText:[NSString stringWithFormat:@"%f", value]];
    }
    
    if (value > maxValue) {
        value = maxValue;
        [sender setText:[NSString stringWithFormat:@"%f", value]];
    }
    
    [self.property setCurrentValue:value forRow:[self rowForTextfield:sender] column:[self columnForTextfield:sender]];

    [[NSNotificationCenter defaultCenter] postNotificationName:PropertyValueChangedNotification object:self.property];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self valueChanged:textField];
    return YES;
}

@end
