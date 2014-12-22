//
//  FloatMat3PropertyViewController.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "FloatMat3PropertyViewController.h"
#import "NSLogAddition.h"
#import "common.h"

@implementation FloatMat3PropertyViewController

@synthesize property = _property;
@synthesize titleLabel;
@synthesize value00;
@synthesize value01;
@synthesize value10;
@synthesize value11;
@synthesize value02;
@synthesize value12;
@synthesize value20;
@synthesize value21;
@synthesize value22;

- (id)initWithProperty:(Property*)property {
    self = [super initWithNibName:@"FloatMat3PropertyViewController" bundle:nil];
    
    if (![property isKindOfClass:[FloatMat3Property class]])
        ULog(@"Property is not of Class FloatMat3Property");

    self.property = (FloatMat3Property*)property;
    return self;        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = [self.property name];
    self.value00.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:0 column:0]];
    self.value01.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:0 column:1]];
    self.value02.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:0 column:2]];
    self.value10.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:1 column:0]];
    self.value11.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:1 column:1]];
    self.value12.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:1 column:2]];
    self.value20.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:2 column:0]];
    self.value21.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:2 column:1]];
    self.value22.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:2 column:2]];
}

- (void)dealloc {
    [titleLabel release];
    [value00 release];
    [value01 release];
    [value10 release];
    [value11 release];
    [value02 release];
    [value12 release];
    [value20 release];
    [value21 release];
    [value22 release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setValue00:nil];
    [self setValue01:nil];
    [self setValue10:nil];
    [self setValue11:nil];
    [self setValue02:nil];
    [self setValue12:nil];
    [self setValue20:nil];
    [self setValue21:nil];
    [self setValue22:nil];
    [super viewDidUnload];
}

- (NSInteger)rowForTextfield:(UITextField*)field {
    if ((field == self.value00) || (field == self.value01) || (field == self.value02))
        return 0;
    else if ((field == self.value10) || (field == self.value11) || (field == self.value12))
        return 1;
    else
        return 2;
}

- (NSInteger)columnForTextfield:(UITextField*)field {
    if ((field == self.value00) || (field == self.value10) || (field == self.value20))
        return 0;
    else if ((field == self.value01) || (field == self.value11) || (field == self.value21))
        return 1;
    else
        return 2;
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
