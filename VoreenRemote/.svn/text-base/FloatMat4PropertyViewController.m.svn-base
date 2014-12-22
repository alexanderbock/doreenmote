//
//  FloatMat4PropertyViewController.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "FloatMat4PropertyViewController.h"
#import "NSLogAddition.h"
#import "common.h"

@implementation FloatMat4PropertyViewController

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
@synthesize value03;
@synthesize value13;
@synthesize value23;
@synthesize value30;
@synthesize value31;
@synthesize value32;
@synthesize value33;

- (id)initWithProperty:(Property*)property {
    self = [super initWithNibName:@"FloatMat4PropertyViewController" bundle:nil];
    
    if (![property isKindOfClass:[FloatMat4Property class]])
        ULog(@"Property is not of Class FloatMat4Property");

    self.property = (FloatMat4Property*)property;
    return self;        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = [self.property name];
    self.value00.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:0 column:0]];
    self.value01.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:0 column:1]];
    self.value02.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:0 column:2]];
    self.value03.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:0 column:3]];
    self.value10.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:1 column:0]];
    self.value11.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:1 column:1]];
    self.value12.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:1 column:2]];
    self.value13.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:1 column:3]];
    self.value20.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:2 column:0]];
    self.value21.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:2 column:1]];
    self.value22.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:2 column:2]];
    self.value23.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:2 column:3]];
    self.value30.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:3 column:0]];
    self.value31.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:3 column:1]];
    self.value32.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:3 column:2]];
    self.value33.text = [NSString stringWithFormat:@"%f", [self.property currentValueForRow:3 column:3]];
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
    [value03 release];
    [value13 release];
    [value23 release];
    [value30 release];
    [value31 release];
    [value32 release];
    [value33 release];
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
    [self setValue03:nil];
    [self setValue13:nil];
    [self setValue23:nil];
    [self setValue30:nil];
    [self setValue31:nil];
    [self setValue32:nil];
    [self setValue33:nil];
    [super viewDidUnload];
}

- (NSInteger)rowForTextfield:(UITextField*)field {
    if ((field == self.value00) || (field == self.value01) || (field == self.value02) || (field == self.value03))
        return 0;
    else if ((field == self.value10) || (field == self.value11) || (field == self.value12) || (field == self.value13))
        return 1;
    else if ((field == self.value20) || (field == self.value21) || (field == self.value22) || (field == self.value23))
        return 2;
    else
        return 3;
}

- (NSInteger)columnForTextfield:(UITextField*)field {
    if ((field == self.value00) || (field == self.value10) || (field == self.value20) || (field == self.value30))
        return 0;
    else if ((field == self.value01) || (field == self.value11) || (field == self.value21) || (field == self.value31))
        return 1;
    else if ((field == self.value02) || (field == self.value12) || (field == self.value22) || (field == self.value23))
        return 2;
    else
        return 3;
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
